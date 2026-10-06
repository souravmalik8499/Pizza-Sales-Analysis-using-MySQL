create database pizzahut;
use  pizzahut;
create table orders(
order_id int not null,
order_date date not null,
order_time time not null,
primary key(order_id)
);

create table orders_details(
order_details_id int not null,
order_id int not null,
pizza_id text not null,
quantity int not null,
primary key(order_details_id)
);



-- Retrieve the total number of orders placed.

select count(order_id) as total_orders from orders;

-- Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(orders_details.quantity * pizzas.price),
            2) AS total_sales
FROM
    orders_details
        JOIN
    pizzas ON pizzas.pizza_id = orders_details.pizza_id;

-- Identify the highest-priced pizza. 

SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;


-- Identify the most common pizza size ordered.


SELECT 
    pizzas.size,
    COUNT(order_details.order_details_id) AS order_count
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC;

-- List the top 5 most ordered pizza types along with their quantities.

SELECT 
    pizza_types.name,
    SUM(orders_details.quantity) AS quantity
FROM pizza_types
JOIN pizzas 
    ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN orders_details 
    ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC
LIMIT 5;

-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    pizza_types.category,
    SUM(orders_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC;


-- Determine the distribution of orders by hour of the day.

select hour(order_time) as hour, count(order_id) as order_count from orders
group by hour(order_time);


-- Join relevant tables to find the category-wise distribution of pizzas.
SELECT 
    category, COUNT(name)
FROM
    pizza_types
GROUP BY category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
-- (select orders.order_date,sum(orders_details.quantity)
-- from orders join orders_details
-- on orders.order_id = orders_details.order_id
-- group by orders.order_date) as order_quantity;


-- Determine the top 3 most ordered pizza types based on revenue.

select pizza_types.name,
sum(orders_details.quantity*pizzas.price) as revenue
from pizza_types join pizzas
on pizzas.pizza_type_id = pizza_types.pizza_type_id
join orders_details
on  orders_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by revenue desc limit 3;



-- Calculate the percentage contribution of each pizza type to total revenue.

SELECT 
    pizza_types.category,
    ROUND(
        SUM(orders_details.quantity * pizzas.price) /
        (
            SELECT SUM(orders_details.quantity * pizzas.price)
            FROM orders_details
            JOIN pizzas 
                ON pizzas.pizza_id = orders_details.pizza_id
        ) * 100,
        2
    ) AS revenue
FROM pizza_types
JOIN pizzas 
    ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN orders_details
    ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY revenue DESC;



-- Analyze the cumulative revenue generated over time.
SELECT 
    order_date,
    SUM(revenue) OVER (ORDER BY order_date) AS cum_revenue
FROM (
    SELECT 
        orders.order_date,
        SUM(orders_details.quantity * pizzas.price) AS revenue
    FROM orders_details
    JOIN pizzas
        ON orders_details.pizza_id = pizzas.pizza_id
    JOIN orders
        ON orders.order_id = orders_details.order_id
    GROUP BY orders.order_date
) AS sales;



-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
select name,revenue from
(SELECT 
    category,
    name,
    revenue,
    RANK() OVER (
        PARTITION BY category 
        ORDER BY revenue DESC
    ) AS rn
FROM (
    SELECT 
        pizza_types.category,
        pizza_types.name,
        SUM(orders_details.quantity * pizzas.price) AS revenue
    FROM pizza_types
    JOIN pizzas
        ON pizza_types.pizza_type_id = pizzas.pizza_type_id
    JOIN orders_details
        ON orders_details.pizza_id = pizzas.pizza_id
    GROUP BY 
        pizza_types.category,
        pizza_types.name
) AS a) as b where rn <= 3;




























    
