SQL Project Planning


--conditions:
1. List start and end date for all different projects (tasks which are part of a same project ie where Start and end date are same)
2. order by No of days  to complete a project , start date
3. It is guaranteed that the difference between the End_Date and the Start_Date is equal to 1 day for each row in the table.




--output: start_date, end_date

CODE:

with start_date_cte as(
    SELECT
    start_date,
    row_number() over(order by start_date) as rnk
    FROM projects
    WHERE start_date NOT IN (Select end_date from projects)
),
end_date_cte as (
    SELECT
    end_date,
    row_number() over(order by end_date ) as rnk
    FROM projects
    where end_date NOT IN (SELECT start_date from projects)
)
SELECT 
    start_date,
    end_date
FROM start_date_cte a
JOIN end_date_cte b
    ON a.rnk =b.rnk
order by datediff(day,start_date,end_date),start_date
    