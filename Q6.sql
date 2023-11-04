use dannys_diner;
show tables;
select * from sales;
select * from menu;
select * from members;

-- 6. Which item was purchased first by the customer after they became a member?
with pur_after_mem as
(
select s.customer_id,s.order_date,mu.product_id, mu.product_name,
lead(s.product_id) over(partition by customer_id order by s.order_date) as next_id
from sales s
inner join 
members m on s.customer_id = m.customer_id
inner join menu mu
on s.product_id = mu.product_id 
)
(select p.customer_id, p.product_name as purch_product_after_joining 
-- next_id as product_id,mem.join_date,order_date as next_order_date
from pur_after_mem p
inner join members mem
on p.customer_id = mem.customer_id
where p.customer_id = 'A' 
AND
order_date > (select join_date from members where customer_id = 'A')
order by order_date limit 1)
union all
(select p.customer_id, p.product_name as purch_product_after_joining
-- next_id as product_id,mem.join_date,order_date as next_order_date
from pur_after_mem p
inner join members mem
on p.customer_id = mem.customer_id
where p.customer_id = 'B' 
AND
order_date > (select join_date from members where customer_id = 'B')
order by order_date limit 1);







-- for screen shot purpose
with pur_after_mem as(
select s.customer_id,s.order_date,mu.product_id, mu.product_name,
lead(s.product_id) over(partition by customer_id order by s.order_date) as next_id
from sales s
inner join members m on s.customer_id = m.customer_id
inner join menu mu
on s.product_id = mu.product_id 
)
(select p.customer_id, p.product_name as purch_product_after_joining 
from pur_after_mem p
inner join members mem
on p.customer_id = mem.customer_id
where p.customer_id = 'A' 
AND order_date > (select join_date from members where customer_id = 'A')
order by order_date limit 1)
UNION ALL
(select p.customer_id, p.product_name as purch_product_after_joining
from pur_after_mem p
inner join members mem
on p.customer_id = mem.customer_id
where p.customer_id = 'B' 
AND order_date > (select join_date from members where customer_id = 'B')
order by order_date limit 1);
