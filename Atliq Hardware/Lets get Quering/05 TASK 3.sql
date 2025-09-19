/*
Create a stored procedure that can determine the market badge based on the following logic,
if total sold quantity > 5 million that market is considered Gold else it is Silver

My inputs will be

market
fiscal year

Output i am expecting

market badge

*/

# so this way you will understand which market is making you max or min by fiscal_year

 -- -------------------------------------------------------------------------------

# EG : 

-- INDIA , 2020 --> GOLD
-- INONESIA , 2020 --> SILVER

 -- -------------------------------------------------------------------------------

# How ?  you have to find that out by total sold quantity

# lets fetch the relevant columns , we need sold_quanitty and markets

SELECT * from fact_sales_monthly ; 
SELECT * from dim_customer;

-- lets join these tables and get what we want
-- all we have to do is join these tables and figure out which market sold how much by group by

SELECT * from fact_sales_monthly s
JOIN dim_customer c
ON c.customer_code = s.customer_code
where get_fiscal_year(s.date) = 2021 ;

## lets get rows where there is market and sold quantity

SELECT market , sold_quantity 
from fact_sales_monthly s
JOIN dim_customer c
ON c.customer_code = s.customer_code
where get_fiscal_year(s.date) = 2021;


## now group by market to get total sold_quantity

SELECT market , sold_quantity 
from fact_sales_monthly s
JOIN dim_customer c
ON c.customer_code = s.customer_code
where get_fiscal_year(s.date) = 2021
group by market;

## see its giving you random number because you didnt aggregate ,
## everytime you use group by you have to aggregate 

SELECT market , sum(sold_quantity) as total_qty
from fact_sales_monthly s
JOIN dim_customer c
ON c.customer_code = s.customer_code
where get_fiscal_year(s.date) = 2021 
group by market;

-- --------------------------------------------------------------------

# we can also use CTE's

with abc as (SELECT market , sum(sold_quantity) as total_qty
from fact_sales_monthly s
JOIN dim_customer c
ON c.customer_code = s.customer_code
where get_fiscal_year(s.date) = 2021 
group by market)

Select market from abc 
where total_qty > 5000000;



# if else as well
WITH abc AS (
    SELECT market, SUM(sold_quantity) AS total_qty
    FROM fact_sales_monthly s
    JOIN dim_customer c
    ON c.customer_code = s.customer_code
    WHERE get_fiscal_year(s.date) = 2022 
    GROUP BY market
)
SELECT market,
       CASE 
           WHEN total_qty > 5000000 THEN 'gold'
           ELSE 'silver'
       END AS market_category
FROM abc;



-- --------------------------------------------------------------------------

## perfect 

-- now you got for all the markets indian indonesia etc 

## lets say we want only one country

SELECT market , sum(sold_quantity) as total_qty
from fact_sales_monthly s
JOIN dim_customer c
ON c.customer_code = s.customer_code
where 
	get_fiscal_year(s.date) = 2021 
	and c.market = "India"
group by market;

## okay now lets create a stored procedure out of it

# paste this query there





/*


CREATE PROCEDURE `get_market_badge`(
        	IN in_market VARCHAR(45),
        	IN in_fiscal_year YEAR,
        	OUT out_level VARCHAR(45)
)
BEGIN
	 DECLARE qty INT DEFAULT 0;

	 # Default market is India
	 IF in_market = "" THEN
		  SET in_market="India";
	 END IF;

	 # Retrieve total sold quantity for a given market in a given year
	 SELECT 
		  SUM(s.sold_quantity) INTO qty
	 FROM fact_sales_monthly s
	 JOIN dim_customer c
	 ON s.customer_code=c.customer_code
	 WHERE 
		  get_fiscal_year(s.date)=in_fiscal_year AND
		  c.market=in_market;

	 # Determine Gold vs Silver status
	 IF qty > 5000000 THEN
		  SET out_level = 'Gold';
	 ELSE
		  SET out_level = 'Silver';
	 END IF;
END


*/



# lets call out stored procedure 

set @out_badge = '0';
call gdb0041.get_market_badge('India', 2021, @out_badge);
select @out_badge;


-- -----------------------------------------------------------------------------------

# we have seen 

# input and output parameters
# how to convert aggregates into a new variable using INTO
# how to write if else statements 
# how to set default values
# comments

-- -----------------------------------------------------------------------------------

# benefits of stored procedures

-- 1 )  Convinience 
-- 2 ) 	Security
-- 3 ) 	Can often be used in data science notebooks
-- 4 )  Maintainablity
-- 5 )  Performance
-- 6 )  Developer Productivity


-- ---------------------------------------------------------------------------------------


## learning sql is like swimming , you will have to dive in , you cant just read and chill

-- ----------------------------------------------------------------------------------------





