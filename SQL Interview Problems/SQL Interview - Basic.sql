-- Worker table queries

--Create table
CREATE TABLE Worker (
WORKER_ID INT NOT NULL PRIMARY KEY,
FIRST_NAME CHAR(25),
LAST_NAME CHAR(25),
SALARY INT,
JOINING_DATE DATETIME,
DEPARTMENT CHAR(25)
);

--Insert data
INSERT INTO Worker
(WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE,DEPARTMENT) VALUES
(1, 'Siddharth', 'Singh', 80000, '2019-03-20 09:00:00', 'HR'),
(2, 'Lavesh', 'Ahir', 300000, '2019-07-11 09:00:00', 'Admin'),
(3, 'Abhishek', 'Midha', 500000, '2019-03-20 09:00:00', 'HR'),
(4, 'Rahul', 'Mahar',200000, '2020-03-20 09:00:00', 'Admin'),
(5, 'Saurabh', 'Madavi', 90000, '2019-07-11 09:00:00', 'Admin'),
(6, 'Aman', 'Nain', 75000, '2020-07-11 09:00:00','Account'),
(7, 'Vaibhav', 'Varshney', 100000, '2019-02-20 09:00:00', 'Account'),
(8, 'Farhaan', 'Majied', 500000, '2019-05-11 09:00:00', 'Admin'),
(9, 'Vipul', 'Singh', 450000, '2024-03-20 09:00:00', 'Data Team'),
(10, 'Satish', 'Rajput', 700000, '2024-03-11 09:00:00', 'Data Team');

----------------------------------------------------------------------------------------------------------------------------------------------------


--Q1. Write a SQL Query to create table 'Title' which has WORKER_REF_ID as foreign key
	CREATE TABLE Title (
	WORKER_REF_ID INT,
	WORKER_TITLE CHAR(25),
	AFFECTED_FROM DATETIME,
	FOREIGN KEY (WORKER_REF_ID) REFERENCES Worker(WORKER_ID) 

	ON DELETE CASCADE
	);

--insert values to title table
	insert into title 
	(WORKER_REF_ID,WORKER_TITLE,AFFECTED_FROM) values
	(1, 'Manager', '2021-02-20 00:00:00'),
	(2, 'Executive', '2021-06-11 00:00:00'),
	(8, 'Executive', '2021-06-11 00:00:00'),
	(5, 'Manager', '2021-06-11 00:00:00'),
	(4, 'Asst. Manager', '2021-06-11 00:00:00'),
	(7, 'Executive', '2021-06-11 00:00:00'),
	(6, 'Lead', '2021-06-11 00:00:00'),
	(3, 'Lead', '2021-06-11 00:00:00');


--Q2. Write a SQL query to clone a new table WorkCopy from another table.

	--M1: The general query to clone a table with data is:
	SELECT * INTO WorkerCopy1 FROM Worker2;
	
	--M2: Clone without data
	SELECT * into workerCopy2 from worker2
	where 1=0;

--Q3. Write a SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending and DEPARTMENT Descending.
	select * from worker
	order by first_name asc, department desc;

--Q4. Write a SQL query to print details of the Workers who have joined in Mar’2019.
	select * from worker
	where year(joining_date)=2019 and month(joining_date)=3;

--Q5. Write a SQL query to show the current date and time.
	select getdate();

--Q6. Write a SQL query to fetch the count of employees working in the department ‘Admin’.
	select count(*) from worker2
	where DEPARTMENT='Admin';

--Q7. Write a SQL query to fetch the no. of workers for each department in the descending order.
	select department, count(worker_id) no_of_workers from worker2
	group by department
	order by no_of_workers desc;

--Q8. Write a SQL query to fetch departments along with the total salaries paid for each of them.
	select department, sum(SALARY) total_salary from worker2
	group by department;

--Q9. Write a SQL query to show all departments along with the number of people in there.
	select department, count(worker_id) No_of_worker from worker2
	group by department;

--Q10. Write a SQL query to fetch the departments that have less than fivepeople in it.
	select department, count(worker_id) No_of_worker from worker2
	group by department
	having count(worker_id)<5;

--Q11. Write a SQL query to show one row twice in results from a table with department 'HR'.
	select * from worker w1
	where w1.DEPARTMENT='HR'
	union all
	select * from worker w2
	where w2.DEPARTMENT='HR';

--Q12. Write a SQL query to fetch the names of workers who earn the highest salary.
	select * from worker
	where salary=(select max(salary) from worker2);

--Q13. Write a SQL query to show the second highest salary from a table.
	select * from worker
	where salary=(select max(salary) from worker2 
					where salary	!=	(select max(salary) from worker2));

--Q14. Write a SQL query to show the top n (say 10) records of a table.
	select top(3) * from worker2;

--Q15. Write a SQL query to determine the nth highest salary from a table.
	--M1: using limit and OFFSET
		SELECT DISTINCT salary 
		FROM worker 
		ORDER BY salary DESC 
		LIMIT 1 OFFSET N-1;
	
	--M2: Using subquery
		SELECT salary 
		FROM worker w1 
		WHERE (N-1) = (SELECT COUNT(DISTINCT salary) FROM worker w2 WHERE w2.salary > w1.salary);

--Q16. Write a SQL query to fetch three max salaries from a table.
	select distinct salary 
	from worker2 a
	where 3 > (select count(distinct(salary)) from worker2 b 
				where b.salary>=a.SALARY)
	order by a.salary desc;

--Q17. Write a SQL query to fetch three min salaries from a table.
	SELECT DISTINCT(salary)
	FROM worker w1
	WHERE 3 < (SELECT COUNT(DISTINCT(salary))
				FROM worker w2
				WHERE w1.salary < w2.salary)
	ORDER BY salary 

--Q18. Write a SQL query to fetch the list of employees with the same salary.
	Select distinct W.WORKER_ID, W.FIRST_NAME, W.Salary
	from Worker W, Worker W1
	where W.Salary = W1.Salary and W.WORKER_ID != W1.WORKER_ID;
	
--Q19. Write a SQL query to print details of the Workers who are also Managers.
	SELECT DISTINCT W.FIRST_NAME, T.WORKER_TITLE
	FROM Worker2 W
	JOIN Title2 T
	ON W.WORKER_ID = T.WORKER_REF_ID
	AND T.WORKER_TITLE in ('Manager');

--Q20. Write a SQL query to compute the average salary of Workers for each job title.
	SELECT worker_title, avg(salary)
	FROM worker w
	JOIN title t
	ON w.worker_id = t.worker_ref_id
	GROUP BY worker_title

--Q21. Write a SQL query to print the name of employees having the highest salary in each department.
	SELECT department, MAX(salary)
	FROM worker
	GROUP BY department

--Q22. Write an SQL query to fetch “FIRST_NAME” from the Worker table in upper case.
	select upper(first_name) as First_name from worker;
	
--Q23. Write an SQL query to print the first three characters of  FIRST_NAME from the Worker table.
	--M1:
	select left(first_name,3) from worker;
	--M2:
	select substring(first_name,1,3) as first_name from  worker;

--Q24. Write an SQL query to find the position of the alphabet (‘a’) in the first_name  from the Worker table.
	SELECT first_name, CHARINDEX('a',FIRST_NAME) AS "Position of a"
	FROM worker

--Q25. Write an SQL query to print the FIRST_NAME from the Worker table after removing white spaces from the right side.
	SELECT first_name,RTRIM(first_name) FROM worker;

--Q26. Write An SQL Query To Print The DEPARTMENT From Worker Table After Removing White Spaces From The Left Side.
	SELECT first_name, Ltrim(first_name) 
	from worker;

--Q27, Write an SQL Query the fetches uniques values of department from WORKER and print its length
	SELECT DISTINCT department, len(DEPARTMENT) AS "Lenth of Department"
	FROM Worker


--Q28. Write an SQL query to print First_NAME after replacing 'a' with 'A'
	SELECT first_name, REPLACE(FIRST_NAME,'a','A') 
	FROM Worker


--Q29. Write an SQL Query to print FIRST_NAME and LAST_NAME in a single column as 'Full_name'
	Select FIRST_NAME, LAST_NAME, CONCAT(FIRST_NAME,' ',LAST_NAME) as 'Full Name'
	from Worker

--Q30. Write an SQL query to print details for workers with first_name  as "Vipul" and "Satish"
	select *
	from Worker
	where FIRST_NAME in ('Vipul','Satish')

--Q31. Write as SQL query to print details of workers excluding "Vipul" and "Satish"
	select * 
	from worker 
	where First_name not in ('Vipul', 'Satish');

--Q32. Write an SQL query to print details of the Workers whose FIRST_NAME contains ‘a’.
	select * from worker
	where FIRST_NAME like '%a%';

--Q33. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘a’.
	select * 
	from Worker
	where FIRST_NAME like '%a%';	
	
--Q34. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘h’ and contains six alphabets.
	select * 
	from worker
	where FIRST_NAME like '_____h';

--Q35. Write an SQL query to print details of the Workers who joined in March 2024.
	select * 
	from Worker
	where year(JOINING_DATE) = 2024 and MONTH(JOINING_DATE) = 3 

--Q36. Write an SQL query to fetch the count of employees working in the department ‘Admin’ and 'HR'.
	select DEPARTMENT, COUNT(WORKER_ID) AS 'No. of Employees'
	from Worker
	group by DEPARTMENT
	having DEPARTMENT in ('Admin', 'HR')

--Q37. Write an SQL query to fetch the number of workers for each department in descending order.
	select DEPARTMENT, COUNT(WORKER_ID) AS 'Count of Employees'
	from Worker
	group by 1
	order by 2 desc

--Q38. Write an SQL query to print details of the Workers who are also Managers.
	select *
	from Worker w Join Title t
	ON w.WORKER_ID = t.WORKER_REF_ID
	where t.WORKER_TITLE = 'Manager'
	
--Q39. Write an SQL query to fetch duplicate records having matching data in some fields of a table.
	--M1: simple Group by 
	select department, count(*) as Count_Of 
	from worker 
	group by department
	having count(*)>1;

--Q40. Write an SQL query to show only details of even WORKER_ID from a table.
	select *
	from Worker
	where WORKER_ID%2 = 0
	
--Q41. Write an SQL query to show records from one table that another table does not have.
	--M1: Using Left Join
	SELECT t1.* 
	FROM table1 t1
	LEFT JOIN table2 t2 ON t1.account_id = t2.accountid
	WHERE t2.account_id IS NULL;
	
	--M2: Using NOT EXISTS
	SELECT * 
	FROM table1 t1
	WHERE NOT EXISTS (
		SELECT 1 
		FROM table2 t2
		WHERE t1.account_id = t2.account_id
	);



--Q42. Write SQL query to fetch duplicate records from the table
	select FIRST_NAME,count(WORKER_ID) as 'Duplicates'
	from Worker
	group by FIRST_NAME
	having count(WORKER_ID)>1
