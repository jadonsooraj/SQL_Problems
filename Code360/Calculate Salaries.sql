--table:
1. Salaries: company_id, employee_id, employee_name, salary


--problem Statement:
-- Write an SQL query to find the salaries of the employees after applying taxes.

-- The tax rate is calculated for each company based on the following criteria:

-- 0% If the max salary of any employee in the company is less than 1000$.
-- 24% If the max salary of any employee in the company is in the range [1000, 10000] inclusive.
-- 49% If the max salary of any employee in the company is greater than 10000$.
-- Return the result table in any order. Round the salary to the nearest integer.

with company_max as (
    select
    company_id, 
    max(salary) as maxSalary
    from salaries
    group by 1
)
select 
s.company_id,
s.employee_id,
s.employee_name,
round(case  
    when maxSalary < 1000 then salary
    when maxSalary < 10000 then salary - 0.24*salary
    when maxSalary > 10000 then salary - 0.49*salary
end,0) as salary
from salaries s
left join company_max c
on s.company_id = c.company_id