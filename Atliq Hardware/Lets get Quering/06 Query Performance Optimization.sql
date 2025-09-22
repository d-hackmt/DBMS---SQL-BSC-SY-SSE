/*  # QUERY PERFORMANCE

                                          A day on query Performance

*/




# try to execute multiple joins with conditons

SELECT
	s.date, p.product,variant , g.gross_price ,
	sold_quantity,
	(g.gross_price * s.sold_quantity) as gross_total , pre_invoice_discount_pct
from fact_sales_monthly s
JOIN dim_product p 
	ON p.product_code = s.product_code
JOIN fact_gross_price g 
	ON g.product_code = s.product_code
	and g.fiscal_year = get_fiscal_year(s.date)
JOIN fact_pre_invoice_deductions pre
	ON pre.customer_code = s.customer_code
	AND pre.fiscal_year = get_fiscal_year(s.date)
where 
s.customer_code = 90002002
and get_fiscal_year(s.date) = 2021; 

/*  # QUERY PERFORMANCE

1st trick to make it better , add a dim date table with 2 columns 

1) calender date of type date           -- Here you will make an excel sheets with 
											unique date like fact_sales_monthly
                                            
										-- to check : SELECT distinct date from fact_sales_monthly
                                            
2) Fiscal_year of type YEAR             -- this will be a generated column 
										-- YEAR(date_add(date,INTERVAL 4 MONTH));

*/

# check query performance


EXPLAIN ANALYZE
SELECT
	s.date, p.product,variant , g.gross_price ,
	sold_quantity,
	(g.gross_price * s.sold_quantity) as gross_total , pre_invoice_discount_pct
from fact_sales_monthly s
JOIN dim_product p 
	ON p.product_code = s.product_code
JOIN fact_gross_price g 
	ON g.product_code = s.product_code
	and g.fiscal_year = get_fiscal_year(s.date)
JOIN fact_pre_invoice_deductions pre
	ON pre.customer_code = s.customer_code
	AND pre.fiscal_year = get_fiscal_year(s.date)
where 
s.customer_code = 90002002
and get_fiscal_year(s.date) = 2021; 

# PERFORMANCE OPTIMIZATION

--  1)

SELECT distinct date from fact_sales_monthly; 

## 2017-9-1  ------- 2021-12-01


--  2) You can remove cutomer code if you want

SELECT
	s.date, p.product,variant , g.gross_price ,
	sold_quantity,
	(g.gross_price * s.sold_quantity) as gross_total , 
    pre_invoice_discount_pct
from fact_sales_monthly s
JOIN dim_date d 
	ON d.calender_date = s.date
JOIN dim_product p 
	ON p.product_code = s.product_code
JOIN fact_gross_price g 
	ON g.product_code = s.product_code
	and g.fiscal_year = d.fiscal_year
JOIN fact_pre_invoice_deductions pre
	ON pre.customer_code = s.customer_code
	AND pre.fiscal_year = d.fiscal_year
where 
	s.customer_code = 90002002
and d.fiscal_year = 2021;

# now check performance

EXPLAIN ANALYZE
SELECT
	s.date, p.product,variant , g.gross_price ,
	sold_quantity,
	(g.gross_price * s.sold_quantity) as gross_total , 
    pre_invoice_discount_pct
from fact_sales_monthly s
JOIN dim_date d 
	ON d.calender_date = s.date
JOIN dim_product p 
	ON p.product_code = s.product_code
JOIN fact_gross_price g 
	ON g.product_code = s.product_code
	and g.fiscal_year = d.fiscal_year
JOIN fact_pre_invoice_deductions pre
	ON pre.customer_code = s.customer_code
	AND pre.fiscal_year = d.fiscal_year
where 
	s.customer_code = 90002002
and d.fiscal_year = 2021;

/*  # QUERY PERFORMANCE

2nd trick to make it better , add generated column in fact_sales_monthly 

                                            
1) Fiscal_year of type YEAR             -- this will be a generated column 
										-- YEAR(date_add(date,INTERVAL 4 MONTH));

*/


SELECT
	s.date, p.product,variant , g.gross_price ,
	sold_quantity,
	(g.gross_price * s.sold_quantity) as gross_total , 
    pre_invoice_discount_pct
from fact_sales_monthly s
JOIN dim_product p 
	ON p.product_code = s.product_code
JOIN fact_gross_price g 
	ON g.product_code = s.product_code
	and g.fiscal_year = s.fiscal_year
JOIN fact_pre_invoice_deductions pre
	ON pre.customer_code = s.customer_code
	AND pre.fiscal_year = s.fiscal_year
where 
	s.customer_code = 90002002
and s.fiscal_year = 2021;

# now check performance

EXPLAIN ANALYZE
SELECT
	s.date, p.product,variant , g.gross_price ,
	sold_quantity,
	(g.gross_price * s.sold_quantity) as gross_total , 
    pre_invoice_discount_pct
from fact_sales_monthly s
JOIN dim_product p 
	ON p.product_code = s.product_code
JOIN fact_gross_price g 
	ON g.product_code = s.product_code
	and g.fiscal_year = s.fiscal_year
JOIN fact_pre_invoice_deductions pre
	ON pre.customer_code = s.customer_code
	AND pre.fiscal_year = s.fiscal_year
where 
	s.customer_code = 90002002
and s.fiscal_year = 2021;

# cool we have optmized this
