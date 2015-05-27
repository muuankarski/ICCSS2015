# Idea - Create four A4 pdf's and bind them together into single A2 file using pdfjam

library(ggplot2)
library(gridExtra)
setwd("~/btsync/mk/workspace/ropengov/ICCSS2015/poster")

# Plots
p <- ggplot(mtcars, aes(x=mpg,y=qsec,color=cyl))
p <- p + geom_point()
# Plot1
p1 <- p + geom_smooth(method="lm")
ggsave(p1, filename = "p1.pdf", width = 8.3, height = 11.7)
# Plot2
p1 <- p + geom_smooth(method="lm")
p2 <- p + geom_smooth(method="glm")
pdf("p2.pdf", width = 8.3, height = 11.7)
grid.arrange(p1,p2, ncol = 2)
dev.off()
# Plot3
p3 <- p + geom_smooth(method="loess")
p4 <- p + geom_smooth(method="gam")
pdf("p3.pdf", width = 8.3, height = 11.7)
grid.arrange(p1,p2,p3,p4, ncol = 2)
dev.off()

# And lets take the first page from the abstract jam them together into A2 poster
system("pdfjam  ../abstract.pdf 1 p1.pdf p2.pdf p3.pdf --nup 2x2  --a2paper --outfile poster.pdf")
