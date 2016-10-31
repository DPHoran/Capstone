## create a unique key that can be used to merge the datasets
inspect_work$name_addr <- paste(substr(inspect_work$ESTABLISHMENT_NAME,1,8),substr(inspect_work$ESTABLISHMENT_ADDRESS,1,8))
inspect_work <- data.frame(lapply(inspect_work, function(v) {
  if (is.character(v)) return(toupper(v))
  else return(v)
}))
sub_lic$name_addr <- paste(substr(sub_lic$Operating.Name,1,8),substr(sub_lic$Licence.Address.Line.1,1,8))
m1 <- merge(inspect_work,sub_lic, by.x = "name_addr", by.y = "name_addr")

## how many different establishments?
length(unique(m1$INSPECTION_ID))

## how many inspections did not result in an infraction?
table(m1$SEVERITY)
