--1174.Immediate Food Delivery 2

--tables:
1. Delivery: delivery_id, customer_id, order_date, customer_pref_delivery_date

--Conditions:
1. If customer_pref_delivery_date = order_date the immediate, else scheduled
2. the first order of the customer is the earliest order date
3. Find percentage of immediate orders in the in the first order of all customers, round it to 2 decimal 

--OUTPUT: immediate_percentage

--CODE:

with first_order as (
    SELECT
        customer_id,
        min(order_date) as first_order_date
    FROM delivery
    group by 1
)

SELECT sum(if(order_date=customer_pref_delivery_date,1,0))
FROM delivery