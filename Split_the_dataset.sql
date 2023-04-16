--created a fake uniqueID column to help with the random splitting

CREATE OR REPLACE TABLE
  `ml-project-383113.accent.new_recognition_split` AS (
  SELECT
    GENERATE_UUID() AS UUID,
    X1,
    X2,
    X3,
    X4,
    X5,
    X6,
    X7,
    X8,
    X9,
    X10,
    X11,
    X12,
    LANGUAGE
  FROM
    `ml-project-383113.accent.new_recognition`);



--Split the dataset into training and test sets


CREATE OR REPLACE TABLE
  `ml-project-383113.accent.test_data`AS
SELECT
  *
FROM
  `ml-project-383113.accent.new_recognition_split`
WHERE
  MOD(ABS(FARM_FINGERPRINT(UUID)), 5) = 0;
CREATE OR REPLACE TABLE
  `ml-project-383113.accent.train_data` AS
SELECT
  *
FROM
  `ml-project-383113.accent.new_recognition_split`
WHERE
  NOT UUID IN (
  SELECT
    DISTINCT UUID
  FROM
    `ml-project-383113.accent.test_data`);




--- \\ Extra // ---
--EXTRA: not used in this project, but the dataset can be divided into three as train, test and validation. 
--If you want to use this as an extra, the code is:

CREATE OR REPLACE TABLE
  accent.training_data AS
WITH DATA AS (
  SELECT
    *,
    RAND() AS rand
  FROM
    `ml-project-383113.accent.new_recognition` ),
  training_data AS (
  SELECT
    *
  FROM
    DATA
  WHERE
    rand < 0.6)
SELECT
  *
FROM
  training_data;
CREATE OR REPLACE TABLE
  accent.validation_data AS
WITH DATA AS (
  SELECT
    *,
    RAND() AS rand
  FROM
    `ml-project-383113.accent.new_recognition` ),
  validation_data AS (
  SELECT
    *
  FROM
    DATA
  WHERE
    rand >= 0.6
    AND rand < 0.8)
SELECT
  *
FROM
  validation_data;
CREATE OR REPLACE TABLE
  accent.test_data AS
WITH DATA AS (
  SELECT
    *,
    RAND() AS rand
  FROM
    `ml-project-383113.accent.new_recognition` ),
  test_data AS (
  SELECT
    *
  FROM
    DATA
  WHERE
    rand >= 0.8)
SELECT
  *
FROM
  test_data;