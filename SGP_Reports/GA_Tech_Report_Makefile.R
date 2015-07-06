load("/media/Data/Dropbox/SGP/Georgia/Data/Georgia_Summary_2013.Rdata")
load("/media/Data/Dropbox/SGP/Georgia/Data/Georgia_SGP.Rdata")
setwd("/media/Data/Dropbox/Github_Repos/Documentation/Georgia/SGP_Reports/2013")

library(SGPreports)
use.data.table()

renderMultiDocument(rmd_input = "Appendix_A_2013.Rmd",
                    # output_format = c("HTML"),
                    output_format = c("HTML", "EPUB", "PDF"), #, "DOCX"
                    cover_img="../img/cover.jpg",
                    add_cover_title=TRUE,
                    cleanup_aux_files = FALSE)
system('/usr/lib/rstudio-server/bin/pandoc/pandoc PDF/markdown/Appendix_A_2013-pdf.md --to latex --from markdown+autolink_bare_uris+ascii_identifiers --output  Appendix_A_2013.tex --filter /usr/lib/rstudio-server/bin/pandoc/pandoc-citeproc --bibliography /home/avi/R/x86_64-pc-linux-gnu-library/3.2/SGPreports/rmarkdown/templates/multi_document/resources/educ.bib   --csl /home/avi/R/x86_64-pc-linux-gnu-library/3.2/SGPreports/rmarkdown/templates/multi_document/resources/apa-5th-edition.csl --template  /home/avi/R/x86_64-pc-linux-gnu-library/3.2/SGPreports/rmarkdown/templates/multi_document/resources/damian.tex --number-sections --highlight-style tango --latex-engine pdflatex')

renderMultiDocument(rmd_input = "Georgia_SGP_Report_2013.Rmd",
                    output_format = c("HTML", "EPUB", "PDF"), #, "DOCX"
                    cover_img="../img/cover.jpg",
                    add_cover_title=TRUE, 
                    cleanup_aux_files = FALSE,
                    pandoc_args = "--webtex")


renderMultiDocument(rmd_input = "Appendix_B.Rmd",
                    output_format = c("HTML", "EPUB"), # , "PDF", "DOCX"
                    html_template = "simple",
                    cover_img="../img/cover.jpg",
                    add_cover_title=TRUE, 
                    cleanup_aux_files = FALSE,
                    pandoc_args = "--webtex")



#######
# 2014
#######

#load("/media/Data/Dropbox/SGP/Georgia/Data/Georgia_SGP.Rdata")
load("/media/Data/Dropbox/SGP/Georgia/Data/Georgia_Summary_2014.Rdata")
setwd("/media/Data/Dropbox/Github_Repos/Documentation/Georgia/SGP_Reports/2014")

renderMultiDocument(rmd_input = "Georgia_SGP_Report_2014.Rmd",
                    output_format = c("HTML", "EPUB", "PDF"), #, "DOCX"
                    cover_img="../img/cover.jpg",
                    add_cover_title=TRUE, 
                    cleanup_aux_files = FALSE,
                    pandoc_args = "--webtex")

renderMultiDocument(rmd_input = "Appendix_A_2014.Rmd",
                    # output_format = c("HTML"),
                    output_format = c("HTML", "EPUB", "PDF"), #, "PDF", "DOCX"
                    cover_img="../img/cover.jpg",
                    add_cover_title=TRUE,
                    cleanup_aux_files = FALSE)
##  The PDF ain't perfect.  Need to add a \pagebreak for first section and then 
##  add ' [width=0.XX\textwidth] ' to the first img in each \section (0.7) &/or \subsection (0.75)
system('/usr/lib/rstudio-server/bin/pandoc/pandoc PDF/markdown/Appendix_A_2014-pdf.md --to latex --from markdown+autolink_bare_uris+ascii_identifiers --output  Appendix_A_2014.tex --filter /usr/lib/rstudio-server/bin/pandoc/pandoc-citeproc --bibliography /home/avi/R/x86_64-pc-linux-gnu-library/3.2/SGPreports/rmarkdown/templates/multi_document/resources/educ.bib   --csl /home/avi/R/x86_64-pc-linux-gnu-library/3.2/SGPreports/rmarkdown/templates/multi_document/resources/apa-5th-edition.csl --template  /home/avi/R/x86_64-pc-linux-gnu-library/3.2/SGPreports/rmarkdown/templates/multi_document/resources/damian.tex --number-sections --highlight-style tango --latex-engine pdflatex')

renderMultiDocument(rmd_input = "Appendix_B.Rmd",
                    output_format = c("HTML", "EPUB"), # , "PDF", "DOCX"
                    html_template = "simple",
                    cover_img="../img/cover.jpg",
                    add_cover_title=TRUE, 
                    cleanup_aux_files = FALSE,
                    pandoc_args = "--webtex")
