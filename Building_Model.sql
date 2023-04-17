--create a logistic regression model for classification

CREATE OR REPLACE MODEL
  accent.recognition_pred OPTIONS(MODEL_TYPE='logistic_reg',
    INPUT_LABEL_COLS=['language'],
    l2_reg=1.5,
    early_stop=TRUE,
    max_iterations=15,
    enable_global_explain = TRUE ) AS
SELECT
  * EXCEPT(UUID)
FROM
  `ml-project-383113.accent.train_data`;



  --Evaluate the classification model

SELECT
  *
FROM
  ML.EVALUATE(MODEL `accent.recognition_pred`,
    (
    SELECT
      * EXCEPT(UUID)
    FROM
      `ml-project-383113.accent.test_data`));



	  --the model to predict the test set

SELECT
  CASE
    WHEN predicted_language = TRUE THEN 'US'
  ELSE
  'non-us'
END
  AS predicted_language,
  predicted_language_probs,
  CASE
    WHEN LANGUAGE = TRUE THEN 'US'
  ELSE
  'non-us'
END
  AS actual_language
FROM
  ML.PREDICT (MODEL `ml-project-383113.accent.recognition_pred`,
    (
    SELECT
      *
    FROM
      `ml-project-383113.accent.test_data` ),
    STRUCT(0.6 AS threshold))


	  --In BigQuery ML, roc_auc is simply a queryable field when evaluating your trained ML model
SELECT
  roc_auc,
  CASE
    WHEN roc_auc > .9 THEN 'good'
    WHEN roc_auc > .8 THEN 'fair'
    WHEN roc_auc > .7 THEN 'decent'
    WHEN roc_auc > .6 THEN 'not great'
  ELSE
  'poor'
END
  AS model_quality
FROM
  ML.EVALUATE(MODEL `accent.recognition_pred`,
    (
    SELECT
      * EXCEPT(UUID)
    FROM
      `ml-project-383113.accent.test_data`));
