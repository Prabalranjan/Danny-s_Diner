use dannys_diner;
show tables;
select * from sales;
select * from menu;
select * from members;

select join_date + interval 7 day AS NEXT_WEEK
from members ;
-- where customer_id = 'A';

-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, 
-- not just sushi - how many points do customer A and B have at the end of January? 

with first_week as
(
select s.customer_id, s.order_date,s.product_id,mu.product_name,mu.price, mem.join_date
from sales s
inner join 
menu mu on s.product_id = mu.product_id
inner join
members mem on s.customer_id = mem.customer_id
order by s.customer_id
)
select customer_id, 
-- price, order_date,
sum(case
	when order_date between (select join_date from members where customer_id = 'A') 
					   and (select join_date + interval 6 day from members where customer_id = 'A')
	then (price * (2*price)) 
    -- else price*price
--  as "total point",

-- case    
    when order_date between (select join_date from members where customer_id = 'B') 
					   and (select join_date+ interval 6 day from members where customer_id = 'B')
	then (price * (2*price))
    else price*price
end) as "total point"
from first_week
-- group by customer_id
where month(order_date) = 1
group by customer_id
order by customer_id;







-- screen shot purpose
with first_week as(
select s.customer_id, s.order_date,s.product_id,mu.product_name,mu.price, mem.join_date
from sales s
inner join menu mu on s.product_id = mu.product_id
inner join members mem on s.customer_id = mem.customer_id
order by s.customer_id
)
select customer_id, 
sum(case
	when order_date between (select join_date from members where customer_id = 'A') 
					   and (select join_date + interval 6 day from members where customer_id = 'A')
	then (price * (2*price)) 
    when order_date between (select join_date from members where customer_id = 'B') 
					   and (select join_date+ interval 6 day from members where customer_id = 'B')
	then (price * (2*price))
    else price*price
end) as "total point"
from first_week
where month(order_date) = 1
group by customer_id
order by customer_id; 