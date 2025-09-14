
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

