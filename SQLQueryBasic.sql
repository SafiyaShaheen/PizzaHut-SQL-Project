--1.Retrieve the total number of orders placed.
--2.Calculate the total revenue generated from pizza sales.
--3.Identify the highest-priced pizza.
--4.Identify the most common pizza size ordered.
--5.List the top 5 most ordered pizza types along with their quantities.



--1.Retrieve the total number of orders placed
select count(order_id) from orders;


--2.Calculate the total revenue generated from pizza sales.
select round(sum(order_details.quantity * pizzas.price),2)
as total_sales
from 
order_details join pizzas 
on pizzas.pizza_id=order_details.pizza_id;


--3.Identify the highest-priced pizza.
select top 1 pizza_types.name, round(pizzas.price,2)
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
order by pizzas.price desc ;



--4.Identify the most common pizza size ordered.
select top 1 pizzas.size ,count(order_details.order_details_id) as order_count
from pizzas join order_details 
on pizzas.pizza_id=order_details.pizza_id
group by pizzas.size order by  order_count desc;


--5.List the top 5 most ordered pizza types along with their quantities.

select  top 5 pizza_types.name,
sum(order_details.quantity) as quantity
from pizza_types join pizzas 
on pizzas.pizza_type_id=pizza_types.pizza_type_id
join order_details 
on  pizzas.pizza_id=order_details.pizza_id
group by pizza_types.name
order by quantity desc;
