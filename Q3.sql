use dannys_diner;
show tables;
select * from sales;
select * from menu;
select * from members;

-- 3. What was the first item from the menu purchased by each customer?
with first_order as
(
select s.customer_id, s.product_id, m.product_name,
row_number() over(partition by customer_id) as order_numbering
from sales s
inner join 
menu m
on s.product_id = m.product_id
)
select customer_id, product_name
from first_order
where order_numbering = 1;

 