--1075. Project Employees 1

--Tables:
1. project: project_id, employee_id
2. employee: employee_id, name, experience_years

--Conditions:
1. write query to find average experience  of all the employees for each project
2. round(avg_exp,2)

--output: project_id, average_years

CODE:

SELECT
    p.project_id,
    round(avg(e.experience_years),2) as average_years
FROM project p
LEFT JOIN employee e
    ON p.employee_id=e.employee_id
group by 1
