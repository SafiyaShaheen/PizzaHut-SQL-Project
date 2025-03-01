--Calculate the percentage contribution of each pizza type to total revenue.
--Analyze the cumulative revenue generated over time.
--Determine the top 3 most ordered pizza types based on revenue for each pizza category.


--Calculate the percentage contribution of each pizza type to total revenue.
select pizza_types.category, 
(Round(sum(order_details.quantity*pizzas.price)/(select 
	round(sum(order_details.quantity*pizzas.price),2) as total_sales 
    from order_details 
    join pizzas on order_details.pizza_id=pizzas.pizza_id)*100,2)) as revenue
From pizza_types join pizzas
on Pizza_types.Pizza_type_id=pizzas.pizza_type_id
join order_details on order_details.pizza_id=pizzas.pizza_id
Group by pizza_types.category
Order by revenue desc;

--Determine the top 3 most ordered pizza types based on revenue for each pizza category.
select date, sum(revenue)over (order by date) as cumulative_revenue from 
(select orders.date, 
sum(order_details.quantity*pizzas.price) as revenue
from pizzas join order_details
on pizzas.pizza_id=order_details.pizza_id
join orders 
on orders.order_id=order_details.order_id
group by orders.date) as sales;

--Determine the top 3 most ordered pizza types based on revenue for each pizza category.
select name, revenue from
(select category, name, revenue ,
rank() over(partition by category order by revenue desc) as rn
from
(select pizza_types.category,pizza_types.name,
sum((order_details.quantity)*pizzas.price) as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_details 
on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.category,pizza_types.name) as a)as b
where rn<=3;
