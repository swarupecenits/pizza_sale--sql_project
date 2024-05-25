-- Data Analysis Project By Swarup Chanda

-- 1.Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS order_quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY order_quantity DESC;


-- 2.Determine the distribution of orders by hour of the day.

SELECT 
    HOUR(order_time) AS hour, COUNT(order_id) AS order_count
FROM
    orders
GROUP BY hour
ORDER BY hour ASC;



-- 3.Join relevant tables to find the category-wise distribution of pizzas.

SELECT 
    category, COUNT(name) as count
FROM
    pizza_types
GROUP BY category
ORDER BY category ASC;


-- 4.Group the orders by date and calculate the average number of pizzas ordered per day.

select round(avg(quantity),0) as Average_pizzas_ordered_per_day from 
(SELECT 
    orders.order_date,
    SUM(order_details.quantity) AS quantity
FROM
    orders
        JOIN
    order_details ON orders.order_id = order_details.order_id
GROUP BY orders.order_date) as Order_quantity;



-- 5.Determine the top 3 most ordered pizza types based on revenue.

SELECT 
    pizza_types.name AS name,
    SUM(order_details.quantity * pizzas.price) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY name
ORDER BY revenue DESC
LIMIT 3;










