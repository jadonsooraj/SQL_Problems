--Symmetric pairs

--Table: X, Y

--conditions:
1. write query to find all symmetric pairs, ie X1 = Y2 and X2 = Y1.
2. order by X
3. list the rows such that: X1<=Y1

--Output: X,Y

--Code:
with cte as
(   select
        x,
        y,
        row_number() over (order by x,y) as r
    from functions
)
select 
    distinct x, 
    y
from
    (select 
        case
            when t1.x <= t1.y then t1.x
            else t2.x
        end x,
        case
            when t1.x <= t1.y then t1.y
            else t2.y
        end y
    from 
        cte as t1
        inner join
        cte as t2
order by x;
        on t1.x = t2.y and t2.x = t1.y and t1.r != t2.r) as tabl