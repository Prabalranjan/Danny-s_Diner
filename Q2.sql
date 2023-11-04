use dannys_diner;
show tables;
select * from sales;
select * from menu;
select * from members;

-- 2.How many days has each customer visited the restaurant?
select customer_id,count(distinct(order_date)) as no_of_days
from sales
group by customer_id;
