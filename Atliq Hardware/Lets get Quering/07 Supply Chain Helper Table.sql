# lets create a helper table for furutre analytics

SELECT * from fact_sales_monthly s
JOIN fact_forecast_monthly f
USING (date , customer_code , product_code);

# lets do some inspection

-- sales table

SELECT * from fact_sales_monthly;
SELECT count(*) from fact_sales_monthly;
SELECT MIN(date) from fact_sales_monthly;
SELECT MAX(date) from fact_sales_monthly;


-- forecast table
SELECT * from fact_forecast_monthly;
SELECT count(*) from fact_forecast_monthly;
SELECT MIN(date) from fact_forecast_monthly;
SELECT MAX(date) from fact_forecast_monthly;

-- lets manually select columns and perform a union JOIN 

SELECT 
s.date as date,
s.fiscal_year as fiscal_year,
s.product_code as product_code,
s.customer_code as customer_code,
s.sold_quantity as sold_quantity,
f.forecast_quantity as forecast_quantity
from fact_sales_monthly s
LEFT JOIN fact_forecast_monthly f
USING (date , customer_code , product_code)

UNION

SELECT 
f.date as date,
f.fiscal_year as fiscal_year,
f.product_code as product_code,
f.customer_code as customer_code,
s.sold_quantity as sold_quantity,
f.forecast_quantity as forecast_quantity
from fact_sales_monthly s
RIGHT JOIN fact_forecast_monthly f
USING (date , customer_code , product_code);


## lets create a table out of it , we will need it for future analytics,
-- it would take some time , now worries

create table fact_act_est
(
SELECT 
s.date as date,
s.fiscal_year as fiscal_year,
s.product_code as product_code,
s.customer_code as customer_code,
s.sold_quantity as sold_quantity,
f.forecast_quantity as forecast_quantity
from fact_sales_monthly s
LEFT JOIN fact_forecast_monthly f
USING (date , customer_code , product_code)

UNION

SELECT 
f.date as date,
f.fiscal_year as fiscal_year,
f.product_code as product_code,
f.customer_code as customer_code,
s.sold_quantity as sold_quantity,
f.forecast_quantity as forecast_quantity
from fact_sales_monthly s
RIGHT JOIN fact_forecast_monthly f
USING (date , customer_code , product_code)

);


# and then convert the FISCAL YEAR INTO generated column

# now lets update the null values , because we cant keep it empty and cant delete them too 
-- to preserve data

update fact_act_est
set sold_quantity = 0
where sold_quantity is null;

update fact_act_est
set forecast_quantity = 0
where forecast_quantity is null;

