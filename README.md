# Retail-Sales
# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `p1_retail_db`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;
```
```sql   
  --data cleaning
 
 select * from retail_sales
 where transactions_id is null or
		sale_date is null or
		sale_time is null or
		customer_id is null or
		gender is null or
		age is null or
		category is null or
		quantiy is null or
		price_per_unit is null or
		cogs is null or
		total_sale is null
```
		
```sql
delete from retail_sales
 where transactions_id is null or
		sale_date is null or
		sale_time is null or
		customer_id is null or
		gender is null or	
		age is null or
		category is null or
		quantiy is null or
		price_per_unit is null or
		cogs is null or
		total_sale is null
```
### Know the data
  **How many sales do we have?**
```sql
  select count (*) as total_sale 
  from retail_sales  --1987
```
  
  **How many unique customers do we have**
```sql
  select count(distinct customer_id)
  as total_sales from retail_sales --155
```
  
  **How many categories do we have?**
```sql
  select count(distinct category)
  as total_sales from retail_sales --3
```
  *How many unique categories do we have?*
```sql
  select distinct category
  as total_sales from retail_sales 
 --"Electronics" "Clothing" "Beauty"
```
   
### business problems
**Retrive all columns for sales made on 2022-11-05**
```sql
select * from retail_sales where sale_date ='2022-11-05'  --11
```

**Retrieve all transactions where the category is 'clothing'and uantity is more then 4 in Nov 2022**
```sql
select 
  *
from retail_sales 
where category ='Clothing' 
   and 
   To_char(sale_date, 'yyyy-mm')= '2022-11'
   and
   quantiy >= 4   --17
```

**Total sales for each category**
```sql
select 
  category ,
  sum(total_sale) as net_sale     
  from retail_sales             
  group by 1
```                    

**Total sales for each category along with total orders**
```sql
select 
  category ,
  sum(total_sale) as net_sale,
  count(*) as total_ordrs
  from retail_sales   
  group by 1
```     

**Find the average age of customers who purchased items from the 'Beaury' category**
```sql
select 
    round(avg(age), 2) as avg_age
	from retail_sales
	where category ='Beauty'  --40.42
	
--Find all transaction where total_sale is greater then 1000
select * from retail_sales
where total_sale >1000        --306
```

**Find total no of transaction made by each gender to each category**
```sql
select 
     category,
	 gender,
	 count(*) as total_trans
	 from retail_sales
	 group by category,
	          gender
	 order by 1
```

**Calculate avg sale for each month, find best selling month in each year**
```sql
--this will show rank of month 
select * from 
(
	select 
		extract(year from sale_date) as year,
		extract(month from sale_date) as year,
		sum(total_sale) as avg_sale,
		rank() over( partition by extract(year from sale_date) 
					order by avg(total_sale)desc) as rank
	from retail_sales
	group by 1,2
) as t1
where rank = 1
```
```sql
--this will show avg of month 
select 
     year,
	 month,
	avg_sale
from 
(
	select 
		extract(Year from sale_date) as year,
		extract(Month from sale_date) as year,
		sum(total_sale) as avg_sale,
		rank() over( partition by extract(Year from sale_date) 
					order by avg(total_sale)desc) as rank
	from retail_sales
	group by 1,2
) as t1
where rank = 1   --getting column reference "year" is ambiguous at line 2
```

**Find top 5 customers on the highest total sales**
```sql
select 
customer_id,
sum(total_sale) as tota_sales
from retail_sales
group by 1
order by 2 desc
limit 5
```

**Find the number of unique customers who purchased items from each category**
```sql
--show all customers
select 
   category,
   count(customer_id)
from retail_sales
group by category
```
```sql
--show unique customers
select 
   category,
   count(distinct customer_id)
from retail_sales
group by category
```

**create each shift and number of order (exmorning <=12, afternoon between 12& 17, evening >17)**
```sql
 with hourly_sale
 as
 (
select *,
    case
	    when extract(hour from sale_time) <12 then 'Morning'
		when extract(hour from sale_time) between 12 and 17 then 'Aftermoon'
		else 'Evening'
	end as shift
from retail_sales
 )
 select 
 shift,
 count(*) as total_order
 from hourly_sale
 group by shift
```

## *Author - Bhagyashri Zade*

This project is part of my SQL practice, showcasing the SQL skills essential for data analyst roles. If you have any questions or feedback or would like to collaborate, feel free to get in touch!

For more content on SQL, data analysis, and other updates, make sure to follow me on social media:

- **LinkedIn**: [Connect with me professionally](https://www.linkedin.com/in/najirr)

Thank you for visiting, and I look forward to connecting with you!
