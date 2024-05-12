# HR-Analysis 
## Project overview
Our project entails a comprehensive analysis of the company's employee demographics, including average age, distribution, gender, and race. By examining these factors, we aim to identify potential influences on employee terminations. Through this analysis, we seek to gain valuable insights that will inform strategies for enhancing employee retention and organizational effectiveness."
## Table of Countents
## Date used 
 - HR Data with over 22000 rows from the year 2000 to 202
## Tools 
1- Excel
2-postgresql
3-SQL
4-Power-BI
## Data Preprocessing 
- convert  data typ
- dalet null rows
- add new column 
## Questions
- is all the employees >18?
- the  min &max & avg age the company
- what is the age distribution of employees in the company
- what is the age distribution by gender in the compny
- how many employees work Headquarters versus Remote
- how does  the gender distribution very across departments
- what is distribution of jobtitle acrosss the company
- what is distribution of loction acrosss the company
-  how has the company's employee count change over time based on hire and term dates?
- what is the Avrage years the employees their work before terminated
-  What is the Distribution of Tenure Across Departments befor the employees terminted their contract?
-  in which department do employees most frequently terminted their work at the compan
-  what is the most gender terminated their work at the company
-  what is the most race of employees terminted their work at  the compny
-  what is the most gender by department terminated their work at the company
-  In which age group are terminated employees who worked at the company, grouped by department?
-  In Which Department Do Employees Most Frequently Terminate Their Contracts at the Company?
-  distribution of the years' categories over departments for employees who have quit the company
-  


## Data analysis 
## Results
- There are more male employees
- White race is the most dominant while Native Hawaiian and American Indian are the least dominant.
- The youngest employee is 20 years old and the oldest is 57 years old
- 5 age groups were created (18-24, 25-34, 35-44, 45-54, 55-64). A large number of employees were between 25-34 followed by 35-44 while the smallest group was 55-64
- A large number of employees work at the headquarters versus remotely.
- The average length of employment for terminated employees is around 7 years.
- The gender distribution across departments is fairly balanced but there are generally more male than female employees.
- The Marketing department has the highest turnover rate followed by Training. The least turn over rate are in the Research and development, Support and Legal departments
- A large number of employees come from the state of Ohio.
- The net change in employees has increased over the years.
- The average tenure for each department is about 8 years with Legal and Auditing having the highest and Services, Sales and Marketing having the lowest.

## Limitation
Some records had negative ages and these were excluded during querying(967 records). Ages used were 18 years and above.
Some termdates were far into the future and were not included in the analysis(1599 records). The only term dates used were those less than or equal to the current date.
