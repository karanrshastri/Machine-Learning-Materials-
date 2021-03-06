#FILE: Classifying PBE 

library(RTextTools);

data <- read.csv(training_dataset_500.csv,header=FALSE)
data <- data[-1]

# ADD TEXTUAL DESCRIPTORS FOR EACH MASS CHARACTERISTIC FOR THE DOCUMENT-TERM MATRIX
EN1 <- as.vector(apply(as.matrix(data[1], mode="character"),1,paste,"EN1",sep="",collapse=""))
EN2 <- as.vector(apply(as.matrix(data[2], mode="character"),1,paste,"EN2",sep="",collapse=""))
EN3 <- as.vector(apply(as.matrix(data[3], mode="character"),1,paste,"EN3",sep="",collapse=""))
IP1 <- as.vector(apply(as.matrix(data[4], mode="character"),1,paste,"IP1",sep="",collapse=""))
IP2 <- as.vector(apply(as.matrix(data[5], mode="character"),1,paste,"IP2",sep="",collapse=""))
IP3 <- as.vector(apply(as.matrix(data[6], mode="character"),1,paste,"IP3",sep="",collapse=""))
EA1 <- as.vector(apply(as.matrix(data[7], mode="character"),1,paste,"EA1",sep="",collapse=""))
EA2 <- as.vector(apply(as.matrix(data[8], mode="character"),1,paste,"EA2",sep="",collapse=""))
EA3 <- as.vector(apply(as.matrix(data[9], mode="character"),1,paste,"EA3",sep="",collapse=""))

training_data <- cbind(data[10],EN1,EN2,EN3,IP1,IP2,IP3,EA1,ExA2,EA3)

# [OPTIONAL] SUBSET YOUR DATA TO GET A RANDOM SAMPLE
training_data <- training_data[sample(1:699,size=600,replace=FALSE),]
training_codes <- training_data[1]
training_data <- training_data[-1]

# CREATE A TERM-DOCUMENT MATRIX THAT REPRESENTS WORD FREQUENCIES IN EACH DOCUMENT
# WE WILL TRAIN ON THE Title and Subject COLUMNS
matrix <- create_matrix(training_data, language="english", removeNumbers=FALSE, stemWords=FALSE, removePunctuation=FALSE, weighting=weightTfIdf)

# CREATE A container THAT IS SPLIT INTO A TRAINING SET AND A TESTING SET
# WE WILL BE USING t(training_codes) AS THE CODE COLUMN. WE DEFINE A 200 
# ARTICLE TRAINING SET AND A 400 ARTICLE TESTING SET.
container <- create_container(matrix,t(training_codes),trainSize=1:200, testSize=201:600,virgin=FALSE)

# THERE ARE TWO METHODS OF TRAINING AND CLASSIFYING DATA.
# ONE WAY IS TO DO THEM AS A BATCH (SEVERAL ALGORITHMS AT ONCE)
models <- train_models(container, algorithms=c("MAXENT","SVM","GLMNET","SLDA","TREE","BAGGING","BOOSTING","RF"))
results <- classify_models(container, models)


# VIEW THE RESULTS BY CREATING ANALYTICS
analytics <- create_analytics(container, results)