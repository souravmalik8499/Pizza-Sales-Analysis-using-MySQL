# 🍕 Pizza Sales Analysis using MySQL

## 📌 Project Overview

This project analyzes pizza sales data using MySQL to understand sales performance, revenue generation, customer ordering patterns, pizza categories, sizes, and top-performing pizza types.

The project demonstrates practical SQL skills including:

- SQL Joins
- Aggregate Functions
- GROUP BY
- ORDER BY
- WHERE
- Subqueries
- Window Functions
- RANK()
- Date and Time Functions
- Revenue Analysis
- Data Aggregation

---

## 🎯 Project Objectives

The main objectives of this project are:

1. Calculate total number of orders.
2. Calculate total revenue generated from pizza sales.
3. Identify the highest-priced pizza.
4. Identify the most commonly ordered pizza size.
5. Find the top 5 most ordered pizza types.
6. Analyze pizza category-wise sales.
7. Calculate the percentage contribution of each category to total revenue.
8. Analyze orders by hour of the day.
9. Calculate cumulative revenue over time.
10. Identify the top 3 pizza types by revenue within each category.

---

## 🗂️ Dataset

The project uses four main tables:

### Orders

Contains information about customer orders.

| Column | Description |
|---|---|
| order_id | Unique order identifier |
| order_date | Date of the order |
| order_time | Time of the order |

### Order Details

Contains individual pizza items included in each order.

| Column | Description |
|---|---|
| order_details_id | Unique order detail identifier |
| order_id | Order identifier |
| pizza_id | Pizza identifier |
| quantity | Quantity ordered |

### Pizzas

Contains pizza pricing and size information.

| Column | Description |
|---|---|
| pizza_id | Unique pizza identifier |
| pizza_type_id | Pizza type identifier |
| size | Pizza size |
| price | Pizza price |

### Pizza Types

Contains pizza names and categories.

| Column | Description |
|---|---|
| pizza_type_id | Unique pizza type identifier |
| name | Pizza name |
| category | Pizza category |
| ingredients | Pizza ingredients |

---

## 🔗 Table Relationships

The tables are connected using the following relationships:

```text
orders
   │
   │ order_id
   ▼
orders_details
   │
   │ pizza_id
   ▼
pizzas
   │
   │ pizza_type_id
   ▼
pizza_types
