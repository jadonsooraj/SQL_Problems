Challenges

--Output: hacker_id, name, total number of challanges created by each student

Conditions:
1. total number of challanges created desc, hacker_id
2. If more than one student created the same number of challenges and the count is less than the maximum number of challenges created, then exclude those students from the result.

tables: 
1. hackers: hacker_id, name
2. challanges: challanges_id, hacker_id

CODE:

WITH challenges_created AS (
    SELECT
        hacker_id,
        COUNT(challenge_id) AS no_of_challenges
    FROM challenges
    GROUP BY hacker_id
),

-- Find counts that are duplicated and not equal to the max
non_unique_counts AS (
    SELECT no_of_challenges
    FROM challenges_created
    GROUP BY no_of_challenges
    HAVING COUNT(*) > 1 AND no_of_challenges < (SELECT MAX(no_of_challenges) FROM challenges_created)
)

SELECT
    c.hacker_id,
    h.name,
    COUNT(c.challenge_id) AS total_challenges
FROM challenges c
JOIN hackers h
    ON c.hacker_id = h.hacker_id
GROUP BY c.hacker_id, h.name
HAVING COUNT(c.challenge_id) NOT IN (SELECT no_of_challenges FROM non_unique_counts)
ORDER BY total_challenges DESC, c.hacker_id;
