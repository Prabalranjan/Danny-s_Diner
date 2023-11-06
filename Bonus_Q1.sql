use dannys_diner;
show tables;
select * from sales;
select * from menu;
select * from members;

with bonus as
(
select s.customer_id, s.order_date, m.product_name,m.price
-- mem.join_date
from sales s
inner join 
menu m 
on s.product_id = m.product_id

)
select bonus.customer_id,order_date,product_name,price,
case 
	when order_date < join_date then  "N"
    when order_date >= join_date then "Y"
    -- when join_date is NULL then "N"
    when bonus.customer_id = "C" then "N"
end as member
from bonus
left join 
members mem
on bonus.customer_id = mem.customer_id
order by bonus.customer_id,order_date;