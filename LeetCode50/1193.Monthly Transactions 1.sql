--1193.Monthly Transactions 1

--Tables:
1. transactions: id, country, state,  amount, trans_date

--Conditions:
1. Write SQL query to find for each month and country, the number of transactions and their total amount, the number of total approved transactions and their amount

--output:month, country, trans_count, approved_count, trans_total_amount, approved_amount

--CODE:
SELECT
    date_format(trans_date,'%Y-%m') as month,
    country,
    count(distinct id) as trans_count,
    sum(state='approved') as approved_count,
    sum(amount) as trans_total_amount,
    sum(if(state='approved',amount,0)) as approved_total_amount
FROM transactions
group by 1,2