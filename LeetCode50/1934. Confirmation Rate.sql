--1934. Confirmation Rate

--tables:
1. Signups: user_id, time_stamp
2. Confirmations: user_id, time_stamp, action

--Conditions
1. Confirmation rate odf a user is the number of 'confirmed' messages divided by the total number of requested confirmation messages.
2. the confirmation rate of a user who did not request any confirmation message is 0.
3. round confirmation rate to 2 decimal.
4. find confirmation rate for each user

CODE:

SELECT 
    s.user_id,
    COALESCE(ROUND(SUM(IF(c.action = 'confirmed', 1, 0)) / COUNT(c.user_id), 2), 0) as confirmation_rate
FROM signups s
LEFT JOIN confirmations c ON s.user_id = c.user_id
GROUP BY s.user_id;