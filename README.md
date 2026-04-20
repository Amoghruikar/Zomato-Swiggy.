# Zomato-Swiggy.
 This assignment will involve creating an application  that deals with the delivery service, similar to the likes of Zomato and Swiggy  using SQL and relational database. The primary aim of this assignment was to  develop a structured database that will allow managing of customers, restaurants,  orders and order items effectively, while also facilitating analysis of this data. 
For that purpose, I designed four tables in total, namely: Customers, Restaurants, 
Orders, Order_Items. Customers table holds details about the users such as id, 
name, and the city they belong to. Restaurants table contains the data about 
restaurants themselves. Orders table is a junction table that connects customers 
and restaurants, it also holds such attributes as order ID, customer ID, restaurant 
ID, order date, and amount. Order_Items table contains items contained within 
every order. 
The database schema uses one-to-many relationships: one customer has many 
orders, one order has many items. I also used such SQL operations as querying 
the database to retrieve and filter data, joining data from several tables, and 
aggregate functions including SUM, COUNT, and AVG, to calculate metrics such 
as spending per person and top restaurants.  
I also employed subqueries, CTEs, and window functions to perform more 
advanced analysis such as ranking customers or computing cumulative sums. 
Overall, this assignment was beneficial for comprehending database schema 
design, efficient querying techniques, and using SQL to tackle practical business 
challenges.
