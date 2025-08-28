-- lets explore sales

SELECT * FROM fact_sales_monthly limit 10;

-- lets explore different products ---------------

SELECT * FROM dim_product;

-- lets explore all unique columns from products

select distinct division from dim_product;

select distinct segment from dim_product;

select distinct category from dim_product;

select distinct product from dim_product;

select distinct variant from dim_product;

select product from dim_product
where variant like "%Standard 3%";


select * from dim_product
where category like "%Mouse%";


-- lets explore different customers------------

SELECT * FROM gdb0041.dim_customer;


-- lets explore all unique columns from customers

SELECT distinct customer FROM dim_customer;

SELECT distinct platform FROM dim_customer;

SELECT distinct channel FROM dim_customer;

SELECT distinct market FROM dim_customer;

SELECT distinct sub_zone FROM dim_customer;

SELECT distinct region FROM dim_customer;

select * from dim_customer
where platform = 'E-Commerce';

select * from dim_customer
where customer = 'Amazon';

select * from dim_customer
where channel = 'direct';

-- lets say i want to find out the sales of croma or flipcart or amazon customers---

select * from fact_sales_monthly;

SELECT customer_code FROM 
gdb0041.dim_customer
where customer like '%amazon%';

select * from 
fact_sales_monthly fa
join dim_customer dc
using (customer_code)
where customer like '%amazon%'
order by sold_quantity DESC
LIMIT 100;

-- Lets retrieve all the sales in Fiscal year = 2021

Select * from fact_sales_monthly;

# we remember fy of atliq is sept(09)  - august (08)
# we realise they are 4 months ahead of us 
# if our new year start in jan - aliqs new year is in sept 
# so 4 months

-- lets see how do we add 4 months to our date

SELECT DATE_ADD('2025-9-22' , INTERVAL 4 MONTH);

# lets get the fiscal year

SELECT YEAR(DATE_ADD('2025-9-22' ,
 INTERVAL 4 MONTH)) as fy;


-- now Lets retrieve all the sales in Fiscal year = 2021 

SELECT * from fact_sales_monthly 
where YEAR(DATE_ADD(date , 
INTERVAL 4 MONTH)) = 2021;

SELECT 
* 
from fact_sales_monthly 
where 
(SELECT YEAR(DATE_ADD(date ,
 INTERVAL 4 MONTH))) = 2021;

-- now Lets retrieve all the sales to amazon in Fiscal year = 2021 

SELECT * from fact_sales_monthly 
where
customer_code =  '90002008'
and 
YEAR(DATE_ADD(date , INTERVAL 4 MONTH)) = 2021;

-- lets get quarter of the fy now 

-- given date as input eg : 2025 - 09 - 01  --> FY 2026 , Q1

# so we got month as 1 but not Q1
SELECT 
MONTH(DATE_ADD('2025-9-22' , 
INTERVAL 4 MONTH)) as fy;

SELECT 
CASE
	when MONTH(DATE_ADD('2025-9-22' , INTERVAL 4 MONTH)) in (1 , 2 ,3) then 'Q1'
    when MONTH(DATE_ADD('2025-9-22' , INTERVAL 4 MONTH)) in (4 , 5 ,6) then 'Q2'
    when MONTH(DATE_ADD('2025-9-22' , INTERVAL 4 MONTH)) in (7 , 8 ,9) then 'Q3'
    when MONTH(DATE_ADD('2025-9-22' , INTERVAL 4 MONTH)) in (10 , 11 ,12) then 'Q4'
END 
 as fy;

-- lets get for all the dates

SELECT date,
CASE
	when MONTH(DATE_ADD( date , INTERVAL 4 MONTH)) in (1 , 2 ,3) then 'Q1'
    when MONTH(DATE_ADD( date , INTERVAL 4 MONTH)) in (4 , 5 ,6) then 'Q2'
    when MONTH(DATE_ADD( date , INTERVAL 4 MONTH)) in (7 , 8 ,9) then 'Q3'
    when MONTH(DATE_ADD( date , INTERVAL 4 MONTH)) in (10 , 11 ,12) then 'Q4'
END 
as quater from
fact_sales_monthly;

-- lets see distinct quarters

SELECT distinct
CASE
	when MONTH(DATE_ADD( date , INTERVAL 4 MONTH)) in (1 , 2 ,3) then 'Q1'
    when MONTH(DATE_ADD( date , INTERVAL 4 MONTH)) in (4 , 5 ,6) then 'Q2'
    when MONTH(DATE_ADD( date , INTERVAL 4 MONTH)) in (7 , 8 ,9) then 'Q3'
    when MONTH(DATE_ADD( date , INTERVAL 4 MONTH)) in (10 , 11 ,12) then 'Q4'
END 
as quater from
fact_sales_monthly;


-- lets get  the fiscal year and quarter for all the dates

SELECT * ,
YEAR(DATE_ADD(date , INTERVAL 4 MONTH)) as fiscal_year,
CASE
	when MONTH(DATE_ADD( date , INTERVAL 4 MONTH)) in (1 , 2 ,3) then 'Q1'
    when MONTH(DATE_ADD( date , INTERVAL 4 MONTH)) in (4 , 5 ,6) then 'Q2'
    when MONTH(DATE_ADD( date , INTERVAL 4 MONTH)) in (7 , 8 ,9) then 'Q3'
    when MONTH(DATE_ADD( date , INTERVAL 4 MONTH)) in (10 , 11 ,12) then 'Q4'
END 
as quater from
fact_sales_monthly
LIMIT 10;

-- lets get the same for amazon after FY 2021

SELECT * ,
YEAR(DATE_ADD(date , INTERVAL 4 MONTH)) as fiscal_year,
CASE
	when MONTH(DATE_ADD( date , INTERVAL 4 MONTH)) in (1 , 2 ,3) then 'Q1'
    when MONTH(DATE_ADD( date , INTERVAL 4 MONTH)) in (4 , 5 ,6) then 'Q2'
    when MONTH(DATE_ADD( date , INTERVAL 4 MONTH)) in (7 , 8 ,9) then 'Q3'
    when MONTH(DATE_ADD( date , INTERVAL 4 MONTH)) in (10 , 11 ,12) then 'Q4'
END 
as quater from
fact_sales_monthly
where customer_code = "90002008"
having fiscal_year > 2021
LIMIT 10;


# other way of getting quarters

SELECT * ,
YEAR(DATE_ADD(date , INTERVAL 4 MONTH)) as fiscal_year,
CASE
	when MONTH(DATE_ADD( date , INTERVAL 4 MONTH)) in (1 , 2 ,3) then 'Q1'
    when MONTH(DATE_ADD( date , INTERVAL 4 MONTH)) in (4 , 5 ,6) then 'Q2'
    when MONTH(DATE_ADD( date , INTERVAL 4 MONTH)) in (7 , 8 ,9) then 'Q3'
    when MONTH(DATE_ADD( date , INTERVAL 4 MONTH)) in (10 , 11 ,12) then 'Q4'
END 
as quater from
fact_sales_monthly
where customer_code = "90002008"
having fiscal_year > 2021
LIMIT 10;
