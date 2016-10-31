## Read inspection data, which is in .xml format.
install.packages("XML")
library("XML")
dinesafe.tmp <- "C:/Users/Jenn & Dave/Documents/Capstone/dinesafe.Sept17.xml"
dinesafe <- xmlTreeParse(dinesafe.tmp)
class(dinesafe)
xmltop <- xmlRoot(dinesafe)
inspections <- xmlSApply(xmltop, function(x) xmlSApply(x, xmlValue))
inspect_df <- data.frame(t(inspections),row.names=NULL)

## Organize inspection data.
colnames(inspect_df)
inspect_df$ROW_ID <- as.numeric(inspect_df$ROW_ID)
inspect_df$ESTABLISHMENT_ID <- as.numeric(inspect_df$ESTABLISHMENT_ID)
inspect_df$ESTABLISHMENT_ID <- as.factor(inspect_df$ESTABLISHMENT_ID)
inspect_df$INSPECTION_ID <- as.numeric(inspect_df$INSPECTION_ID)
inspect_df$ESTABLISHMENT_NAME <- as.character(inspect_df$ESTABLISHMENT_NAME)
inspect_df$ESTABLISHMENTTYPE <- as.character(inspect_df$ESTABLISHMENTTYPE)
inspect_df$ESTABLISHMENTTYPE <- as.factor(inspect_df$ESTABLISHMENTTYPE)
inspect_df$ESTABLISHMENT_ADDRESS <- as.character(inspect_df$ESTABLISHMENT_ADDRESS)
inspect_df$ESTABLISHMENT_ADDRESS <- as.factor(inspect_df$ESTABLISHMENT_ADDRESS)
inspect_df$ESTABLISHMENT_STATUS <- as.character(inspect_df$ESTABLISHMENT_STATUS)
inspect_df$ESTABLISHMENT_STATUS <- as.factor(inspect_df$ESTABLISHMENT_STATUS)
inspect_df$MINIMUM_INSPECTIONS_PERYEAR <- as.numeric(inspect_df$MINIMUM_INSPECTIONS_PERYEAR)
inspect_df$MINIMUM_INSPECTIONS_PERYEAR <- as.factor(inspect_df$MINIMUM_INSPECTIONS_PERYEAR)
inspect_df$INFRACTION_DETAILS <- as.character(inspect_df$INFRACTION_DETAILS)
inspect_df$INFRACTION_DETAILS <- as.factor(inspect_df$INFRACTION_DETAILS)
inspect_df$INSPECTION_DATE <- as.character(inspect_df$INSPECTION_DATE)
inspect_df$INSPECTION_DATE <- as.Date(inspect_df$INSPECTION_DATE)
inspect_df$SEVERITY <- as.character(inspect_df$SEVERITY)
inspect_df$SEVERITY <- as.factor(inspect_df$SEVERITY)
inspect_df$ACTION <- as.character(inspect_df$ACTION)
inspect_df$ACTION <- as.factor(inspect_df$ACTION)
inspect_df$COURT_OUTCOME <- as.character(inspect_df$COURT_OUTCOME)
inspect_df$COURT_OUTCOME <- as.factor(inspect_df$COURT_OUTCOME)
inspect_df$AMOUNT_FINED <- as.numeric(inspect_df$AMOUNT_FINED)

## Create a list of all unique inspection IDs:
sub_insp <- subset(inspect_df,select = ESTABLISHMENT_ID:ESTABLISHMENT_STATUS)
inspect_unique <- unique(sub_insp)

## Create a list of inspection IDs that resulted in either Significant (S) or Crucial (C) Severity.
## Note: There may be duplicate inspection records in this list.
inspect_SevCru <- inspect_df[inspect_df$SEVERITY %in% c("C - Crucial","S - Significant"),3]

## Flag each of the unique inspections based on whether it resulted in a Significant or Crucial violation.
Sev_Cru <- vector()
for (i in 1:length(inspect_unique$INSPECTION_ID)){
  if (inspect_unique$INSPECTION_ID[i] %in% inspect_SevCru){
    Sev_Cru[i] <- T}
  else{
    Sev_Cru[i] <- F }}

## Bind the unique inspection records with the Severity indicator.
## We now have a list of unique inspections, flagged for whether or not they resulted in a Crucial or Significant violation.
inspect_work <- as.data.frame(cbind(inspect_unique, Sev_Cru))
sum(inspect_work$Sev_Cru)
