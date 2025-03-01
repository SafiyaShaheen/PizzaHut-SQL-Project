--Join the necessary tables to find the total quantity of each pizza category ordered.
--Determine the distribution of orders by hour of the day.
--Join relevant tables to find the category-wise distribution of pizzas.
--Group the orders by date and calculate the average number of pizzas ordered per day.
--Determine the top 3 most ordered pizza types based on revenue.


--Join the necessary tables to find the total quantity of each pizza category ordered.
select pizza_types.category,sum(order_details.quantity) as quantity
from pizza_types join pizzas 
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_details on pizzas.pizza_id=order_details.pizza_id
group by pizza_types.category
order by quantity desc;

--Determine the distribution of orders by hour of the day.
select DATEPART(hour, time) as t_hour,count(order_id) as order_count
from orders
group by DATEPART(hour,time) order by order_count desc;

--Join relevant tables to find the category-wise distribution of pizzas.
select count(pizza_type_id)as type , category from pizza_types
group by category;



--Group the orders by date and calculate the average number of pizzas ordered per day.
select avg(quantity) as avgorder from 
(select orders.date, sum(order_details.quantity) as quantity 
from orders join order_details 
on orders.order_id=order_details.order_id
group by orders.date) as day_quantity;


--Determine the top 3 most ordered pizza types based on revenue.
select top 3 pizza_types.name ,sum(order_details.quantity*pizzas.price) as revenue
from  pizza_types join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_details on 
order_details.pizza_id=pizzas.pizza_id
group by pizza_types.name
order by revenue desc;