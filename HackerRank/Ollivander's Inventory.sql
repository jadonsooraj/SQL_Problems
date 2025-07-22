Ollivander's Inventory

--tables:
1. Wands: id, code, coins_needed, power
2. wands_property: code, age, is_evil


--Output: id, age, coins_needed, power

--conditions:
1. Minimum number of gaellons(coins_needed) to buy each non-evil wand of high power and age.
2. Sorted in order of descending power. If more than one wand has same power, sort the result in order of descending age.

Code:

with high_power_wands as (
SELECT 
    id,
    code,
    power,
    coins_needed,
    ROW_NUMBER() over(partition by code,power order by coins_needed) as rnk
FROM wands
)

SELECT
    a.id,
    b.age,
    a.coins_needed,
    a.power
FROM high_power_wands a
LEFT JOIN wands_property b
    ON a.code=b.code
WHERE is_evil=0 and rnk=1
order by 4 desc, 2 desc

