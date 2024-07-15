create database calls;

use calls;

SELECT 
    *
FROM
    calls1;


-- The call_timestamp is a string and we need to convert it to a date

-- shutting off safe_updates because otherwise, it will give the output in the form of yyyy/mm/dd
set sql_safe_updates = 0;
UPDATE calls 
SET 
    call_timestamp = STR_TO_DATE(call_timestamp, '%m/%d/%Y');
UPDATE calls 
SET 
    csat_score = NULL
WHERE
    csat_score = 0;
set sql_safe_updates = 1;

-- EDA

alter table calls 
rename calls1;
-- let's see shape of our data i.e., number of rows and columns
SELECT 
    COUNT(*) AS rows_num
FROM
    calls;
SELECT 
    COUNT(*) AS rows_num
FROM
    information_schema.columns
WHERE
    table_name = 'calls1';

-- Checking the distinct values of some column

select distinct sentiment from calls1;

select distinct reason from calls1;

select distinct channel from calls1;

select distinct response_time from calls1;

select distinct call_center from calls1;

-- The count and percentage from total of the distinct values we got: 

SELECT 
    sentiment,
    COUNT(*),
    ROUND(COUNT(*) / (SELECT 
                    COUNT(*)
                FROM
                    calls1) * 100,
            1) AS percentage
FROM
    calls1
GROUP BY sentiment
ORDER BY percentage DESC;

SELECT 
    reason,
    COUNT(*),
    ROUND(COUNT(*) / (SELECT 
                    COUNT(*)
                FROM
                    calls1) * 100,
            1) AS percentage
FROM
    calls1
GROUP BY reason
ORDER BY percentage DESC;

SELECT 
    channel,
    COUNT(*),
    ROUND(COUNT(*) / (SELECT 
                    COUNT(*)
                FROM
                    calls1) * 100,
            1) AS percentage
FROM
    calls1
GROUP BY channel
ORDER BY percentage DESC;

SELECT 
    response_time,
    COUNT(*),
    ROUND(COUNT(*) / (SELECT 
                    COUNT(*)
                FROM
                    calls1) * 100,
            1) AS percentage
FROM
    calls1
GROUP BY response_time
ORDER BY percentage DESC;

SELECT 
    call_center,
    COUNT(*),
    ROUND(COUNT(*) / (SELECT 
                    COUNT(*)
                FROM
                    calls1) * 100,
            1) AS percentage
FROM
    calls1
GROUP BY call_center
ORDER BY percentage DESC;

SELECT 
    state, COUNT(*)
FROM
    calls1
GROUP BY 1
ORDER BY 2 DESC;


SELECT 
    reason,
    COUNT(*),
    ROUND(COUNT(*) / (SELECT 
                    COUNT(*)
                FROM
                    calls1) * 100,
            1) AS percentage
FROM
    calls1
GROUP BY reason
ORDER BY percentage DESC;

-- Here we can see that Billing Question covers the 71% of all calls. 

-- Which day has the most calls? 

SELECT 
    DAYNAME(call_timestamp) AS Day_of_call,
    COUNT(*) AS num_of_calls
FROM
    calls1
GROUP BY Day_of_call
ORDER BY num_of_calls DESC;
-- Friday has the most nu,ber of calls while Sunday has the least. 

-- Aggregations

SELECT 
    MIN(csat_score) AS min_score,
    MAX(csat_score) AS max_score,
    ROUND(AVG(csat_score), 1) AS avg_score
FROM
    calls1
WHERE
    csat_score != 0; 

SELECT 
    MIN(call_timestamp) AS earliest_date,
    MAX(call_timestamp) AS most_recent
FROM
    calls1;

alter table calls1
rename column `call duration in minutes` to call_duration_in_minutes;

SELECT 
    MIN(call_duration_in_minutes) AS min_call_duration,
    MAX(call_duration_in_minutes) AS max_call_duration,
    AVG(call_duration_in_minutes) AS avg_call_duration
FROM
    calls1;

SELECT 
    call_center, response_time, COUNT(*) AS count
FROM
    calls1
GROUP BY call_center, response_time
ORDER BY call_center, count DESC;

SELECT 
    call_center, AVG(call_duration_in_minutes)
FROM
    calls1
GROUP BY call_center
ORDER BY 2 DESC;

SELECT 
    channel, AVG(call_duration_in_minutes)
FROM
    calls1
GROUP BY channel
ORDER BY 2 DESC;

SELECT 
    sentiment, AVG(call_duration_in_minutes)
FROM
    calls1
GROUP BY sentiment
ORDER BY 2 DESC; 

SELECT 
    state, COUNT(*)
FROM
    calls1
GROUP BY state
ORDER BY 2 DESC;

SELECT 
    state, reason, COUNT(*)
FROM
    calls1
GROUP BY state , reason
ORDER BY state , reason , COUNT(*) DESC;

SELECT 
    state, sentiment, COUNT(*)
FROM
    calls1
GROUP BY state , sentiment
ORDER BY COUNT(*) DESC;

SELECT 
    state, ROUND(AVG(csat_score), 1) AS avg_csat_score
FROM
    calls1
WHERE
    csat_score != 0
GROUP BY state
ORDER BY avg_csat_score DESC;

