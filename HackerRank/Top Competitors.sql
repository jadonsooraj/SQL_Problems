Top Competitors

--tables:
1. hackers: hacker_id, name
2. difficulty: difficulty_level, score
3. challenges: challanage_id, hacker_id, difficulty_level
4. submissions: submissions_id, hacker_id, challange_id, score

--Output: hacker_id, name

--Conditions:
Condition1: hackers who acheived full scores in more than 1 challanges
Condition2: order o/p by no of challanges where full score achieved desc, hackerId asc



--Code:

SELECT
h.hacker_id,
h.name

FROM hackers h
left join submissions s
    ON h.hacker_id = s.hacker_id
left join challenges c
    ON c.challenge_id=s.challenge_id
left join difficulty d
    ON c.difficulty_level=d.difficulty_level

Where s.score=d.score
group by 1,2
having count(c.challenge_id)>1
order by count(c.challenge_id) desc, 1
