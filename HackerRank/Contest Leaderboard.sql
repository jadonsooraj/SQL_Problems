Contest Leaderboard

--output: hacker_id, name, total_score_of_hacker(sum of their maximum scores for all of the challanges)

--Conditions:
1. order by scores desc, hacker_id
2. exclude all hacker where score =0

--Tables:
1. hackers: hacker_id, name
2. submissions: submission_id, hacker_id, challenge_id, score

CODE:

WITH max_score_per_challenge AS (
    SELECT 
        hacker_id,
        challenge_id,
        MAX(score) AS max_score
    FROM submissions
    GROUP BY hacker_id, challenge_id
)

SELECT 
    h.hacker_id,
    h.name,
    SUM(m.max_score) AS total_score
FROM max_score_per_challenge m
JOIN hackers h
    ON m.hacker_id = h.hacker_id
GROUP BY h.hacker_id, h.name
HAVING SUM(m.max_score) <> 0
ORDER BY total_score DESC, h.hacker_id;
