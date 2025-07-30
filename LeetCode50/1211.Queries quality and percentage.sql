--1211.Queries quality and percentage

--Tables:
1. Queries: query_name, result, position, rating

--output: query_name, quality, poor_query_percentage

--Conditions:
1. quality= avg(ratio between query rating and its position)
2. poor_query_percentage= percentage of all queries with rating <3
3. round quality and poor_query_percentage to 2 decimal places

--CODE:

SELECT
    query_name,
    round(avg(rating/position),2) as quality,
    round(avg(rating<3)*100,2) as poor_query_percentage
FROM queries
group by 1