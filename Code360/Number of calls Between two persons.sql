--Table:
1. Calls: from_id, to_id, duration

--Problem Statement:
-- Write an SQL query to report the number of calls and the total call duration between each pair of distinct persons (person1, person2) where person1 < person2.

select
    case when from_id < to_id then from_id else to_id end as person1,
    case when from_id < to_id then to_id else from_id end as person2,
    count(*) as call_count,
    sum(duration) as total_duration
from calls
group by 1,2