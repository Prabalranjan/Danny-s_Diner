use dannys_diner;
show tables;
select * from sales;
select * from menu;
select * from members;

-- 9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?

with basic_detail as
(
select s.customer_id, s.product_id, m.price, m.product_name
from sales s
inner join
menu m on s.product_id = m.product_id
)
select customer_id, 
-- product_name, price,
sum(case
	when product_name = "sushi" then (price * (2*price))
    -- when product_name = "curry" then price * price
    else price * price
end) as points
from basic_detail
group by customer_id;