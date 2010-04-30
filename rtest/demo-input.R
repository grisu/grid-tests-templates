#
# added by Leigh.Gordon@arcs.org.au to generate CSV input file at runtime rather than download it
#
r1 <- runif(1, 1, 10000) * runif(1, 1, 10000)
r2 <- runif(1, 1, 10000) * runif(1, 1, 10000)
tmpfile <- paste("/tmp/rtest.", r1, ".", r2, ".csv", sep="")
cat("yr,Emis GtC,CO2GtC
1958,NA,NA
1959,2.46,2.3
1960,2.58,2
1961,2.59,1.6
1962,2.7,1.7
1963,2.85,1.2
1964,3.01,0.4
1965,3.15,1.8
1966,3.31,2.9
1967,3.41,1.6
1968,3.59,1.9
1969,3.8,3.4
1970,4.08,2.2
1971,4.23,1.4
1972,4.4,2.4
1973,4.64,4.7
1974,4.64,1.1
1975,4.62,2
1976,4.88,2
1977,5.03,3.7
1978,5.11,3.5
1979,5.39,2.9
1980,5.33,4
1981,5.17,3
1982,5.13,2.4
1983,5.11,3.4
1984,5.29,2.9
1985,5.44,3.5
1986,5.61,2.8
1987,5.75,3.8
1988,5.96,5.2
1989,6.09,3.1
1990,6.14,2.7
1991,6.24,2.8
1992,6.12,1.7
1993,6.12,1.5
1994,6.24,3.6
1995,6.37,4.2
1996,6.51,3.7
1997,6.62,2.4
1998,6.59,6.4
1999,6.57,3.5
2000,6.74,2.7
2001,6.9,3.6
2002,6.95,4.5
2003,7.29,5.6
2004,7.67,3.7
2005,7.97,4.8
2006,8.23,4.5", file=tmpfile)
link <- tmpfile

#####################################

### Fate of CO2 Emissions ######################################################################
# D Kelly O'Day  http://chartsgraphs.wordpress.com  Sept 8, 2009                               #
# Reproduce Hansen & IPCC charts that show time series of mass of                              #
#  CO2 emissions & atmosp CO2 in PgC                                                           #
################################################################################################
# Set pars  
  par(las=1); par(ps=10)
  par(oma=c(2,2,1,1)); par(mar=c(2,4,1,1))
  par(font.main = 4)
# Read Data file
# Leigh.Gordon commented this out to use local data
# link <- "http://spreadsheets.google.com/pub?key=tCVSIFNBYVBySwfqHDtDksg&output=csv"    
#
  df <- read.table(link, header=T, skip=0,sep=",", na.strings = c("*", "NA"))
  names(df) <- c("yr", "emis", "change")
# Plot setup
 plot_title <- expression(paste("Fossil Fuel Emissions and Atmospheric ", CO[2], " Changes (PgC/yr)"))
  ## Create df for polygon
    df1 <- data.frame(df$yr,df$emis)
    df2 <- data.frame(df$yr, df$change)
    df2 <- df2[order(-df$yr),]
    px<- append(df1$df.yr, df2$df.yr,after=nrow(df1))
    py <- append(df1$df.emis, df2$df.change, after=nrow(df2))
    p <- data.frame(px, py)
  # Notes for plot
    a_note <- "Annual Emissions"
    b_note <- "Soaked-Up\n Amount"
    c_note <- "Airborne \nAmount"
  sum_emis <- sum(df$emis, na.rm = T)    
  sum_change <- sum(df$change, na.rm=T)
    d_note <- paste("Emissions:     ", sum_emis, " PgC")
    e_note <- paste("CO2 Airborne:  ", sum_change, "PgC")
    f_note <- paste("CO2 Airborne:  ", signif(100*sum_change/sum_emis, 3),"% of Emissions")
    g_note <- "  Summary: 1960 - 2006"
# Plot
 plot(df$yr, df$emis,type = "n",  xlab="", ylab = "PgC/yr",
    ylim=c(0,8), xlim=c(1960, 2006), main=plot_title, cex.main=0.85,
    xaxs="i", yaxs="i")
 polygon(px,py, border=NA, col="lightgreen")
 points(df$yr, df$change, type="l", col = "white")
 points(df$yr, df$emis, type="l", col = "red", lwd=2)
  text(1980, 6, a_note,cex=0.8)
  rect(1979.5,4.2, 1987,4.8, col = "white", border=NA)
  text(1983, 4.5, b_note,cex=0.8)
  text(1985, 2, c_note,cex=0.8)
  arrows(1980, 5.85, 1985, 5.5, col = "darkgrey", length = 0.05)
  text(1962, 7.6, d_note,cex=0.75, adj=0 )
  text(1962, 7.4, e_note, cex=0.75, adj = 0)
  text(1962, 7.2, f_note, cex = 0.75, adj = 0)
  text(1962, 7.8, g_note, cex=0.85, adj=0)
 # Chart Annotation
   my_date <- format(Sys.time(), "%m/%d/%y")
   mtext("D Kelly O'Day - http://chartsgraphs.wordpress.com", side = 1, line = .5, cex=0.8, outer = T, adj = 0)
   mtext(my_date, side = 1, line =.5, cex = 0.8, outer = T, adj = 1)## Add script name to each plot
# Annual airborne amount calcs
  ap <- df$change/df$emis
  max_ap <- max(ap, na.rm=T)
  mean_ap <- mean(ap, na.rm=T)
  min_ap <- min(ap, na.rm=T)
  cat(c("max", max_ap), fill = 30)
  cat(c("mean", mean_ap), fill = 30)
  cat(c("min", min_ap),fill = 30)

# Leigh.Gordon added this to remove temp file
  unlink(tmpfile)


