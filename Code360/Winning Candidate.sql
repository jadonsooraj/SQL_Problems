SELECT
    Name as "Name"
from Candidate c
join vote v
on c.id = v.candidateId
group by c.id, c.Name
order by count(v.id) desc
limit 1 