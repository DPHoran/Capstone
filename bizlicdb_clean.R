## Read business license data.
licenses <- read.csv("C:/Users/Jenn & Dave/Documents/Capstone/business.licences.17Sept.csv",header = T, sep = ",")

## Look at the structure of the business license data.
str(licenses)

## Convert Cancel.Date into date format.
licenses$Cancel.Date1 <- as.Date(format(strptime(licenses$Cancel.Date, "%d-%b-%Y"),"%d/%m/%y"),"%d/%m/%y")

## Subset on businesses that deal with food
levels(licenses$Category)
sub_lic <- subset(licenses, Category %in% c("ADULT ENTERTAINMENT CLUB","BILLIARD HALL","BOULEVARD CAFE","BOWLING HOUSE","CURBLANE VENDING","EATING ESTABLISHMENT","ENTERTAINMENT ESTABLISHMENT/NIGHTCLUB","MOBILE VENDING (FOOD TRUCK)","MOBILE VENDING (ICE CREAM TRUCK)","MOTORIZED REFRESHMENT VEHICLE OWNER","NON-MOTORIZED REFRESHMENT VEHICLE OWNER","PLACE OF AMUSEMENT","PUBLIC HALL","RETAIL STORE (FOOD)","THEATRE"))

## Remove business licenses cancelled prior to Aug 31, 2014.
sub_lic <- subset(sub_lic, (is.na(Cancel.Date1) == T | Cancel.Date1 > "2014/08/30"))

## Create a new attribute for Forward Sortation Area (first three digits of Postal Code)
sub_lic$FSA <- substr(sub_lic$Licence.Address.Line.3,1,3)
length(unique(sub_lic$FSA))


