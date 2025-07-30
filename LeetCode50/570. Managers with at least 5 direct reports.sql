--570. Managers with at least 5 direct reports

--tables
1. employee: id, name, department, managerId

--Conditions:
query the name of the employee with atleast 5 employees reporting to him

CODE:

with managers as ( 
SELECT
    managerId,
    count(*) as juniors
FROM employee
group by managerId
having count(*)>=5
)

SELECT 
    e.name
FROM employee e
JOIN managers m
    ON e.id=m.managerId