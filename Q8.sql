use dannys_diner;
show tables;
select * from sales;
select * from menu;
select * from members;

-- 8. What is the total items and amount spent for each member before they became a member? 

with purchase_before as(
select s.customer_id,s.order_date,m.product_id, m.price
from sales s
inner join 
menu m on s.product_id = m.product_id
inner join 
members mem on s.customer_id = mem.customer_id
order by s.customer_id, s.order_date
)
(select p.customer_id, count(product_id) as total_items, sum(price) as total_spent
from purchase_before p
inner join 
members mem on p.customer_id = mem.customer_id
where p.customer_id = 'A' AND order_date < (select join_date from members where customer_id = 'A')
group by customer_id)
union all
(select p.customer_id, count(product_id) as total_items, sum(price) as total_spent
from purchase_before p
inner join 
members mem on p.customer_id = mem.customer_id
where p.customer_id = 'B' AND order_date < (select join_date from members where customer_id = 'B')
group by customer_id)
