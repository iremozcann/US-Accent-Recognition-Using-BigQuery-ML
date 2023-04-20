# US-Accent-Recognition-Using-BigqueryML
This project aims to recognize the American accent among six accents: American, British, French,
German, Italian, and Spanish. Logistic Regression machine learning algorithm is employed for the accent recognition task.
In the methods, the user-defined hyperparameters are optimized to obtain high-accuracy results. The machine learning model has been created within BigQuery in Google Cloud Platform (GCP), using SQL.

## Dataset
The “Speaker Accent Recognition” data set available on
the UCI Machine Learning Repository is being utilized in this
study. The data are derived from 330 one-minute-long
audio samples. They consist of 165 US, 45 UK, 30 ES, 30
FR, 30 GE, and 30 IT instances. There are 180 female (90
US and 90 non-US) samples and 150 male (75 US and 75
non-US) samples in total. But the gender is not considered a
feature of the classification in the experiments. There are 12
features that are extracted from the audio sample via MFCC.

## Method
Although the data set contains 6 different accents, the goal is to exclusively separate US speakers from speakers from other countries. So, a binary classification issue is created from the multi-class classification data set. The machine learning model has been created within BigQuery in Google Cloud Platform (GCP), using SQL.


# Logistic Regression Analysis with BigQuery
Logistic regression method learns and predicts the parameters in a given data set. The purpose of LR is to find the
most appropriate model to describe the relationship between
a two-way characteristic (dependent variable) and a set of
independent variables.

## 1- Examine Dataset
First of all, the multi-class classification data set is converted to a binary classification problem

<img src="https://github.com/iremozcann/US-Accent-Recognition-Using-BigqueryML/blob/main/Results-Image/create_new_dataset.png" alt="alt text" width="700">

Then, to understand the dataset, look at the first ten rows in the new_recognition table. There are 329 rows of data. The target is language and all other columns are predictors.

<img src="https://github.com/iremozcann/US-Accent-Recognition-Using-BigqueryML/blob/main/Results-Image/first-ten-rows.png" alt="alt text" width="950">

Then, See if the samples are uniformly distributed

<img src="https://github.com/iremozcann/US-Accent-Recognition-Using-BigqueryML/blob/main/Results-Image/check-imbalance-data.png" alt="alt text" width="550">

It shows that the samples are uniformly distributed. We don't need to handle imbalance in the query. Also, checked for null values in the dataset and no null values there.

## 2- Split the dataset into training and test sets
- Split into training and datasets to help detect overfitting
- Firstly,create a fake unique ID column o help with the random splitting. Then, it is 
dividing the data into train and test sets with an 80/20 split. From the new_recognition_split dataset, every fifth row is selected as test data and the other four rows are used as training data.

<img src="https://github.com/iremozcann/US-Accent-Recognition-Using-BigqueryML/blob/main/Results-Image/split-dataset.png" alt="alt text" width="900">

## 3- Create Model
Build a logistic regression model using the following query
- Splitting into training & evaluation datasets to help detect overfitting
- Since we have limited number of features only so there is no need to demolish them, hence we shall use L2 regularization
- Set enable_global_explain to true from the starting experiment itself.
- Early stopping is TRUE

<img src="https://github.com/iremozcann/US-Accent-Recognition-Using-BigqueryML/blob/main/Results-Image/train.png" alt="alt text" width="700">

In the model ; The following graphs illustrate the learning rate plotted against each iteration and the time required for each iteration to complete:

<img src="https://github.com/iremozcann/US-Accent-Recognition-Using-BigqueryML/blob/main/Results-Image/learn-rate.png" alt="alt text" width="500">

We shall try to do better than this. So, we use hyperparameter tuning. Tuning the minimum option you need to add is, num_trials. Just specify this option and your model will be trained with hyperparameter tuning using default values.
In addition, The ML.TRIAL_INFO function is used to display information regarding trials from a hyperparameter tuning model.

<img src="https://github.com/iremozcann/US-Accent-Recognition-Using-BigqueryML/blob/main/Results-Image/hyperparameter.png" alt="alt text" width="800">

We reached the maximum accuracy with 1.2 in the l2_reg parameter

<img src="https://github.com/iremozcann/US-Accent-Recognition-Using-BigqueryML/blob/main/Results-Image/hyper-result.png" alt="alt text" width="900">

###  Evaluating the model
Use the test dataset to validate the performance of our very first and simple logistic regression model.We use a binary classification model; the two classes are the values in the language column: NON-US and US
When running this query, the following results:

<img src="https://github.com/iremozcann/US-Accent-Recognition-Using-BigqueryML/blob/main/Results-Image/evaluation.png" alt="alt text" width="900">

And also;

<img src="https://github.com/iremozcann/US-Accent-Recognition-Using-BigqueryML/blob/main/Results-Image/evaluation-result.png" alt="alt text" width="900">

The ROC_AUC of the training set and the test set are practically identical and accuracy is 78%

-The ML.ROC_CURVE() function is frequently used to understand the ROC curve for assessing the effectiveness of binary logistic regression models

<img src="https://github.com/iremozcann/US-Accent-Recognition-Using-BigqueryML/blob/main/Results-Image/roc-curve.png" alt="alt text" width="750">

- For confusion matrix:

<img src="https://github.com/iremozcann/US-Accent-Recognition-Using-BigqueryML/blob/main/Results-Image/confusion-matrix.png" alt="alt text" width="700">

-Furthermore, using the GLOBAL_EXPLAIN function, which feature is contributing how much in the model’s overall prediction

<img src="https://github.com/iremozcann/US-Accent-Recognition-Using-BigqueryML/blob/main/Results-Image/global-explain.png" alt="alt text" width="700">

### Predict Model
Predict the US speakers from speakers from other countries using the data from the test table:


<img src="https://github.com/iremozcann/US-Accent-Recognition-Using-BigqueryML/blob/main/Results-Image/predict-outcome.png" alt="alt text" width="700">

And it shows that:

- The predicted_language shows whether the speakers are US or NON-US based on a 0.6 threshold that we have chosen. As long as the probability exceeds 0.6, the model would predict language = US for the speakers

<img src="https://github.com/iremozcann/US-Accent-Recognition-Using-BigqueryML/blob/main/Results-Image/predict-result.png" alt="alt text" width="950">



***References***
- D. Dua, and C. Graff,“UCI Machine Learning Repository”,
[http://archive.ics.uci.edu/ml]. Irvine, CA: University of
California, School of Information and Computer Science, 2019.
- Muttaqi, Mohammad, Ali Degirmenci, and Omer Karal. "US Accent Recognition Using Machine Learning Methods." 2022 Innovations in Intelligent Systems and Applications Conference (ASYU). IEEE, 2022.
- Karaoglu, Aleyna Nur, et al. "Performance Improvement with Decision Tree in Predicting Heart Failure." 2021 6th International Conference on Computer Science and Engineering (UBMK). IEEE, 2021.
