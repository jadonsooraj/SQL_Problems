--1251. Average Selling Price 

--tables
1. prices: product_id, start_date, end_date, price
2. unitsSold: product_id, purchase_date, units

--output: product_id, average_price


--Conditions
1. Write query to find average selling price for each product.
2. round(avg selling price,2)

CODE:
 SELECT
    p.product_id,
    coalesce(round(sum(p.price*u.units)/sum(u.units),2),0) as average_price
FROM prices p
LEFT JOIN unitsSold u
    ON p.product_id = u.product_id
        AND u.purchase_date BETWEEN p.start_date and p.end_date
group by 1
