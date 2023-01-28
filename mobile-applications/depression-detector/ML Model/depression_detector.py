import numpy as np
import matplotlib.pyplot as plt
import tensorflow as tf

import pandas as pd
# Cleaning the texts
import re
import nltk
import mkl

r  = 2
temp = pd.read_csv('SentimentAnalysisDataset2.csv',error_bad_lines=False)
dataset = temp.head(r)
print(dataset)
print("endof dataset")



y = dataset.iloc[:, 1].values
print("y -> " +str(y[0]))

X = dataset.iloc[:, 3].values
print("x-> " +  str(X[0]))


'''
nltk.download('stopwords')

from nltk.corpus import stopwords
from nltk.stem.porter import PorterStemmer
corpus = []
for i in range(0, r):
    tweet = re.sub('[^a-zA-Z]', ' ', dataset['SentimentText'][i])
    tweet = tweet.lower()
    tweet = tweet.split()
    ps = PorterStemmer()
    tweet = [ps.stem(word) for word in tweet if not word in set(stopwords.words('english'))]
    tweet = ' '.join(tweet)
    corpus.append(tweet)
print("tweet : "+ str(corpus[0]))
print("after corpus")
# Creating the Bag of Words model
from sklearn.feature_extraction.text import CountVectorizer
cv = CountVectorizer(max_features = 1500)
x = cv.fit_transform(corpus).toarray()
'''
#print("x from corpus: " + str(x[1]))
X = dataset.iloc[:, 3].values
print("x after stopwords" +str(X[0]))
# Splitting the dataset into the Training set and Test set
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.20, random_state = 0)
#print("X_train: " + str(X_train))
#X_train = X_train.astype(([str],[str]))
print("X_train: " + str(X_train))
# Training the Naive Bayes model on the Training set
from sklearn.naive_bayes import GaussianNB
classifier = GaussianNB()
classifier.fit(X_train, y_train)

# Predicting the Test set results
y_pred = classifier.predict(X_test)
print("CHECK X ==>" + str((X_test)))
print("answer : " + str(y_pred ))
# Making the Confusion Matrix
from sklearn.metrics import confusion_matrix
cm = confusion_matrix(y_test, y_pred)
print(cm)

print("done")

from sklearn.metrics import accuracy_score
print(accuracy_score(y_test, y_pred))







#X = dataset.iloc[:, 1].values
#y = dataset.iloc[:, 4].values


