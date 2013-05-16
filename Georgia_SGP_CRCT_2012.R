#########################################################
###
### Calculate SGPs for Georgia - 2012
###
##########################################################

### Load SGP Package

require(SGP)

### Load Georgia SGP object

load("Data/Georgia_SGP-2012.Rdata")

#  Remove all the Old EOCT and all Baseline Matrices from object (keeping 2009-2011)

Georgia_SGP@SGP[['Coefficient_Matrices']] <- Georgia_SGP@SGP[['Coefficient_Matrices']][1:13]

##############################################################################
###
### Grade level CRCT tests
###
##############################################################################

Georgia_SGP <- analyzeSGP(
			Georgia_SGP,
			years='2012',
			content_areas=c("ELA", "READING", "MATHEMATICS", "SCIENCE", "SOCIAL_STUDIES"),
			sgp.percentiles=TRUE,
			sgp.projections=TRUE,
			sgp.projections.lagged=TRUE,
			sgp.percentiles.baseline=TRUE,
			sgp.projections.baseline=TRUE,
			sgp.projections.lagged.baseline=TRUE,
			simulate.sgps=TRUE,
			parallel.config=list(
				BACKEND="PARALLEL", 
				WORKERS=list(
					PERCENTILES=24, BASELINE_PERCENTILES=24,
					PROJECTIONS=8, LAGGED_PROJECTIONS=8)))

save(Georgia_SGP, file="Data/Georgia_SGP-2012_CRCT.Rdata")

#  Code used to output the CRCT Results for Review.  Do NOT save SGP object after reducing the @Data slot

dim(Georgia_SGP@Data)
Georgia_SGP@Data <- Georgia_SGP@Data[Georgia_SGP@Data$YEAR=='2012',]
Georgia_SGP@Data <- Georgia_SGP@Data[Georgia_SGP@Data$CONTENT_AREA %in% c("ELA", "READING", "MATHEMATICS", "SCIENCE", "SOCIAL_STUDIES") &
	Georgia_SGP@Data$GRADE %in% 3:8,]
dim(Georgia_SGP@Data)

Georgia_SGP <- combineSGP(Georgia_SGP, year='2012')

outputSGP(Georgia_SGP, output.type="LONG_Data", outputSGP.directory="CRCT_Results")
