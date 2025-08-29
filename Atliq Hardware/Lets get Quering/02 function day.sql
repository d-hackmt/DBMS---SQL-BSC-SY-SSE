
/*

 Firsts off , the quarter which we were calculating was 
-- completely wrong , and today we will correct our mistake

*/

# check this out

SELECT 
* , 
(date_add(date ,
INterval 4 month)) as fy_dates ,
quarter(date) as quarters
from fact_sales_monthly;

## the quarters and fy_dates dont match at all 

SELECT 
* , 
(date_add(date ,
INterval 4 month)) as fy_dates ,

quarter((date_add(date ,
INterval 4 month))) as quarters
from fact_sales_monthly;


-- --------------------------------------------------------------------------
--                       NOTE this code wont run 
-- 							you need to create function  under functions column 
--                       below are the ref codes

-- Difference between deterministic and non deteministic

/*

Deterministic vs Non-Deterministic

Deterministic
If you repeat the same action, you always get the same result.

Example:

Turning on a fan → It will always start rotating (assuming power is there).

2 + 2 → Always equals 4.

Non-Deterministic
 If you repeat the same action, the result can change each time.

Example:

Tossing a coin → Could be heads or tails.
or maybe get sales of last month

Asking your friend “What’s for lunch?” → Answer may differ each day.

In short:

Deterministic = predictable (like maths or machines).

Non-Deterministic = unpredictable (like coin toss or human choices).


RELEVANCE IN SQL

------------------------------------------------------------------------------------------------------------

Deterministic in SQL

 A deterministic function always returns the same result every time it is called with the same input.

Example:

SELECT ABS(-10);   -- Always returns 10
SELECT UPPER('hello');  -- Always returns 'HELLO'


 No matter how many times you run it, same input → same output.


--------------------------------

 Non-Deterministic in SQL

 A non-deterministic function may return a different result even with the same input.

Example:

SELECT GETDATE();   -- Returns current date and time (changes every second)
SELECT RAND();      -- Returns a random number (different each call)


 Even if you run it multiple times with no input change, output keeps changing.



---------------------------------------------------------------------------------------------------------


 Simple Difference in SQL

Deterministic = Predictable result (ABS, UPPER, LEN, etc.)

Non-Deterministic = Unpredictable result (GETDATE, RAND, etc.)



*/



/*


-- ---------------------------------------------------------------------------


-- ---------------------- LETS MAKE A FUNCTION for fiscal year ----------------




CREATE DEFINER=`root`@`localhost` FUNCTION `get_fiscal_year`(
	calender_date DATE
) RETURNS year
    DETERMINISTIC
BEGIN
	DECLARE fiscal_year YEAR;
    SET fiscal_year = YEAR(date_add(calender_date , INTERVAL 4 MONTH));
RETURN fiscal_year;
END

-- ---------------------------------------------------------------------------------------


-- ---------------------- LETS MAKE A FUNCTION for fiscal quarter -----------------------

CREATE DEFINER=`root`@`localhost` FUNCTION `get_quarter_year`(
	calender_date DATE
) RETURNS int
    DETERMINISTIC
BEGIN
	DECLARE fy_quarter INT ;
    SET fy_quarter = QUARTER(date_add(calender_date , INTERVAL 4 MONTH));
RETURN fy_quarter;
END

-- -------------------------------------------------------------------------------------


# other ways for fiscal quarter

--      9-10-11 - Q1
--      12-1-2  - Q2
--      3-4-5   - Q3
--      6-7-8   - Q4


-- ---------------------- LETS MAKE A FUNCTION for fiscal quarter in different way -----------------------

CREATE DEFINER=`root`@`localhost` FUNCTION `crazy_quarter`(
	calender_date DATE
) RETURNS char(2) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
	DECLARE m TINYINT;
    DECLARE qtr CHAR(2);
    
    SET m = MONTH(calender_date);
    
	CASE
		WHEN m in (9,10,11) THEN 
			set qtr = "Q1";
		WHEN m in (12,1,2) THEN 
			set qtr = "Q2";
		WHEN m in (3,4,5) THEN 
			set qtr = "Q3";
		WHEN m in (6,7,8) THEN 
			set qtr = "Q4";
    END CASE;
RETURN qtr;
END

-- -------------------------------------------------------------------------------------

*/

-- ------------------------------------------------------------------------------------------------------------------------------

 -- lets test our functions

select gdb0041.get_fiscal_year('2025-09-01');

select gdb0041.get_quarter_year('2025-09-01');

select gdb0041.crazy_quarter('2025-09-01');

