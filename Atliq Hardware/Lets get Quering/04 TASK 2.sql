-- -------------------------------------------------------------------------------
-- 									   TASK 2 
/*
As a product owner, I need an aggregate monthly gross sales report 
for Croma India customer so that I can track how much sales this 
particular customer is generating for AtliQ and manage our relationships accordingly.

The report should have the following fields

1. Month
2. Total gross sales amount to Croma India in this month

-- -------------------------------------------------------------------------------
*/

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


-- -------------------------------------------------------------------------------

## exercise
## Generate a yearly report for Croma India where there are two columns

-- 1. Fiscal Year
-- 2. Total Gross Sales amount In that year from Croma


select fiscal_year , 
ROUND(SUM(sold_quantity* gross_price),2) 
as fiscal_year_gross_sales
from fact_sales_monthly s
join fact_gross_price g 
on g.product_code = s.product_code
and g.fiscal_year = get_fiscal_year(s.date)
where customer_code = 90002002
group by fiscal_year
order by date asc;

-- -------------------------------------------------------------------------------