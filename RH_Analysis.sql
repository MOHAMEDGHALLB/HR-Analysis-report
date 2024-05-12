---chech the all date 
SELECT* FROM rh;
----------------------------------------Data Preprocessing -------------------------------------------
---convert  data type column hire_date from string to date 
ALter  table rh
alter column hire_date type date
using hire_date :: date;
UPDATE rh
SET hire_date = CASE
    WHEN hire_date LIKE '%/%' THEN TO_DATE(hire_date, 'MM/DD/YYYY')
    ELSE NULL
END;
--- show if data type is changed
SELECT * FROM rh
SELECT column_name, data_type, character_maximum_length
FROM information_schema.columns
--- dalet null rows from column hire_date
WHERE table_name = 'rh';
DELETE FROM rh WHERE hire_date IS NULL;

----- change data type  of column termdate from date&time to only date
ALTER table rh
ALTER column termdate type date
using termdate:: date;
UPDATE rh
SET termdate = date(termdate)
WHERE termdate IS NOT NULL;
SELECT * from rh
----add new column age 
ALTER  table rh
ADD COLUMN age integer;
--- show if the column age is add or not
SELECT * FROM rh
--- will done now  add values to age column
UPDATE rh
SET age = CAST(DATE_PART('YEAR', AGE(CURRENT_DATE, birthdate)) AS INTEGER);
------------------------------Question----------------------------------
------ all the emp >18
SELECT count(*)from rh where age < 18; 
------ the  min &max & avg age the company
SELECT MIN(age)AS youngest,
       MAX(age)AS oldest, 
       AVG(age) as avreg
from rh;
--------------what is the age distribution of employees in the company
SELECT 
     MIN(age) as younges,
	 max(age) AS oldest
FROM rh
WHERE termdate ISNULL;
SELECT
     case
	 WHEN age>=18 AND age <= 30 THEN '20-30'
	 WHEN age>30 AND age <= 40 THEN '30-40'
	 WHEN age>40 AND age <= 50 THEN '40-50'
	 WHEN age>50 AND age <= 60 THEN '50-60'
	 ELSE '60+'
     END AS age_group,
     count(*)AS count_age
	
FROM rh 
WHERE termdate ISNULL
GROUP BY age_group
ORDER BY count_age DESC; 
---------------what is the age distribution by gender in the compny
SELECT
     case
	 WHEN age>=18 AND age <= 30 THEN '20-30'
	 WHEN age>30 AND age <= 40 THEN '30-40'
	 WHEN age>40 AND age <= 50 THEN '40-50'
	 WHEN age>50 AND age <= 60 THEN '50-60'
	 ELSE '60+'
     END AS age_group,gender,
     count(*)AS count_age
	
FROM rh 
WHERE termdate ISNULL
GROUP BY age_group,gender
ORDER BY count_age DESC; 

---------------- how many employees work Headquarters versus Remote
SELECT location_,count(*) as  count
FROM rh
GROUP BY location_
ORDER BY count DESC; 
-----------------how does  the gender distribution very across departments
SELECT department,gender,count(*)as count
FROM rh
WHERE termdate ISNULL
GROUP BY department ,gender 
ORDER BY department ;
------------what is distribution of jobtitle acrosss the company
SELECT jobtitle,count(*) as count
FROM rh
WHERE termdate ISNULL 
GROUP BY jobtitle
ORDER BY count DESC;
------------------what is distribution of loction acrosss the company
SELECT location_city,location_state,count(*)as count
FROM rh
WHERE termdate ISNULL
GROUP BY location_city,location_state
order BY count DESC;
------------------
-----------------what is the Avrage years the employees their work before terminated
SELECT  
		ROUND(AVG(EXTRACT(YEAR from AGE (termdate,hire_date))),0) AS avg_year_work_befor_terminted,gender
FROM rh
WHERE termdate<CURRENT_DATE AND termdate IS NOT NULL AND hire_date IS NOT NULL
group by gender
;
-------------What is the Distribution of Tenure Across Departments befor the employees terminted their contract?
SELECT  
		department,ROUND(AVG(EXTRACT(YEAR from AGE (termdate,hire_date))),0) AS AVG_terminted_By_Department
FROM rh
WHERE termdate<CURRENT_DATE AND termdate IS NOT NULL AND hire_date IS NOT NULL
group by department
;
--------------in which department do employees most frequently terminted their work at the company---
SELECT department,count(*)as count 
FROM rh
WHERE termdate IS NOT NULL AND CURRENT_DATE<termdate
GROUP BY department
ORDER BY count desc;
--------------what is the most gender terminated their work at the company
SELECT gender,count(*)as count
FROM rh
where termdate is not NULL
GROUP BY gender
ORDER BY count DESC;
-------------what is the most race of employees terminted their work at  the compny
SELECT race,count(*) as race_count
FROM rh
where termdate isNULL
GROUP BY race
ORDER BY race DESC;
-------------what is the most gender by department terminated their work at the company
SELECT department,gender,count(termdate)as sumterm
FROM rh
WHERE termdate IS NULL
GROUP BY department,gender
ORDER BY sumterm DESC ;
---------- what is the most the jobtitle terminted their work at the company 
SELECT jobtitle,count(*) as count
From rh
WHERE termdate<CURRENT_date
GROUP BY jobtitle
ORDER BY count DESC;
--------------- jontitle & department
SELECT jobtitle,department,count(*) as count
From rh
WHERE termdate<CURRENT_date
GROUP BY jobtitle,depatment
ORDER BY count DESC;

--------------- department &age
SELECT department,ROUND(AVG(age),0)as age,count(*) as count
  
From rh
WHERE  termdate IS NOT NULL AND termdate<CURRENT_date
GROUP BY department
ORDER BY count DESC,age DESC;
----------------In Which Department Do Employees Most Frequently Terminate Their Contracts at the Company?
SELECT department, total_count, total_termdate,
       CASE 
           WHEN total_count > 0 THEN ROUND((total_termdate::numeric / total_count)*100,0)
           ELSE NULL
       END||'%' AS  termdate_percentage
FROM (
    SELECT department,
           count(*) AS total_count,
           SUM(CASE WHEN termdate IS NOT NULL AND  CURRENT_date<termdate  THEN 1 ELSE 0 END) AS total_termdate
    FROM rh
    GROUP BY department
) AS subquery
ORDER BY  termdate_percentage DESC;
----------------------- distribution of the years' categories over departments for employees who have quit the company
SELECT department,
       count(*) as count, case
	                        WHEN age>=18 AND age <= 30 THEN '20-30'
	                        WHEN age>30 AND age <= 40 THEN '30-40'
	                        WHEN age>40 AND age <= 50 THEN '40-50'
	                        WHEN age>50 AND age <= 60 THEN '50-60'
	                        ELSE '60+'
     END AS age
From rh
WHERE  termdate IS NOT NULL AND  CURRENT_date<termdate
GROUP BY department,age
ORDER BY count DESC,age DESC;
-------how has the company's employee count change over time based on hire and term dates?
SELECT year,
       hire,
	   termintions,
	   hire-termintions as  net_change,
	   case
	       WHEN hire>0 THEN ROUND((hire-termintions::numeric)/hire*100,2) 
		   ELSE NULL
		END ||'%' as net_change
FROM (
     SELECT 
	   EXTRACT (YEAR FROM hire_date) as year,
	   count(*) as hire,
	   SUM(case  WHEN termdate IS NOT NULL AND  CURRENT_date<termdate  THEN 1 ELSE 0 END) as termintionS
	FROM rh
	GROUP BY year
	)as subquey
ORDER BY year;
------------- "Which Job Title, Across Age Categories, Has the Highest Rate of Contract Terminations at the Company?"
SELECT jobtitle,
       count(*) as count, case
	                        WHEN age>=18 AND age <= 30 THEN '20-30'
	                        WHEN age>30 AND age <= 40 THEN '30-40'
	                        WHEN age>40 AND age <= 50 THEN '40-50'
	                        WHEN age>50 AND age <= 60 THEN '50-60'
	                        ELSE '60+'
     END AS age
From rh
WHERE  termdate IS NOT NULL AND CURRENT_date<termdate
GROUP BY jobtitle,age
ORDER BY count DESC,age DESC;



---------------------- THANK YOU AND WAITING FOR YOUR FEEDBACK------------------------------


