
# lets say my manager has asked me the report with the following requirement / fields 

-- ------------------------------------------------------------------

-- Month	
-- Product name
-- Variant
-- Sold Quantity
-- Gross price per item
-- Gross price total

-- aggregated on monthly basis on product level for FY = 2021 
-- customer name = croma


-- ------------------------------------------------------------------

# lets retrive customer info first 

select * from dim_customer where customer 
like "%croma%" and market = "India";


# lets use the dateaddd function

# 9-2020 -- > 1 2021
# 10-2020 --> 2 2021
	
select date_add("2020-09-01" , interval 4 month);



# lets retrive monthly aggregated for the fiscal year = 2021

select * from fact_sales_monthly
where customer_code = 90002002 
and YEAR(DATE_ADD(date, INTERVAL 4 MONTH)) = 2021
order by date;

# lets convert that into a function

select * from fact_sales_monthly
where customer_code = 90002002 and 
get_fiscal_year(date) = 2021 
order by date;

# exercise , lets retrive of only q4 of the fiscal year 

# logic 

SELECT month("2022-10-02"); 
SELECT month(curdate());
#
#        FOR 1 fiscal year
#
#        months 9 ,10 ,11 -> Q1            
#		 months 12, 1 , 2 -> Q2
#        months 3 , 4 , 5 -> Q3
#        months 6 , 7 , 8 -> Q4

select * from fact_sales_monthly
where customer_code = 90002002 and 
get_fiscal_year(date) = 2021  and get_fiscal_quarter(date) = "Q4"
order by date;


# lets retrive more two columns product and variant

select s.date, s.product_code, p.product, p.variant, 
s.sold_quantity from 
fact_sales_monthly s 
JOIN dim_product p 
ON s.product_code = p.product_code
WHERE
customer_code=90002002 AND 
get_fiscal_year(s.date)=2021     
LIMIT 1000000;

# now lets retrive the remaining columns , 
-- lets try to join all the columns first

select * from fact_sales_monthly s 
JOIN dim_product p on p.product_code = s.product_code
JOIN fact_gross_price g 
	on g.fiscal_year = get_fiscal_year(s.date)
    and g.product_code = p.product_code 
where customer_code=90002002 AND 
get_fiscal_year(s.date)=2021     
LIMIT 5000;

# now lets get the final report and execute the final query 

select s.date, s.product_code, p.product, p.variant, 
s.sold_quantity, g.gross_price,
ROUND(s.sold_quantity*g.gross_price,2) as gross_price_total from 
fact_sales_monthly s 
JOIN dim_product p 
ON s.product_code = p.product_code
JOIN  fact_gross_price g 
on g.fiscal_year = get_fiscal_year(s.date)
and g.product_code = p.product_code
WHERE
customer_code=90002002 AND 
get_fiscal_year(s.date)=2021     
LIMIT 1000000;

-- -------------------------------------------------------------------------------
-- ASSIGMENT

# lets say now we have a new task 
# gross montly total sales to croma

# meaning in which month how much sales is done with croma
# 2 columns are asked 

# months
# total gross sales 

-- -------------------------------------------------------------------------------

# lets fetch croma customer code 

select * from dim_customer where customer 
like "%croma%" and market = "India";

# lets fetch croma sales

select * from fact_sales_monthly 
where customer_code = 90002002;

# lets fetch gross sales as well

SELECT * from fact_gross_price;

# we remember product_code and fiscal_year is common lets join
select * from fact_sales_monthly s
join fact_gross_price g 
on g.product_code = s.product_code
and g.fiscal_year = get_fiscal_year(s.date)
where customer_code = 90002002;

# we dont want all the columns so lets take the columns and arrange it in order
# lets also get the total gross sales like we did it in last query
 
select date , gross_price , (sold_quantity* gross_price) total_gross_price 
from fact_sales_monthly s
join fact_gross_price g 
on g.product_code = s.product_code
and g.fiscal_year = get_fiscal_year(s.date)
where customer_code = 90002002
order by date asc;


# we got our columns but we can see we have multiple dates repeating , 
# because we have multiple products in same months , lets calc , we will have to group by 
# before group by we have to remember to apply a aggregate fucntion else we get random values lets see

select date , (sold_quantity* gross_price) total_gross_price 
from fact_sales_monthly s
join fact_gross_price g 
on g.product_code = s.product_code
and g.fiscal_year = get_fiscal_year(s.date)
where customer_code = 90002002
group by s.date
order by date asc;


# see we are not getting the right values we are getting a random value ,
# lets apply aggregate function
select date , SUM(sold_quantity* gross_price) total_gross_price 
from fact_sales_monthly s
join fact_gross_price g 
on g.product_code = s.product_code
and g.fiscal_year = get_fiscal_year(s.date)
where customer_code = 90002002
group by s.date
order by date asc;

## now we got it proper , we can round it 
select date , ROUND(SUM(sold_quantity* gross_price),0) total_gross_price 
from fact_sales_monthly s
join fact_gross_price g 
on g.product_code = s.product_code
and g.fiscal_year = get_fiscal_year(s.date)
where customer_code = 90002002
group by s.date
order by date asc;
