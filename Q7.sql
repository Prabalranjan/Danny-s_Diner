use dannys_diner;
show tables;
select * from sales;
select * from menu;
select * from members;

-- 7. Which item was purchased just before the customer became a member?
with proper_date as
(
select s.customer_id,s.order_date,mu.product_id, mu.product_name,
lag(s.product_id) over(partition by customer_id order by s.order_date) as late_id
from sales s
inner join 
members m on s.customer_id = m.customer_id
inner join menu mu
on s.product_id = mu.product_id
) 
(select p.customer_id, p.product_name as last_product_before_joining 
-- mem.join_date
-- late_id as product_id, order_date as last_order_date
from proper_date p
inner join members mem
on p.customer_id = mem.customer_id
where p.customer_id = 'A'and 
(order_date = (select join_date from members where customer_id = 'A') OR
order_date < (select join_date from members where customer_id = 'A'))
order by order_date desc limit 1)
union all
(select p.customer_id, p.product_name as last_product_before_joining
-- mem.join_date
-- late_id as product_id, order_date as last_order_date
from proper_date p
inner join members mem
on p.customer_id = mem.customer_id
where p.customer_id = 'B'and 
(order_date = (select join_date from members where customer_id = 'B') OR
order_date < (select join_date from members where customer_id = 'B'))
order by order_date desc limit 1);


-- or
-- order_date = COALESCE((select MAX(order_date) from members where join_date <= '2021-01-07'),'1900-01-01');


-- where order_date = COALESCE((select MAX(join_date) from members where join_date <= '2021-01-09'),'1900-01-01')
--    OR order_date = COALESCE((select MAX(join_date) from members where join_date <= '2021-01-07'),'1900-01-01');
-- AND (order_date = '2021-01-09' OR order_date = COALESCE((select MAX(join_date) from members where join_date < '2021-01-09'),'1900-01-01'));

   -- or order_date = COALESCE((SELECT MAX(join_date) FROM members WHERE join_date < '2021-01-09'),'1900-01-01');

-- SELECT *
-- FROM your_table
-- WHERE your_date_column = '2023-10-11'
--    OR your_date_column = COALESCE((SELECT MAX(your_date_column) FROM your_table WHERE your_date_column < '2023-10-11'),);





-- for screen shot purpose
with proper_date as(
select s.customer_id,s.order_date,mu.product_id, mu.product_name,
lag(s.product_id) over(partition by customer_id order by s.order_date) as late_id
from sales s
inner join members m on s.customer_id = m.customer_id
inner join menu mu
on s.product_id = mu.product_id) 
(select p.customer_id, p.product_name as last_product_before_joining 
from proper_date p
inner join members mem on p.customer_id = mem.customer_id
where p.customer_id = 'A'and 
(order_date = (select join_date from members where customer_id = 'A') OR
order_date < (select join_date from members where customer_id = 'A'))
order by order_date desc limit 1)
union all
(select p.customer_id, p.product_name as last_product_before_joining
from proper_date p
inner join members mem on p.customer_id = mem.customer_id
where p.customer_id = 'B'and 
(order_date = (select join_date from members where customer_id = 'B') OR
order_date < (select join_date from members where customer_id = 'B'))
order by order_date desc limit 1); 