with data as (
select
    gender,
    day,
    sum(score_points) as total
from scores
group by 2,1
order by 1,2
)
select 
gender,
day,
sum(total) over (partition by gender order by day) as total
from data