
-- QUESTIONS 

/*

1) If you had to divide all these 20 tables in 7 groups 
which groups will they be 
eg: 

if i make a group named education

Education :

student_info
teacher_roster
class_map
course_catalog

this is 1 out of 7 , get more 6 

you really gotta reverse engineer now . (No ss required , you need to type them)

*/

/*

2) Explore enitre dataset and spot any 5 mistakes in any of the tables and stick ss 

taks sheet 
sudent info
health centre 
bugdet
kredit_marks
bdayte


3) List the names and fee status of any 5 students
who have not paid the fee
by using 'LIKE' clause only
eg: where xyz like = %abc%
*/

SELECT p.name
FROM sudent_info s
JOIN person_registry p
using (person_id)
WHERE LOWER(fees_paidorNot) LIKE 'd%'
LIMIT 5;


-- 4) which is the name of highest paid artist (use subquery only)
	
SELECT p.name , e.pay 
FROM 
person_registry p
join artist_pool a
using (person_id)
join event_artist e
on a.artist_id = e.artist_id
where pay = (SELECT max(pay) from event_artist);


-- 5) Get all teachers who are also docters


-- 6) Find 3 artists who performed at any event in 2024 with date of performance .

SELECT p.name , eh.date from person_registry p
join artist_pool a
on p.person_id = a.person_id
join event_artist e
on a.artist_id = e.artist_id
join event_hub eh
on eh.event_id = e.event_id
where year(eh.date) = 2024
LIMIT 3;


-- 7) list the names of all teachers who are born after 2007 

SELECT person_id, name, type, bdayte
FROM person_registry
WHERE year(bdayte) > 2007
and type = 'teacher';


-- 8) Show events where the event date is later than the closing date


-- 9) how many doctors visited the club after 2020


-- 10) how many diesel busses are under maintenance

SELECT count(*) 
FROM sql_re_eval.transport_unit
where staytus = 'maintenance'
and fuel = "diesel"
and type = 'bus';




