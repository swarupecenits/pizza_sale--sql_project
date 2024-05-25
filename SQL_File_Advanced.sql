-- Data Analysis Project By Swarup Chanda

-- 1.Calculate the percentage contribution of each pizza category type to total revenue.

SELECT 
    pizza_types.category AS category,
    CONCAT(ROUND(((ROUND(SUM(order_details.quantity * pizzas.price),
                            2) / (SELECT 
                            ROUND(SUM(order_details.quantity * pizzas.price),
                                        2) AS total_revenue
                        FROM
                            order_details
                                JOIN
                            pizzas ON order_details.pizza_id = pizzas.pizza_id)) * 100),
                    2),
            '%') AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY category
ORDER BY revenue DESC;


-- 2.Analyze the cumulative revenue generated over time.

select order_date,
sum(revenue) over (order by order_date) as cum_revenue from
(SELECT 
    orders.order_date,
    round(SUM(order_details.quantity*pizzas.price),2) AS revenue
FROM
    pizzas
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
    join orders on orders.order_id=order_details.order_id
GROUP BY order_date) as	sales;



-- 3.Determine the top 3 most ordered pizza types based on revenue for each pizza category.

select category,name,revenue from
(select category, name, revenue,
rank() over (partition by category order by revenue desc ) as pizza_rank from
(select pizza_types.category, pizza_types.name,
 round(SUM(order_details.quantity*pizzas.price),2) AS revenue
 from
  pizza_types join 
  pizzas on 
  pizza_types.pizza_type_id=pizzas.pizza_type_id
  join order_details on order_details.pizza_id=pizzas.pizza_id
  
  group by pizza_types.category, pizza_types.name) as pizza_data)aS sale_data
  where pizza_rank<=3;










