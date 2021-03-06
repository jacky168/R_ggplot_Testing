setwd('/home/jacky/project/R_ggplot_Testing/EDA/')
library(ggplot2)
pf <- read.csv('pseudo_facebook.tsv', sep = '\t')
summary(pf)
names(pf)
qplot(data = pf, x = dob_day) + 
  scale_x_discrete(breaks = 1:31) + 
  facet_wrap(~ dob_month, ncol = 3) + 
  geom_histogram()

qplot(data = pf, x = friend_count) +
  geom_histogram()

#ggplot(data = pf, aes(x = dob_day)) +
#  geom_histogram() +
#  scale_x_discrete(breaks = 1:31) +
#  facet_wrap(~dob_month)


# Multiple plot function
#
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
#
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}

p1<- ggplot(aes(x=age, y=friend_count), data=pf) +
  geom_point(alpha=1/20) +
  xlim(13,90) +
  coord_trans(y='sqrt')

p2 <- ggplot(aes(x=age, y=friend_count), data=pf) +
  geom_point(alpha=1/20) +
  xlim(13,90)

multiplot(p1, p2, cols=2)

p3 <- ggplot(aes(x=age, y=sqrt(friend_count)), data=pf) +
  geom_point(alpha=1/20) +
  xlim(13,90)+
  coord_trans()

multiplot(p1, p2, p3, cols=3)



ggplot(aes(x=age, y=friend_count), data=pf) +
  geom_point(alpha=1/20, position = position_jitter(h=0)) +
  xlim(13,90) +
  coord_trans(y='sqrt')

ggplot(aes(x=age, y=friendships_initiated), data=pf) +
    geom_jitter(alpha=1/10)