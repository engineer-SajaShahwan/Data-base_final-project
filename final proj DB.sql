

 -- Student Name: Saja Mahmoud Shahwan
-- ID Number: 2320224407
-- Eng Name : Abdallah fawzi

-- =================Task1&2==================
-- Create Database
create database ecommerce_2;
use ecommerce_2;

--  Create Categories Table
create table Categories(
cat_id int primary key auto_increment,
cat_name varchar(150) not null

);

-- Insert Data into Categories
insert into Categories (cat_name)  values 
('Clothing'),
 ('Books'), 
 ('Electronics'),
  ('Health and Beauty'),
 ('Sports');


-- .Create Products Table
create table Products(
pro_id int primary key auto_increment,
pro_name varchar (150)  not null,
price decimal(10,2) not null check (price>0),
cat_id int,
foreign key(cat_id) references Categories (cat_id) on delete cascade on update cascade

);

--  Insert Data into Products

insert into Products (pro_name, price, cat_id) values 
('T-shirt', 20.00, 1), 
('Jeans', 50.00, 1), 
('Novel', 15.00, 2), 
('Children Book', 10.00, 2),
('Smartphone', 300.00, 3),  
('Laptop', 800.00, 3),      
('Lipstick', 25.00, 4), 
('Vitamins', 20.00, 4),
('Yoga Mat', 40.00, 5);

--  Create Customers Table
create table Customers (
cust_id int primary key auto_increment,
first_name varchar(100) NOT NULL,
last_name varchar(100) not null ,
city varchar(100)default 'Gaza',
email varchar(150) not null  unique
);


-- Insert Data into Customers
insert into  Customers (first_name, last_name, email, city) values 
('Saja', 'Mahmoud', 'Saja@example.com', 'Gaza'),
('Sara', 'Ahmad', 'sara@example.com', 'Ramallah'),
('Abdallah', 'fawzi', 'Abdallah@example.com', 'Gaza'),
('Lina', 'Samir', 'lina@example.com', 'Nablus'),
('Mohammed', 'Said', 'Mohammed@example.com', 'Hebron');
--  Create Orders Table

create table Orders(
order_id int primary key auto_increment,
order_date date not null,
cust_id int,
foreign key(cust_id) references Customers(cust_id)

);
-- Insert Data into Orders
insert into Orders (order_date, cust_id) values 
('2025-01-01', 1), 
('2025-01-02', 2),
('2025-01-03', 3),
('2025-01-04', 4),
('2024-01-5', 5);  


-- Create Order_Items Table
create table Order_items(
order_id int,
pro_id int,
quantity int not null,
unit_price decimal(10,2) not null,
primary key(order_id,pro_id),
foreign key (order_id) references Orders(order_id) on delete cascade on update cascade,
foreign key (pro_id) references Products(pro_id) on delete cascade on update cascade
);
-- Alter Products Table to Add Discount
alter  table Products add column discount decimal (10,2) default 0;


--  Insert Data into Order_Items
insert into Order_items (order_id, pro_id, quantity, unit_price) values
(1, 1, 4, 20.00),  
(1, 3, 3, 15.00),  
(3, 2, 2, 100.00),  
(2, 5, 12, 300.00), 
(3, 4, 18, 25.00);

 -- Select All Data from Tables
select * from Categories;
select* from Products;
select*from Customers;
select*from Orders;
select*from Order_items;

-- Update Product Prices
update Products set price = price * 1.10 where cat_id = 2;
update Products set price = price * 0.80 where price > 150 and cat_id = 3; 

-- . Delete Orders Before a Specific Date
delete from Orders  where order_date<09-12-2024;
delete from  Orders Where order_date < '2024-01-09';
 -- Delete a Specific Category 
delete from  Categories where cat_name = 'Sports';



-- ======================Task3==============================
-- Select Full Name from Customers
select concat_WS(' ', first_name, last_name) as full_name from Customers;
-- Select Products Starting with 'S'
select * from Products where pro_name like 'S%';
 -- Select Products Starting with 'A' or Price Greater than 100 or شرط واحد لازم يتحقق 
select * from Products where pro_name like  'A%' OR price > 100;
--  Select Customer Names in Upper Case
select upper(CONCAT_WS(' ', first_name, last_name)) AS customer_name from Customers;
--  Order Products by Price Descending
select * from Products order by price DESC;




-- =====================task4==========================

-- Count Total Orders
select count(*) as total_orders from Orders;
-- Average Product Price
select avg(price) as average_price from Products;
-- Max and Min Product Prices
select max(price)  as maximum_price, min(price) AS minmum_price from Products;
-- Count Products in Each Category
select cat_id, count(*) as number_of_products from Products group by cat_id;
-- Total Quantity from Order_Items
select pro_id, sum(quantity) as total_quantity from Order_Items group by pro_id;
-- ============task5=========================
-- Total Price for Each Category
SELECT cat_id, sum(price) as total_price from Products group by cat_id;
-- Products Ordered More than 10 Times
select pro_id from Order_Items group by pro_id having sum(quantity) > 10;

-- Inner Join to Show Customer Names with Order IDs
select Customers.first_name, Customers.last_name, Orders.order_id
from Customers inner join Orders on Customers.cust_id = Orders.cust_id;

--  Left Join to Show All Customers with Orders
select Customers.first_name, Customers.last_name, Orders.order_id  
from Customers left join Orders on Customers.cust_id = Orders.cust_id;

--  Right Join to Show Categories and Products
select Categories.cat_name, Products.pro_name from Categories right join Products on Categories.cat_id = Products.cat_id; 
-- Inner Join to Show Customer Names and Product Categories
select  Customers.first_name, Customers.last_name, Categories.cat_name 
FROM Customers 
inner join orders on Customers.cust_id = Orders.cust_id
inner join Order_items on Orders.order_id  = Order_Items.order_id
inner join Products on Order_items.pro_id = Products.pro_id
inner join Categories on Products.cat_id = Categories.cat_id;

--  Union to Combine Product and Category Names
select pro_name as item_name from  Products union all select cat_name as item_name from Categories;




