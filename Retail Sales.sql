--SQL retail sales Analysis p1
create database SQL_Project_P1

--create table
create table retail_sales
    (
	 transactions_id int,	
	 sale_date date,
	 sale_time	time,
	 customer_id int,
	 gender	varchar(15),
	 age	int,
	 category varchar(15),
	 quantiy int,	
	 price_per_unit	float,
	 cogs	float,
	 total_sale float,

	)

--to select 10 raws
select * from retail_sales
limit 10

--to see no of raws
select 
   count(*)
   from retail_sales
   
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

  --data exploration
  --How many sales he have?
  select count (*) as total_sale 
  from retail_sales  --1987
  
  --How many unique costomers do we have
  select count(distinct customer_id)
  as total_sales from retail_sales --155
  
  --How many catogery do we have?
  select count(distinct category)
  as total_sales from retail_sales --3
  
  select distinct category
  as total_sales from retail_sales 
 --"Electronics" "Clothing" "Beauty"
   
--business problems
--1)Retrive all columns for sales made on 2022-11-05
select * from retail_sales where sale_date ='2022-11-05'  --11

--Retrivee all transactions where the category is 'clothing'and uantity is more then 4 in the month of Nov 2022
select 
  *
from retail_sales 
where category ='Clothing' 
   and 
   To_char(sale_date, 'yyyy-mm')= '2022-11'
   and
   quantiy >= 4   --17

--Total sales for each category
select 
  category ,
  sum(total_sale) as net_sale     
  from retail_sales             
  group by 1                      

--Total sales for each category along with total order
select 
  category ,
  sum(total_sale) as net_sale,
  count(*) as total_ordrs
  from retail_sales   
  group by 1     

--Find the average age of customers who purchased items from the 'Beaury' category
select 
    round(avg(age), 2) as avg_age
	from retail_sales
	where category ='Beauty'  --40.42
	
--Find all transaction where total_sale is greater then 1000
select * from retail_sales
where total_sale >1000        --306

--Find total no of transaction made by each gender to each category 
select 
     category,
	 gender,
	 count(*) as total_trans
	 from retail_sales
	 group by category,
	          gender
	 order by 1

--Calculate avg sale for each month, find best selling month in each year
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

--find top 5 customers on the highest total sales
select 
customer_id,
sum(total_sale) as tota_sales
from retail_sales
group by 1
order by 2 desc
limit 5

--Find no of uniquw customer who purched items from each category
--show all customers
select 
   category,
   count(customer_id)
from retail_sales
group by category

--show unique customers
select 
   category,
   count(distinct customer_id)
from retail_sales
group by category

--create each shift and number of order (exmorning <=12, afternoon between 12& 17, evening >17)
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

select extract(hour from current_time)

--End of Project
   
   
   
   
   
   
   