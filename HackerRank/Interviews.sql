--Interviews

--Output:
	contest_id,
	hacker_id,
	name,
	sum(total_submissions),
	sum(total_accepted_submissions),
	sum(total_views),
	sum(total_unique_views)

--tables:
1. contests: contest_id, hacker_id, name
2. colleges: college_id, contest_id
3. challenges: challenge_id, college_id
4. view_stats: challenge_id, total_views, total_unique_views
5. submission_stats: challenge_id, total_submissions, total_accepted_submissions
	
--Conditions:
1. For each contest:
2. group by contest_id
3. order by contest_id
4. exclude contest if all 4 sums are 0

--Code:

with submissions_data as (
    SELECT
        c.contest_id as contest_id,
        c.hacker_id,
        coalesce(sum(ss.total_submissions),0) as total_submissions,
        coalesce(sum(ss.total_accepted_submissions),0) as total_accepted_submissions
    FROM contests c
    LEFT JOIN colleges cg
        ON c.contest_id = cg.contest_id
    LEFT JOIN challenges ch
        ON cg.college_id = ch.college_id
    Left JOIN submission_stats ss
        ON ch.challenge_id = ss.challenge_id
    GROUP BY c.contest_id,c.hacker_id,c.name
),
views_data as (
    SELECT
        c.contest_id as contest_id,
        c.hacker_id,
        coalesce(sum(ss.total_views),0) as total_views,
        coalesce(sum(ss.total_unique_views),0) as total_unique_views
    FROM contests c
    LEFT JOIN colleges cg
        ON c.contest_id = cg.contest_id
    LEFT JOIN challenges ch
        ON cg.college_id = ch.college_id
    Left JOIN view_stats ss
        ON ch.challenge_id = ss.challenge_id
    GROUP BY c.contest_id,c.hacker_id,c.name
)

select 
    c.contest_id,
    c.hacker_id,
    c.name,
    s.total_submissions,
    s.total_accepted_submissions,
    v.total_views,
    v.total_unique_views
from contests c
join submissions_data s 
    ON c.contest_id = s.contest_id
JOIN views_data v
    ON c.contest_id = v.contest_id
WHERE 
    s.total_submissions >0
 or s.total_accepted_submissions>0
 or v.total_views>0
 or v.total_unique_views>0
 
 order by c.hacker_id