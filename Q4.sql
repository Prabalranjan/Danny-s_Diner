use dannys_diner;
show tables;
select * from sales;
select * from menu;
select * from members;

-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?

with number_sold as
(
select m.product_name, count(s.product_id) as number_of_sale
from sales s
inner join menu m
on s.product_id = m.product_id
group by m.product_name
)
select  product_name, number_of_sale
from number_sold
group by product_name
order by number_of_sale desc
limit 1;

-- how many times it was purchase by all the customers
select product_id from menu
where product_name = "ramen";

select customer_id, count(product_id)
from sales 
where product_id = 3
group by customer_id;




-- select count(product_id)
-- from sales
-- where product_id = 3;