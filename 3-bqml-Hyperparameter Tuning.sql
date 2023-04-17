--Hyperparameter Tuning

CREATE OR REPLACE MODEL
  accent.recognition_hp OPTIONS(MODEL_TYPE='logistic_reg',
    INPUT_LABEL_COLS=['language'],
    early_stop=TRUE,
    max_iterations=15,
    enable_global_explain = TRUE,
    NUM_TRIALS=7,
    l2_reg = HPARAM_RANGE(0.9,
      1.5)) AS
SELECT
  * EXCEPT(UUID)
FROM
  `ml-project-383113.accent.train_data`



--The ML.TRIAL_INFO function is used to display information regarding trials from a hyperparameter tuning model

SELECT * FROM ML.TRIAL_INFO(MODEL `accent.recognition_hp`)


