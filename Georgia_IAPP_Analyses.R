###########################################################################
###                                                                     ###
###    Analyze SGPs for Georgia without IAPP Districts - 2018 & 2019    ###
###                                                                     ###
###########################################################################

### Load required packages
require(SGP)
require(data.table)

setwd("/media/Data/GA_IAPP")

IAPP_Districts <- c('607', '631', '772', '671', '678', '679', '781', '715', '657', '765', '637', '647', '654', '656', '689', '698', '709', '714', '717', '793')

vars.to.keep <- c("VALID_CASE", "GTID", "SCHOOL_YEAR", "SUBJECT_CODE", "YEAR_WITHIN", "GRADE", "SCALE_SCORE", "SCALE_SCORE_PRIOR",
                  "ADMINISTRATION_PERIOD", "PERFORMANCE_LEVEL", "SR_SYSTEM_ID", "SR_SCHOOL_ID", "SCHOOL_NUMBER",
                  "RACE_CODE", "GENDER_CODE", "ED", "SWD", "LEP", "GIFT", "Most_Recent_Prior",
                  "SGP_NORM_GROUP", "SGP", "SGP_SIMEX", "SGP_SIMEX_RANKED", "SGP_NORM_GROUP_SCALE_SCORES", "SGP_NOTE")

###  Load IAPP Data and Combine
load("Data/Georgia_SGP_LONG_Data_2018.Rdata")
load("Data/Georgia_SGP_LONG_Data_2019.Rdata")

Georgia_IAPP <- rbindlist(list(Georgia_SGP_LONG_Data_2018[!is.na(SGP), vars.to.keep, with=FALSE], Georgia_SGP_LONG_Data_2019[!is.na(SGP), vars.to.keep, with=FALSE]), fill=TRUE)
setnames(Georgia_IAPP, gsub("SGP", "IAPP", names(Georgia_IAPP)))

###  Load Original Data and Combine
load("/media/Data/Dropbox/SGP/Georgia/Data/Georgia_SGP_LONG_Data_2018.Rdata")
load("/media/Data/Dropbox/SGP/Georgia/Data/Georgia_SGP_LONG_Data_2019.Rdata")

Georgia_Orig <- rbindlist(list(Georgia_SGP_LONG_Data_2018[!is.na(SGP), vars.to.keep, with=FALSE], Georgia_SGP_LONG_Data_2019[!is.na(SGP), vars.to.keep, with=FALSE]), fill=TRUE)
setnames(Georgia_Orig, gsub("SGP", "ORIG", names(Georgia_Orig)))

rm(list=c("Georgia_SGP_LONG_Data_2018", "Georgia_SGP_LONG_Data_2019"))

###   Merge IAPP and Original Data

data.key <- c("GTID", "SCHOOL_YEAR", "SUBJECT_CODE", "YEAR_WITHIN", "GRADE", "SCALE_SCORE", "SCALE_SCORE_PRIOR")

Georgia_Data <- merge(Georgia_IAPP, Georgia_Orig, by=data.key, ORIG.x=TRUE)
setnames(Georgia_Data, gsub("[.]x", "", names(Georgia_Data)))

# Georgia_Data[, EM_LEV := ""] #  Don't do per Niveen
# Georgia_Data[GRADE %in% 3:5, EM_LEV := "ES"]
# Georgia_Data[GRADE %in% 6:8, EM_LEV := "MS"]
# table(Georgia_Data[, EM_LEV, SUBJECT_CODE], exclude=NULL)
#
# length(unique(Georgia_Data[, SCHOOL_NUMBER]))
# Georgia_Data[, SCHOOL_NUMBER_EM := paste0(SCHOOL_NUMBER, EM_LEV)]
# length(unique(Georgia_Data[, SCHOOL_NUMBER_EM]))
# head(Georgia_Data[SUBJECT_CODE == "ALGEBRA_I", SCHOOL_NUMBER_EM])

save(Georgia_Data, file="Data/Georgia_Data-Analysis.rda")

Georgia_Orig[, District_Membership := as.character(NA)]
Georgia_Orig[SR_SYSTEM_ID %in% IAPP_Districts, District_Membership := "IAPP"]
Georgia_Orig[!SR_SYSTEM_ID %in% IAPP_Districts, District_Membership := "Non-IAPP"]
table(Georgia_Orig[, District_Membership, SCHOOL_YEAR], exclude=NULL)

Georgia_Orig[, SCALE_SCORE_STANDARDIZED := scale(SCALE_SCORE), keyby=list(SUBJECT_CODE, SCHOOL_YEAR, GRADE)]

save(Georgia_Orig, file="Data/Georgia_Orig.rda")

#####
###    Summaries and Visualizations
#####

###   Achievement and Growth Comparisons of IAPP Members vs Rest of Georgia

ovrall.smry <- Georgia_Orig[!is.na(ORIG),
  list(Mean=round(mean(ORIG, na.rm=T), 1), Median=median(as.numeric(ORIG), na.rm=T),
       Mean_SIMEX=round(mean(ORIG_SIMEX_RANKED, na.rm=T), 1), Median_SIMEX=median(as.numeric(ORIG_SIMEX_RANKED), na.rm=T),
       Mean_SS=round(mean(SCALE_SCORE, na.rm=T), 1), Mean_Prior_SS=round(mean(SCALE_SCORE_PRIOR, na.rm=T), 1), N=.N),
  keyby=c("District_Membership", "SUBJECT_CODE", "SCHOOL_YEAR")] # "GRADE", "Most_Recent_Prior",

ovrall.smry.w <- dcast(ovrall.smry, ... ~ District_Membership, value.var = c("Mean", "Median", "Mean_SIMEX", "Median_SIMEX", "Mean_SS", "Mean_Prior_SS", "N"), sep=" ") # id.vars = c("SCHOOL_YEAR", "ACHIEVEMENT_LEVEL", "TestFormat")
ovrall.smry.w[SUBJECT_CODE=="ELA" & GRADE==4]

smry.sch <- Georgia_Orig[!is.na(ORIG),
  list(Mean_SS = round(mean(SCALE_SCORE_STANDARDIZED, na.rm=T), 1), Median_SS = median(SCALE_SCORE_STANDARDIZED, na.rm=T),
       Mean_Ranked_SIMEX = round(mean(ORIG_SIMEX_RANKED, na.rm=T), 1), Median_Ranked_SIMEX = median(as.numeric(ORIG_SIMEX_RANKED), na.rm=T), N=.N),
  keyby=c("SCHOOL_NUMBER", "SUBJECT_CODE", "SCHOOL_YEAR")]

smry.grd <- Georgia_Orig[!is.na(ORIG),
  list(Mean_SS = round(mean(SCALE_SCORE, na.rm=T), 1), Median_SS = median(SCALE_SCORE, na.rm=T),
       Mean_Ranked_SIMEX = round(mean(ORIG_SIMEX_RANKED, na.rm=T), 1), Median_Ranked_SIMEX = median(as.numeric(ORIG_SIMEX_RANKED), na.rm=T), N=.N),
  keyby=c("SCHOOL_NUMBER", "SUBJECT_CODE", "GRADE", "SCHOOL_YEAR")] # , "Most_Recent_Prior"

IAPP_Schools <- unique(Georgia_Orig[SR_SYSTEM_ID %in% IAPP_Districts, SCHOOL_NUMBER])

smry.sch[, District_Membership := as.character(NA)]
smry.sch[SCHOOL_NUMBER %in% IAPP_Schools, District_Membership := "IAPP"]
smry.sch[!SCHOOL_NUMBER %in% IAPP_Schools, District_Membership := "Non-IAPP"]
table(smry.sch[, District_Membership, SCHOOL_YEAR], exclude=NULL)
setkey(smry.sch)

smry.grd[, District_Membership := as.character(NA)]
smry.grd[SCHOOL_NUMBER %in% IAPP_Schools, District_Membership := "IAPP"]
smry.grd[!SCHOOL_NUMBER %in% IAPP_Schools, District_Membership := "Non-IAPP"]
table(smry.grd[, District_Membership, SCHOOL_YEAR], exclude=NULL)

smry.grd[, GRADE := as.numeric(GRADE)]
setkey(smry.grd)

#####
#####   IAPP Plots - Student Level
#####

require(ggplot2)
require(data.table)

content.area <- "ELA"
grade <- "4"

my.colors <- c("#9370DB", "#800080", "#00FF00", "#009966") # "mediumpurple" "darkpurple", "lightgreen", "darkgreen"

for (content.area in c("ELA", "MATHEMATICS", "GRADE_9_LIT", "AMERICAN_LIT",  "ALGEBRA_I", "GEOMETRY", "COORDINATE_ALGEBRA", "ANALYTIC_GEOMETRY")) {
for (grade in c(4, 5, 6, 7, 8, "EOCT")) {
	tmp.data <- Georgia_Orig[SUBJECT_CODE == content.area & GRADE == grade, list(District_Membership, SCALE_SCORE, SCHOOL_YEAR, ORIG)] # , SCALE_SCORE_PRIOR
	if (content.area=="MATHEMATICS") ca.name <- "Math" else ca.name <- content.area

	if (nrow(tmp.data[SCHOOL_YEAR %in% c("2019") & !is.na(SCALE_SCORE),]) > 100) {

    ###   Scale Score Distribution

		p <- ggplot() +
			scale_color_manual(values = my.colors) +
			ggtitle(paste("Scale Score by Group and Year:", ifelse(grade=="EOCT", "", paste("Grade", grade)), ca.name)) +
			theme(plot.title = element_text(size=18, face="bold.italic"), axis.title.x=element_text(size=15), axis.title.y=element_text(size=15), axis.text.x=element_text(size=14), axis.text.y=element_text(size=14))

    p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2018" & District_Membership == "IAPP"], aes(SCALE_SCORE, color= "'18 IAPP"), size=1.15, linetype="dashed")
		p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2018" & District_Membership == "Non-IAPP"], aes(SCALE_SCORE, color= "'18 Non-IAPP"), size=1.15)
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2018" & District_Membership == "IAPP", SCALE_SCORE], na.rm=T), size=1.15, linetype="dashed", color = my.colors[1])
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2018" & District_Membership == "Non-IAPP", SCALE_SCORE], na.rm=T), size=1.15, color = my.colors[2])
		p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2019" & District_Membership == "IAPP"], aes(SCALE_SCORE, color= "'19 IAPP"), linetype="dashed", size=1.15)
		p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2019" & District_Membership == "Non-IAPP"], aes(SCALE_SCORE, color= "'19 Non-IAPP"), size=1.15)
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2019" & District_Membership == "IAPP", SCALE_SCORE], na.rm=T), linetype="dashed", size=1.15, color = my.colors[3])
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2019" & District_Membership == "Non-IAPP", SCALE_SCORE], na.rm=T), size=1.15, color = my.colors[4])

		p <- p + guides(color = guide_legend(override.aes = list(linetype=rep(c("dashed", "solid"), 2)), title = "Consortia\nMembership", title.theme = element_text(size = 16), label.theme = element_text(size = 15)))
		p <- p + scale_x_continuous(name="Scale Score Distribution and Mean (Vertical Line)")

		ggsave(filename = paste("./Plots/Georgia_IAPP_Comp", ifelse(grade=="EOCT", "_", paste0("_Grade_", grade, "_")), ca.name, "_SS.pdf", sep=""), plot=p, device = "pdf", width = 9, height = 5, units = "in")

    ###   SGPs

		p <- ggplot() +
			scale_color_manual(values = my.colors) +
			ggtitle(paste("SGPs by Group and Year:", ifelse(grade=="EOCT", "", paste("Grade", grade)), ca.name)) +
			theme(plot.title = element_text(size=12, face="bold.italic"))

		p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2018" & District_Membership == "IAPP"], aes(ORIG, color= "'18 IAPP"), size=1.15, linetype="dashed")
		p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2018" & District_Membership == "Non-IAPP"], aes(ORIG, color= "'18 Non-IAPP"), size=1.15)
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2018" & District_Membership == "IAPP", ORIG], na.rm=T), size=1.15, linetype="dashed", color = my.colors[1])
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2018" & District_Membership == "Non-IAPP", ORIG], na.rm=T), size=1.15, color = my.colors[2])
    p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2019" & District_Membership == "IAPP"], aes(ORIG, color= "'19 IAPP"), linetype="dashed", size=1.15)
		p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2019" & District_Membership == "Non-IAPP"], aes(ORIG, color= "'19 Non-IAPP"), size=1.15)
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2019" & District_Membership == "IAPP", ORIG], na.rm=T), linetype="dashed", size=1.15, color = my.colors[4])
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2019" & District_Membership == "Non-IAPP", ORIG], na.rm=T), size=1.15, color = my.colors[4])

		p <- p + theme(legend.position = "none")
		p <- p + scale_x_continuous(name="SGP Distribution and Mean (Vertical Line)")

		ggsave(filename = paste("./Plots/Georgia_IAPP_Comp", ifelse(grade=="EOCT", "_", paste0("_Grade_", grade, "_")), ca.name, "_SGP.pdf", sep=""), plot=p, device = "pdf", width = 5.5, height = 3, units = "in")
	}
}}

for (content.area in c("ELA", "MATHEMATICS")) { # Only need this for School lev ELA/Math - EOCT in grade level for non-Standardized scores, "GRADE_9_LIT", "AMERICAN_LIT",  "ALGEBRA_I", "GEOMETRY", "COORDINATE_ALGEBRA", "ANALYTIC_GEOMETRY")) {
	tmp.data <- Georgia_Orig[SUBJECT_CODE == content.area, list(District_Membership, SCALE_SCORE_STANDARDIZED, SCHOOL_YEAR, ORIG)] # , SCALE_SCORE_PRIOR
	if (content.area=="MATHEMATICS") ca.name <- "Math" else ca.name <- content.area

	if (nrow(tmp.data[SCHOOL_YEAR %in% c("2019") & !is.na(SCALE_SCORE_STANDARDIZED),]) > 100) {

    ###   Scale Score Distribution

		p <- ggplot() +
			scale_color_manual(values = my.colors) +
			ggtitle(paste("Scale Score by Group and Year:", ca.name)) +
			theme(plot.title = element_text(size=18, face="bold.italic"), axis.title.x=element_text(size=15), axis.title.y=element_text(size=15), axis.text.x=element_text(size=14), axis.text.y=element_text(size=14))

    p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2018" & District_Membership == "IAPP"], aes(SCALE_SCORE_STANDARDIZED, color= "'18 IAPP"), size=1.15, linetype="dashed")
		p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2018" & District_Membership == "Non-IAPP"], aes(SCALE_SCORE_STANDARDIZED, color= "'18 Non-IAPP"), size=1.15)
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2018" & District_Membership == "IAPP", SCALE_SCORE_STANDARDIZED], na.rm=T), size=1.15, linetype="dashed", color = my.colors[1])
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2018" & District_Membership == "Non-IAPP", SCALE_SCORE_STANDARDIZED], na.rm=T), size=1.15, color = my.colors[2])
		p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2019" & District_Membership == "IAPP"], aes(SCALE_SCORE_STANDARDIZED, color= "'19 IAPP"), linetype="dashed", size=1.15)
		p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2019" & District_Membership == "Non-IAPP"], aes(SCALE_SCORE_STANDARDIZED, color= "'19 Non-IAPP"), size=1.15)
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2019" & District_Membership == "IAPP", SCALE_SCORE_STANDARDIZED], na.rm=T), linetype="dashed", size=1.15, color = my.colors[3])
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2019" & District_Membership == "Non-IAPP", SCALE_SCORE_STANDARDIZED], na.rm=T), size=1.15, color = my.colors[4])

		p <- p + guides(color = guide_legend(override.aes = list(linetype=rep(c("dashed", "solid"), 2)), title = "Consortia\nMembership", title.theme = element_text(size = 16), label.theme = element_text(size = 15)))
		p <- p + scale_x_continuous(name="Scale Score Distribution and Mean (Vertical Line)")

		ggsave(filename = paste("./Plots/Georgia_IAPP_Comp_", ca.name, "_SS.pdf", sep=""), plot=p, device = "pdf", width = 9, height = 5, units = "in")

    ###   SGPs

		p <- ggplot() +
			scale_color_manual(values = my.colors) +
			ggtitle(paste("SGPs by Group and Year:", ca.name)) +
			theme(plot.title = element_text(size=12, face="bold.italic"))

		p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2018" & District_Membership == "IAPP"], aes(ORIG, color= "'18 IAPP"), size=1.15, linetype="dashed")
		p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2018" & District_Membership == "Non-IAPP"], aes(ORIG, color= "'18 Non-IAPP"), size=1.15)
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2018" & District_Membership == "IAPP", ORIG], na.rm=T), size=1.15, linetype="dashed", color = my.colors[1])
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2018" & District_Membership == "Non-IAPP", ORIG], na.rm=T), size=1.15, color = my.colors[2])
    p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2019" & District_Membership == "IAPP"], aes(ORIG, color= "'19 IAPP"), linetype="dashed", size=1.15)
		p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2019" & District_Membership == "Non-IAPP"], aes(ORIG, color= "'19 Non-IAPP"), size=1.15)
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2019" & District_Membership == "IAPP", ORIG], na.rm=T), linetype="dashed", size=1.15, color = my.colors[4])
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2019" & District_Membership == "Non-IAPP", ORIG], na.rm=T), size=1.15, color = my.colors[4])

		p <- p + theme(legend.position = "none")
		p <- p + scale_x_continuous(name="SGP Distribution and Mean (Vertical Line)")

		ggsave(filename = paste("./Plots/Georgia_IAPP_Comp_", ca.name, "_SGP.pdf", sep=""), plot=p, device = "pdf", width = 5.5, height = 3, units = "in")
	}
}


###   School Level IAPP/Non Comparisons


my.colors <- c("#FF3333", "#CC0000", "#6666FF", "#0000CC") # "darkred", "lightred", "darkblue", "blue",

for (content.area in c("ELA", "MATHEMATICS")) { # Only need this for School lev ELA/Math - EOCT in grade level for non-Standardized scores, "GRADE_9_LIT", "AMERICAN_LIT",  "ALGEBRA_I", "GEOMETRY", "COORDINATE_ALGEBRA", "ANALYTIC_GEOMETRY")) {
	tmp.data <- smry.sch[SUBJECT_CODE == content.area, list(District_Membership, SCHOOL_YEAR, Mean_Ranked_SIMEX, Mean_SS, N)] # , SCALE_SCORE_PRIOR
	if (content.area=="MATHEMATICS") ca.name <- "Math" else ca.name <- content.area

    ###   School-Level Mean SGP Distributions - Content Area ONLY

    p <- ggplot() +
			scale_color_manual(values = my.colors) +
			ggtitle(paste("School-Level Mean Ranked SIMEX SGP:", capwords(content.area))) +
			theme(plot.title = element_text(size=18, face="bold.italic"), axis.title.x=element_text(size=15), axis.title.y=element_text(size=15), axis.text.x=element_text(size=14), axis.text.y=element_text(size=14))

    p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2018" & N > 14 & District_Membership == "IAPP"], aes(Mean_Ranked_SIMEX, color= "'18 IAPP"), size=1.15, linetype="dashed")
		p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2018" & N > 14 & District_Membership == "Non-IAPP"], aes(Mean_Ranked_SIMEX, color= "'18 Non-IAPP"), size=1.15)
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2018" & N > 14 & District_Membership == "IAPP", Mean_Ranked_SIMEX], na.rm=T), size=1.15, linetype="dashed", color = my.colors[1])
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2018" & N > 14 & District_Membership == "Non-IAPP", Mean_Ranked_SIMEX], na.rm=T), size=1.15, color = my.colors[2])
		p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2019" & N > 14 & District_Membership == "IAPP"], aes(Mean_Ranked_SIMEX, color= "'19 IAPP"), linetype="dashed", size=1.15)
		p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2019" & N > 14 & District_Membership == "Non-IAPP"], aes(Mean_Ranked_SIMEX, color= "'19 Non-IAPP"), size=1.15)
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2019" & N > 14 & District_Membership == "IAPP", Mean_Ranked_SIMEX], na.rm=T), linetype="dashed", size=1.15, color = my.colors[3])
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2019" & N > 14 & District_Membership == "Non-IAPP", Mean_Ranked_SIMEX], na.rm=T), size=1.15, color = my.colors[4])

		# p <- p + guides(color = guide_legend(override.aes = list(linetype=rep(c("dashed", "solid"), 2)), title = "Consortia\nMembership", title.theme = element_text(size = 16), label.theme = element_text(size = 15)))
    p <- p + theme(legend.position = "none")
    p <- p + scale_x_continuous(name="Mean Ranked SIMEX SGP Distribution and Mean (Vertical Line)")

		ggsave(filename = paste("./Plots/Georgia_IAPP_Comp_", ca.name, "_Sch_MSGP.pdf", sep=""), plot=p, device = "pdf", width = 9, height = 5, units = "in")

    ###   School-Level Mean SS Distributions - Content Area ONLY

    p <- ggplot() +
			scale_color_manual(values = my.colors) +
			ggtitle(paste("School-Level Mean Standardized Scores:", capwords(content.area))) +
			theme(plot.title = element_text(size=18, face="bold.italic"), axis.title.x=element_text(size=15), axis.title.y=element_text(size=15), axis.text.x=element_text(size=14), axis.text.y=element_text(size=14))

    p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2018" & N > 14 & District_Membership == "IAPP"], aes(Mean_SS, color= "'18 IAPP"), size=1.15, linetype="dashed")
		p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2018" & N > 14 & District_Membership == "Non-IAPP"], aes(Mean_SS, color= "'18 Non-IAPP"), size=1.15)
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2018" & N > 14 & District_Membership == "IAPP", Mean_SS], na.rm=T), size=1.15, linetype="dashed", color = my.colors[1])
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2018" & N > 14 & District_Membership == "Non-IAPP", Mean_SS], na.rm=T), size=1.15, color = my.colors[2])
		p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2019" & N > 14 & District_Membership == "IAPP"], aes(Mean_SS, color= "'19 IAPP"), linetype="dashed", size=1.15)
		p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2019" & N > 14 & District_Membership == "Non-IAPP"], aes(Mean_SS, color= "'19 Non-IAPP"), size=1.15)
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2019" & N > 14 & District_Membership == "IAPP", Mean_SS], na.rm=T), linetype="dashed", size=1.15, color = my.colors[3])
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2019" & N > 14 & District_Membership == "Non-IAPP", Mean_SS], na.rm=T), size=1.15, color = my.colors[4])

		p <- p + guides(color = guide_legend(override.aes = list(linetype=rep(c("dashed", "solid"), 2)), title = "Consortia\nMembership", title.theme = element_text(size = 16), label.theme = element_text(size = 15)))
    p <- p + scale_x_continuous(name="Mean Standardized Scale Score Distribution and Mean (Vertical Line)")

		ggsave(filename = paste("./Plots/Georgia_IAPP_Comp_", ca.name, "_Sch_MSS.pdf", sep=""), plot=p, device = "pdf", width = 9, height = 5, units = "in")
}


for (content.area in c("ELA", "MATHEMATICS", "GRADE_9_LIT", "AMERICAN_LIT",  "ALGEBRA_I", "GEOMETRY", "COORDINATE_ALGEBRA", "ANALYTIC_GEOMETRY")) {
for (grade in c(4:8, "EOCT")) {
	tmp.data <- smry.grd[SUBJECT_CODE == content.area & GRADE == grade, list(District_Membership, SCHOOL_YEAR, Mean_Ranked_SIMEX, Mean_SS, N)] # , SCALE_SCORE_PRIOR
	if (content.area=="MATHEMATICS") ca.name <- "Math" else ca.name <- content.area

  if (nrow(tmp.data[SCHOOL_YEAR %in% c("2019") & !is.na(Mean_SS),]) > 10) {
    ###   School-Level Mean SGP Distributions - Grade x Content Area

    p <- ggplot() +
			scale_color_manual(values = my.colors) +
			ggtitle(paste("School-Level Mean Ranked SIMEX SGP:", ifelse(grade=="EOCT", "", paste("Grade", grade)), capwords(content.area))) +
			theme(plot.title = element_text(size=18, face="bold.italic"), axis.title.x=element_text(size=15), axis.title.y=element_text(size=15), axis.text.x=element_text(size=14), axis.text.y=element_text(size=14))

    p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2018" & N > 14 & District_Membership == "IAPP"], aes(Mean_Ranked_SIMEX, color= "'18 IAPP"), size=1.15, linetype="dashed")
		p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2018" & N > 14 & District_Membership == "Non-IAPP"], aes(Mean_Ranked_SIMEX, color= "'18 Non-IAPP"), size=1.15)
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2018" & N > 14 & District_Membership == "IAPP", Mean_Ranked_SIMEX], na.rm=T), size=1.15, linetype="dashed", color = my.colors[1])
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2018" & N > 14 & District_Membership == "Non-IAPP", Mean_Ranked_SIMEX], na.rm=T), size=1.15, color = my.colors[2])
		p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2019" & N > 14 & District_Membership == "IAPP"], aes(Mean_Ranked_SIMEX, color= "'19 IAPP"), linetype="dashed", size=1.15)
		p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2019" & N > 14 & District_Membership == "Non-IAPP"], aes(Mean_Ranked_SIMEX, color= "'19 Non-IAPP"), size=1.15)
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2019" & N > 14 & District_Membership == "IAPP", Mean_Ranked_SIMEX], na.rm=T), linetype="dashed", size=1.15, color = my.colors[3])
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2019" & N > 14 & District_Membership == "Non-IAPP", Mean_Ranked_SIMEX], na.rm=T), size=1.15, color = my.colors[4])

		# p <- p + guides(color = guide_legend(override.aes = list(linetype=rep(c("dashed", "solid"), 2)), title = "Consortia\nMembership", title.theme = element_text(size = 16), label.theme = element_text(size = 15)))
    p <- p + theme(legend.position = "none")
		p <- p + scale_x_continuous(name="Mean Ranked SIMEX SGP Distribution and Mean (Vertical Line)")

		ggsave(filename = paste("./Plots/Georgia_IAPP_Comp", ifelse(grade=="EOCT", "_", paste0("_Grade_", grade, "_")), ca.name, "_Sch_Grd_MSGP.pdf", sep=""), plot=p, device = "pdf", width = 9, height = 5, units = "in")

    ###   School-Level Mean Scale Scores Distributions - Grade x Content Area

    p <- ggplot() +
			scale_color_manual(values = my.colors) +
			ggtitle(paste("School-Level Mean Scale Scores:", ifelse(grade=="EOCT", "", paste("Grade", grade)), capwords(content.area))) +
			theme(plot.title = element_text(size=18, face="bold.italic"), axis.title.x=element_text(size=15), axis.title.y=element_text(size=15), axis.text.x=element_text(size=14), axis.text.y=element_text(size=14))

    p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2018" & N > 14 & District_Membership == "IAPP"], aes(Mean_SS, color= "'18 IAPP"), size=1.15, linetype="dashed")
		p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2018" & N > 14 & District_Membership == "Non-IAPP"], aes(Mean_SS, color= "'18 Non-IAPP"), size=1.15)
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2018" & N > 14 & District_Membership == "IAPP", Mean_SS], na.rm=T), size=1.15, linetype="dashed", color = my.colors[1])
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2018" & N > 14 & District_Membership == "Non-IAPP", Mean_SS], na.rm=T), size=1.15, color = my.colors[2])
		p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2019" & N > 14 & District_Membership == "IAPP"], aes(Mean_SS, color= "'19 IAPP"), linetype="dashed", size=1.15)
		p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2019" & N > 14 & District_Membership == "Non-IAPP"], aes(Mean_SS, color= "'19 Non-IAPP"), size=1.15)
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2019" & N > 14 & District_Membership == "IAPP", Mean_SS], na.rm=T), linetype="dashed", size=1.15, color = my.colors[3])
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2019" & N > 14 & District_Membership == "Non-IAPP", Mean_SS], na.rm=T), size=1.15, color = my.colors[4])

		p <- p + guides(color = guide_legend(override.aes = list(linetype=rep(c("dashed", "solid"), 2)), title = "Consortia\nMembership", title.theme = element_text(size = 16), label.theme = element_text(size = 15)))
    p <- p + scale_x_continuous(name="Mean Standardized Scale Score Distribution and Mean (Vertical Line)")

		ggsave(filename = paste("./Plots/Georgia_IAPP_Comp", ifelse(grade=="EOCT", "_", paste0("_Grade_", grade, "_")), ca.name, "_Sch_Grd_MSS.pdf", sep=""), plot=p, device = "pdf", width = 9, height = 5, units = "in")
  }
}}


###   Student-Level Comparisons

cor(Georgia_Data$ORIG_SIMEX_RANKED, Georgia_Data$IAPP_SIMEX_RANKED, use = "complete.obs")

Georgia_Data[!is.na(ORIG), list(
                  R_Uncorrected = round(cor(ORIG, IAPP, use = "complete.obs"), 3),
                  R_Rank_SIMEX = round(cor(ORIG_SIMEX_RANKED, IAPP_SIMEX_RANKED, use = "complete.obs"), 3), N=.N),
                keyby=c("SUBJECT_CODE", "GRADE", "SCHOOL_YEAR")] # "Most_Recent_Prior.x",

Georgia_Data[, SGP_DIFF := IAPP - ORIG]
Georgia_Data[, SGP_DIFF_SIMEX := IAPP_SIMEX_RANKED - ORIG_SIMEX_RANKED]
Georgia_Data[!is.na(ORIG), as.list(round(summary(SGP_DIFF), 2)), keyby=c("SUBJECT_CODE", "GRADE", "SCHOOL_YEAR")]
Georgia_Data[!is.na(ORIG), as.list(round(summary(SGP_DIFF_SIMEX), 2)), keyby=c("SUBJECT_CODE", "GRADE", "SCHOOL_YEAR")]

# Georgia_Data[!is.na(ORIG), list(
#                   R_Growth_Curr = round(cor(SGP_DIFF_SIMEX, SCALE_SCORE, use = "complete.obs"), 3),
#                   R_Growth_Prior= round(cor(SGP_DIFF_SIMEX, SCALE_SCORE_PRIOR, use = "complete.obs"), 3), N=.N),
#                 keyby=c("SUBJECT_CODE", "GRADE", "SCHOOL_YEAR")] # "Most_Recent_Prior.x",

plot(Georgia_Data[SUBJECT_CODE == "MATHEMATICS" & GRADE==4, SCALE_SCORE_PRIOR], Georgia_Data[SUBJECT_CODE == "MATHEMATICS" & GRADE==4, SGP_DIFF_SIMEX])


###
###   School Level Comparisons
###
#
# diff.sch <- Georgia_Data[!is.na(ORIG),
#   list(Mean_ORIG=mean(ORIG, na.rm=T), Median_ORIG=median(as.numeric(ORIG), na.rm=T),
#        Mean_IAPP=mean(IAPP, na.rm=T), Median_IAPP=median(as.numeric(IAPP), na.rm=T),
#        Mean_SIMEX_ORIG=mean(ORIG_SIMEX_RANKED, na.rm=T), Median_SIMEX_ORIG=median(as.numeric(ORIG_SIMEX_RANKED), na.rm=T),
#        Mean_SIMEX_IAPP=mean(IAPP_SIMEX_RANKED, na.rm=T), Median_SIMEX_IAPP=median(as.numeric(IAPP_SIMEX_RANKED), na.rm=T),
#        Mean_SS=mean(SCALE_SCORE, na.rm=T), Mean_Prior_SS=mean(SCALE_SCORE_PRIOR, na.rm=T), N=.N),
#   keyby=c("SCHOOL_NUMBER.x", "SUBJECT_CODE", "SCHOOL_YEAR")]
#
# diff.grd.sch <- Georgia_Data[!is.na(ORIG),
#   list(Mean_ORIG=mean(ORIG, na.rm=T), Median_ORIG=median(as.numeric(ORIG), na.rm=T),
#        Mean_IAPP=mean(IAPP, na.rm=T), Median_IAPP=median(as.numeric(IAPP), na.rm=T),
#        Mean_SIMEX_ORIG=mean(ORIG_SIMEX_RANKED, na.rm=T), Median_SIMEX_ORIG=median(as.numeric(ORIG_SIMEX_RANKED), na.rm=T),
#        Mean_SIMEX_IAPP=mean(IAPP_SIMEX_RANKED, na.rm=T), Median_SIMEX_IAPP=median(as.numeric(IAPP_SIMEX_RANKED), na.rm=T),
#        Mean_SS=mean(SCALE_SCORE, na.rm=T), Mean_Prior_SS=mean(SCALE_SCORE_PRIOR, na.rm=T), N=.N),
#   keyby=c("SCHOOL_NUMBER.x", "SUBJECT_CODE", "GRADE", "Most_Recent_Prior.x", "SCHOOL_YEAR")] #
#
# diff.sch[, Mean_Difference := Mean_ORIG - Mean_IAPP]
# diff.sch[, Median_Difference := Median_ORIG - Median_IAPP]
# diff.sch[, Mean_Difference_SIMEX := Mean_SIMEX_ORIG - Mean_SIMEX_IAPP]
# diff.sch[, Median_Difference_SIMEX := Median_SIMEX_ORIG - Median_SIMEX_IAPP]
#
# diff.grd.sch[, Mean_Difference := Mean_ORIG - Mean_IAPP]
# diff.grd.sch[, Median_Difference := Median_ORIG - Median_IAPP]
# diff.grd.sch[, Mean_Difference_SIMEX := Mean_SIMEX_ORIG - Mean_SIMEX_IAPP]
# diff.grd.sch[, Median_Difference_SIMEX := Median_SIMEX_ORIG - Median_SIMEX_IAPP]
#
# diff.grd.sch[N > 14, as.list(round(summary(Mean_Difference),2)), keyby=c("SUBJECT_CODE", "GRADE", "SCHOOL_YEAR")] # !is.na(Mean_ORIG) &
# diff.grd.sch[N > 14, as.list(round(summary(Mean_Difference),2)), keyby=c("SUBJECT_CODE", "SCHOOL_YEAR")]
#
# diff.grd.sch[N > 24, as.list(round(summary(Mean_Difference_SIMEX),2)), keyby=c("SUBJECT_CODE", "GRADE", "SCHOOL_YEAR")]
#
# diff.grd.sch[N > 49, as.list(round(summary(Mean_Difference_SIMEX),2)), keyby=c("SUBJECT_CODE", "SCHOOL_YEAR")]
#
# n <- 14
# ca <- "MATHEMATICS"
# plot(diff.grd.sch[SUBJECT_CODE == ca & N > n, Mean_Prior_SS], diff.grd.sch[SUBJECT_CODE == ca & N > n, Mean_Difference_SIMEX])
#
# plot(diff.sch[SUBJECT_CODE == ca & N > n, N], diff.sch[SUBJECT_CODE == ca & N > n, Mean_Difference_SIMEX])
# plot(diff.grd.sch[SUBJECT_CODE == ca & N > n, N], diff.grd.sch[SUBJECT_CODE == ca & N > n, Mean_Difference_SIMEX])
# abline(h=0, col="red")
# abline(v=15, col="red")
#
# plot(diff.grd.sch[SUBJECT_CODE == ca & N > n, Mean_SIMEX_ORIG], diff.grd.sch[SUBJECT_CODE == ca & N > n, Mean_SIMEX_IAPP])
# plot(diff.grd.sch[SUBJECT_CODE == ca & N > n, Median_SIMEX_ORIG], diff.grd.sch[SUBJECT_CODE == ca & N > n, Median_SIMEX_IAPP])

###

diff.sch <- Georgia_Data[!is.na(ORIG),
  list(Mean_Entire = round(mean(ORIG, na.rm=T), 1), Median_Entire = median(as.numeric(ORIG), na.rm=T),
       Mean__Non___IAPP = round(mean(IAPP, na.rm=T), 1), Median__Non___IAPP = median(as.numeric(IAPP), na.rm=T),
       Mean_Ranked_SIMEX_Entire = round(mean(ORIG_SIMEX_RANKED, na.rm=T), 1), Median_Ranked_SIMEX_Entire = median(as.numeric(ORIG_SIMEX_RANKED), na.rm=T),
       Mean_Ranked_SIMEX__Non___IAPP = round(mean(IAPP_SIMEX_RANKED, na.rm=T), 1), Median_Ranked_SIMEX__Non___IAPP = median(as.numeric(IAPP_SIMEX_RANKED), na.rm=T), N=.N),
  keyby=c("SCHOOL_NUMBER", "SUBJECT_CODE", "SCHOOL_YEAR")]

diff.grd.sch <- Georgia_Data[!is.na(ORIG),
list(Mean_Entire = round(mean(ORIG, na.rm=T), 1), Median_Entire = median(as.numeric(ORIG), na.rm=T),
     Mean__Non___IAPP = round(mean(IAPP, na.rm=T), 1), Median__Non___IAPP = median(as.numeric(IAPP), na.rm=T),
     Mean_Ranked_SIMEX_Entire = round(mean(ORIG_SIMEX_RANKED, na.rm=T), 1), Median_Ranked_SIMEX_Entire = median(as.numeric(ORIG_SIMEX_RANKED), na.rm=T),
     Mean_Ranked_SIMEX__Non___IAPP = round(mean(IAPP_SIMEX_RANKED, na.rm=T), 1), Median_Ranked_SIMEX__Non___IAPP = median(as.numeric(IAPP_SIMEX_RANKED), na.rm=T), N=.N),
  keyby=c("SCHOOL_NUMBER", "SUBJECT_CODE", "GRADE", "SCHOOL_YEAR")] # , "Most_Recent_Prior"

diff.sch[, Mean_Difference := Mean__Non___IAPP - Mean_Entire]
diff.sch[, Median_Difference := Median__Non___IAPP - Median_Entire]
diff.sch[, Mean_Difference_Ranked_SIMEX := Mean_Ranked_SIMEX__Non___IAPP - Mean_Ranked_SIMEX_Entire]
diff.sch[, Median_Difference_SIMEX := Median_Ranked_SIMEX__Non___IAPP - Mean_Ranked_SIMEX_Entire]

diff.grd.sch[, Mean_Difference := Mean__Non___IAPP - Mean_Entire]
diff.grd.sch[, Median_Difference := Median__Non___IAPP - Median_Entire]
diff.grd.sch[, Mean_Difference_SIMEX := Mean_Ranked_SIMEX__Non___IAPP - Mean_Ranked_SIMEX_Entire]
diff.grd.sch[, Median_Difference_SIMEX := Median_Ranked_SIMEX__Non___IAPP - Mean_Ranked_SIMEX_Entire]


###  School Level Differences

content.area <- "ELA"
grade <- "4"

my.colors <- c("#FF3333", "#CC0000", "#6666FF", "#0000CC") # "darkred", "lightred", "darkblue", "blue",

for (content.area in c("ELA", "MATHEMATICS", "GRADE_9_LIT", "AMERICAN_LIT",  "ALGEBRA_I", "GEOMETRY", "COORDINATE_ALGEBRA", "ANALYTIC_GEOMETRY")) {
	tmp.data <- diff.sch[SUBJECT_CODE == content.area, list(SCHOOL_YEAR, Mean_Ranked_SIMEX_Entire, Mean_Ranked_SIMEX__Non___IAPP, N)]
	if (content.area=="MATHEMATICS") ca.name <- "Math" else ca.name <- content.area

    ###   School-Level Mean SGP Distributions - Original vs IAPP removed

    p <- ggplot() +
			scale_color_manual(values = my.colors) +
			ggtitle(paste("School-Level Mean Ranked SIMEX SGP:", capwords(content.area))) +
			theme(plot.title = element_text(size=18, face="bold.italic"), axis.title.x=element_text(size=15), axis.title.y=element_text(size=15), axis.text.x=element_text(size=14), axis.text.y=element_text(size=14))

    p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2018" & N > 14], aes(Mean_Ranked_SIMEX_Entire, color = "'18 Entire"), size=1.15)
		p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2018" & N > 14], aes(Mean_Ranked_SIMEX__Non___IAPP, color = "'18 Non-IAPP"), size=1.15, linetype="dashed")
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2018" & N > 14, Mean_Ranked_SIMEX_Entire], na.rm=T), size=1.15, color = my.colors[1])
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2018" & N > 14, Mean_Ranked_SIMEX__Non___IAPP], na.rm=T), size=1.15, linetype="dashed", color = my.colors[2])
		p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2019" & N > 14], aes(Mean_Ranked_SIMEX_Entire, color= "'19 Entire"), size=1.15)
		p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2019" & N > 14], aes(Mean_Ranked_SIMEX__Non___IAPP, color= "'19 Non-IAPP"), size=1.15, linetype="dashed")
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2019" & N > 14, Mean_Ranked_SIMEX_Entire], na.rm=T), size=1.15, color = my.colors[3])
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2019" & N > 14, Mean_Ranked_SIMEX__Non___IAPP], na.rm=T), size=1.15, linetype="dashed", color = my.colors[4])

		p <- p + guides(color = guide_legend(override.aes = list(linetype=rep(c("solid", "dashed"), 2)), title = "Cohort\nComposition", title.theme = element_text(size = 16), label.theme = element_text(size = 15)))
		p <- p + scale_x_continuous(name="Mean Ranked SIMEX SGP Distribution and Mean (Vertical Line)")

		ggsave(filename = paste("./Plots/Georgia_Non_IAPP_Comp_", ca.name, "_Sch_MSGP.pdf", sep=""), plot=p, device = "pdf", width = 9, height = 5, units = "in")
}


for (content.area in c("ELA", "MATHEMATICS", "GRADE_9_LIT", "AMERICAN_LIT",  "ALGEBRA_I", "GEOMETRY", "COORDINATE_ALGEBRA", "ANALYTIC_GEOMETRY")) {
for (grade in c(4:8, "EOCT")) {
  tmp.data <- diff.grd.sch[SUBJECT_CODE == content.area & GRADE == grade, list(SCHOOL_YEAR, Mean_Ranked_SIMEX_Entire, Mean_Ranked_SIMEX__Non___IAPP, N)]
	if (content.area=="MATHEMATICS") ca.name <- "Math" else ca.name <- content.area

  if (nrow(tmp.data[SCHOOL_YEAR %in% c("2019") & !is.na(Mean_Ranked_SIMEX_Entire),]) > 10) {
    ###   School-Level Mean SGP Distributions - Original vs IAPP removed -- Grade x Content Area

    p <- ggplot() +
			scale_color_manual(values = my.colors) +
			ggtitle(paste("School-Level Mean Ranked SIMEX SGP:", ifelse(grade=="EOCT", "", paste("Grade", grade)), capwords(content.area))) +
			theme(plot.title = element_text(size=18, face="bold.italic"), axis.title.x=element_text(size=15), axis.title.y=element_text(size=15), axis.text.x=element_text(size=14), axis.text.y=element_text(size=14))

    p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2018" & N > 14], aes(Mean_Ranked_SIMEX_Entire, color= "'18 Entire"), size=1.15)
		p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2018" & N > 14], aes(Mean_Ranked_SIMEX__Non___IAPP, color= "'18 Non-IAPP"), size=1.15, linetype="dashed")
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2018" & N > 14, Mean_Ranked_SIMEX_Entire], na.rm=T), size=1.15, color = my.colors[1])
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2018" & N > 14, Mean_Ranked_SIMEX__Non___IAPP], na.rm=T), size=1.15, linetype="dashed", color = my.colors[2])
		p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2019" & N > 14], aes(Mean_Ranked_SIMEX_Entire, color= "'19 Entire"), size=1.15)
		p <- p + geom_density(data = tmp.data[SCHOOL_YEAR == "2019" & N > 14], aes(Mean_Ranked_SIMEX__Non___IAPP, color= "'19 Non-IAPP"), size=1.15, linetype="dashed")
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2019" & N > 14, Mean_Ranked_SIMEX_Entire], na.rm=T), size=1.15, color = my.colors[3])
		p <- p + geom_vline(xintercept = mean(tmp.data[SCHOOL_YEAR == "2019" & N > 14, Mean_Ranked_SIMEX__Non___IAPP], na.rm=T), size=1.15, linetype="dashed", color = my.colors[4])

		p <- p + guides(color = guide_legend(override.aes = list(linetype=rep(c("solid", "dashed"), 2)), title = "Cohort\nComposition", title.theme = element_text(size = 16), label.theme = element_text(size = 15)))
		p <- p + scale_x_continuous(name="Mean Ranked SIMEX SGP Distribution and Mean (Vertical Line)")

		ggsave(filename = paste("./Plots/Georgia_Non_IAPP_Comp", ifelse(grade=="EOCT", "_", paste0("_Grade_", grade, "_")), ca.name, "_Sch_Grd_MSGP.pdf", sep=""), plot=p, device = "pdf", width = 9, height = 5, units = "in")
  }
}}


###  Scatterplot of differences by School N size

my.colors <- c("#CC0000", "#0000CC") # "darkred","darkblue"

###  Added later - could have included EOCT here and only ELA MATH for GRADE below
for (content.area in c("ELA", "MATHEMATICS")) {
  tmp.data <- diff.grd.sch[SUBJECT_CODE == content.area, list(SCHOOL_YEAR, Mean_Difference_SIMEX, N)]
	if (content.area=="MATHEMATICS") ca.name <- "Math" else ca.name <- content.area

  if (nrow(tmp.data[SCHOOL_YEAR %in% c("2019") & !is.na(Mean_Difference_SIMEX),]) > 10) {
    ###   School-Level Mean SGP Distributions - Original vs IAPP removed -- Content Area only

    p <- ggplot() +
			scale_color_manual(values = my.colors) +
			ggtitle(paste("School Mean SGP Differences by School Size:", capwords(content.area))) +
			theme(plot.title = element_text(size=18, face="bold.italic"), axis.title.x=element_text(size=15), axis.title.y=element_text(size=15), axis.text.x=element_text(size=14), axis.text.y=element_text(size=14))

    p <- p + geom_point(data = tmp.data[N > 14], aes(x = N, y = Mean_Difference_SIMEX, shape=SCHOOL_YEAR, color=SCHOOL_YEAR), size=3, alpha = 0.75)

    # p <- p + theme(legend.position = "none")
    p <- p + guides(color = guide_legend(override.aes = list(shape=16:17), title = "School\nYear", title.theme = element_text(size = 16), label.theme = element_text(size = 15)), shape="none")
		p <- p + scale_x_continuous(name="School Size")
    p <- p + scale_y_continuous(name="Mean Ranked SIMEX SGP Differences")

		ggsave(filename = paste("./Plots/Georgia_Non_IAPP_Comp_", ca.name, "_Diff_x_N.pdf", sep=""), plot=p, device = "pdf", width = 9, height = 5, units = "in")
  }
}



for (content.area in c("ELA", "MATHEMATICS", "GRADE_9_LIT", "AMERICAN_LIT",  "ALGEBRA_I", "GEOMETRY", "COORDINATE_ALGEBRA", "ANALYTIC_GEOMETRY")) {
for (grade in c(4:8, "EOCT")) {
  tmp.data <- diff.grd.sch[SUBJECT_CODE == content.area & GRADE == grade, list(SCHOOL_YEAR, Mean_Difference_SIMEX, N)]
	if (content.area=="MATHEMATICS") ca.name <- "Math" else ca.name <- content.area

  if (nrow(tmp.data[SCHOOL_YEAR %in% c("2019") & !is.na(Mean_Difference_SIMEX),]) > 10) {
    ###   School-Level Mean SGP Distributions - Original vs IAPP removed -- Grade x Content Area

    p <- ggplot() +
			scale_color_manual(values = my.colors) +
			ggtitle(paste("School Mean SGP Differences by School Size:", ifelse(grade=="EOCT", "", paste("Grade", grade)), capwords(content.area))) +
			theme(plot.title = element_text(size=18, face="bold.italic"), axis.title.x=element_text(size=15), axis.title.y=element_text(size=15), axis.text.x=element_text(size=14), axis.text.y=element_text(size=14))

    p <- p + geom_point(data = tmp.data[N > 14], aes(x = N, y = Mean_Difference_SIMEX, shape=SCHOOL_YEAR, color=SCHOOL_YEAR), size=3, alpha = 0.75)

    # p <- p + theme(legend.position = "none")
    p <- p + guides(color = guide_legend(override.aes = list(shape=16:17), title = "School\nYear", title.theme = element_text(size = 16), label.theme = element_text(size = 15)), shape="none")
		p <- p + scale_x_continuous(name="School Size")
    p <- p + scale_y_continuous(name="Mean Ranked SIMEX SGP Differences")

		ggsave(filename = paste("./Plots/Georgia_Non_IAPP_Comp", ifelse(grade=="EOCT", "_", paste0("_Grade_", grade, "_")), ca.name, "_Diff_x_N.pdf", sep=""), plot=p, device = "pdf", width = 9, height = 5, units = "in")
  }
}}
