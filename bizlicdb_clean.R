## Read business license data.
licenses <- read.csv("C:/Users/Jenn & Dave/Documents/Capstone/business.licences.17Sept.csv",header = T, sep = ",")

## Look at the structure of the business license data.
str(licenses)

## Convert Cancel.Date into date format.
licenses$Cancel.Date1 <- as.Date(format(strptime(licenses$Cancel.Date, "%d-%b-%Y"),"%d/%m/%y"),"%d/%m/%y")

## Subset on businesses that deal with food
levels(licenses$Category)
sub_lic <- subset(licenses, Category %in% c("BOULEVARD CAFE","EATING ESTABLISHMENT","ENTERTAINMENT ESTABLISHMENT/NIGHTCLUB","MOBILE VENDING (FOOD TRUCK)","MOBILE VENDING (ICE CREAM TRUCK)","RETAIL STORE (FOOD)","THEATRE"))
