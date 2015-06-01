# Idea - Create four A4 pdf's and bind them together into single A2 file using pdfjam


POSTER DEVELOPMENT MOVED TO ROPENGOV SITE:
https://github.com/rOpenGov/poster/tree/master/2015-ICCSS


library(ggplot2)
library(gridExtra)

# This does not work in shared development, removing
#setwd("~/btsync/mk/workspace/ropengov/ICCSS2015/poster")

# ---------------------------------------------

# Front page

library(knitr)
knit2pdf("page1.Rnw")
knit2pdf("page2.Rnw")
knit2pdf("page3.Rnw")
knit2pdf("page4.Rnw")

# And lets take the first page from the abstract jam them together into A2 poster
system("pdfjam  page1.pdf 1 page4.pdf page3.pdf page2.pdf --nup 2x2  --a2paper --outfile poster.pdf")

