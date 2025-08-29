## lets get FY   

-- 1 april 2025

# normally extract a year 

SELECT YEAR("2025-04-1");

# add 4 - only for atliq

SELECT YEAR(date_add("2025-09-1" ,
 INterval 4 month));
 
 
# 1 quarter == 3 months 

-- 1 , 2 , 3  --- Q1
-- 4 , 5 , 6  --- Q2
-- 7 , 8 , 9  --- Q3
-- 10 , 11 ,12  --- Q4

SELECT MONTH(date_add("2025-09-1" ,
 INterval 4 month));

SELECT QUARTER("2025-09-1");

## top 10 customers by sales  

SELECt  * 
from fact_sales_monthly
group by customer_code
order by sold_quantity DESC
LIMIT 10 ;

## top 10 products by sales

SELECt  * 
from fact_sales_monthly
group by product_code
order by sold_quantity DESC
LIMIT 10;

# -------------------------------------------------------------------------------------------
#                                   FLOW OF QUERYING
#                                                                                  
#            SELECT -> FROM -> WHERE -> GROUP BY -> HAVING -> ORDER BY                                                                         
#                                                                                       
# -------------------------------------------------------------------------------------------

## top 10 customers for Fy 2021

SELECt  * 
from fact_sales_monthly
WHERE YEAR(date_add(date ,
INterval 4 month)) = 2021
group by customer_code
order by sold_quantity DESC
LIMIT 10 ;

## top 10 products for Fy 2021
SELECt  * 
from fact_sales_monthly
WHERE YEAR(date_add(date ,
INterval 4 month)) = 2021
group by product_code
order by sold_quantity DESC
LIMIT 10 ;

## sales by croma / amazon for Fy 2021 and Q2

# find the code for croma 

SELECT * from dim_customer
where customer like "%croma%";

SELECT * from fact_sales_monthly
where customer_code = "90002002";

SELECT * from fact_sales_monthly
where customer_code = "90002002"
and YEAR(date_add(date ,
INterval 4 month)) = 2021 
and quarter(date) = 2
order by sold_quantity DESC;



SELECT * 
from fact_sales_monthly
where customer_code = 
(
SELECT customer_code
from dim_customer
where customer 
like "%croma%"
)
and YEAR(date_add(date ,
INterval 4 month)) = 2021 
and quarter(date) = 2
order by sold_quantity 
DESC;



## add FY , Quarter to out sales table
# calculated columns

# show all sales for fy 2021
SELECT 
* , 
YEAR(date_add(date ,
INterval 4 month)) as fy ,
quarter(date) as quarters
from fact_sales_monthly;




with any_table as 
(
SELECT 
* , 
YEAR(date_add(date ,
INterval 4 month)) as fy ,
quarter(date) as quarters
from fact_sales_monthly
)

SELECT * from any_table
where fy = 2021;


# cte - common table expressions
with fy_table as 
(
SELECT 
* , 
YEAR(date_add(date ,
INterval 4 month)) as fy ,
quarter(date) as quarter
from fact_sales_monthly
)
SELECT * from fy_table
where fy = 2018;


