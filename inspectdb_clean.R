## Read inspection data, which is in .xml format.
install.packages("XML")
library("XML")
dinesafe.tmp <- "C:/Users/Jenn & Dave/Documents/Capstone/dinesafe.Sept17.xml"
dinesafe <- xmlTreeParse(dinesafe.tmp)
class(dinesafe)
xmltop <- xmlRoot(dinesafe)
inspections <- xmlSApply(xmltop, function(x) xmlSApply(x, xmlValue))
inspect_df <- data.frame(t(inspections),row.names=NULL)