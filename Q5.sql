use dannys_diner;
show tables;
select * from sales;
select * from menu;
select * from members;

-- 5. Which item was the most popular for each customer?

with popular as
(
select s.customer_id, s.product_id, m.product_name,
dense_rank() over(partition by customer_id  order by product_id) as number_of_times
from sales s
inner join 
menu m
on 
s.product_id = m.product_id
)
select customer_id ,product_name, count(number_of_times) as no_of_times
from popular
-- where customer_id = "C"
group by customer_id,product_name
order by customer_id,no_of_times desc;