  --See if the samples are uniformly distributed

SELECT
  COUNT(*),
  (LANGUAGE)
FROM
  `accent. recognition`
GROUP BY
  (LANGUAGE) ; 

  
  --look AT the FIRST ten ROWS IN the TABLE
SELECT
  *
FROM
  `accent. recognition`
LIMIT
  10 ; 
  


--look AT the missing DATA IN the LANGUAGE COLUMN
SELECT
  COUNT(*)
FROM
  `accent. recognition`
WHERE
  LANGUAGE IS NULL ;



  --the multi-class classification data set is converted to a binary classification problem

CREATE TABLE
  `accent.new_recognition` AS
SELECT
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
IF
  (LANGUAGE = 'US', TRUE, FALSE) AS
  LANGUAGE
FROM
  `accent. recognition`


