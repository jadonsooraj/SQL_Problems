--550. Game Play Analysis 4

--tables:
1. activity: player_id, device_id, event_date, games_played

--Conditions
1. Write a SQL query to to report fraction of players that logged in again on the day after the day they first logged in
2. In other words, you need to determine the number of players who logged in on the day immediately following their initial login, 
	and divide it by the number of total players.
3. round it to 2 decimal

--output: fraction

--CODE:

WITH first_login AS (
    SELECT 
        player_id,
        MIN(event_date) AS first_date
    FROM activity
    GROUP BY player_id
),
next_day_login AS (
    SELECT DISTINCT
        f.player_id
    FROM first_login f
    INNER JOIN activity a 
        ON f.player_id = a.player_id 
        AND a.event_date = f.first_date + INTERVAL 1 DAY
)
SELECT 
    ROUND(
        COUNT(n.player_id) / COUNT(f.player_id), 
        2
    ) AS fraction
FROM first_login f
LEFT JOIN next_day_login n ON f.player_id = n.player_id;