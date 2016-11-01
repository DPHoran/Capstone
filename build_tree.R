## Subset the m1 data frame into training and testing datasets.
rn_train <- sample(nrow(m1), floor(nrow(m1)*0.65))
inspect_train <- m1[rn_train,]
inspect_test <- m1[-rn_train,]

## Fit a classification tree to the training data.
## Note: Further cleaning and bucketing of the License Address, Conditions, and Issue Dates are required.
fit <- rpart(Sev_Cru ~ Category + License.Address.Line.3 + Conditions + Issued, method = "class", data = inspect_train)
plot(fit, compress = T)
text(fit, use.n = T)