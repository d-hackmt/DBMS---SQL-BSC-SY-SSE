#
#                                         LETS EXPLORE SUB-QUERIES
#---------------------------------------------------------------------------------------------------

#lets say i want to select the song with highest spotify_rating

# one way to do that is

SELECT * from songs order by spotify_rating DESC LIMIT 1;

# the other way to do that is 

SELECT max(spotify_rating) as maxz from songs;

# we have another way

SELECT * from songs where spotify_rating in (9.3);  

                         #or

SELECT * from songs where spotify_rating =9.3;

# lets see this new way 

SELECT * from songs where spotify_rating  = (SELECT max(spotify_rating) from songs);

# you guys might say , we can do this , but this doesnt work , you will get wrong way of grouping error

SELECT * from songs where spotify_rating  = max(spotify_rating);

#---------------------------------------------------------------------------------------------------
#
#                              1) so we saw subquery returns a value 
#
#---------------------------------------------------------------------------------------------------


#---------------------------------------------------------------------------------------------------
#
#                              2)  subquery returns a list of values as well 
#
#---------------------------------------------------------------------------------------------------


# lets say i want min and max spotify_rating

SELECT max(spotify_rating) from songs;
SELECT min(spotify_rating) from songs;

## so one way to do this is 

SELECT * from songs where spotify_rating in ( 1.9 , 9.3);  # it works

## but i dont know what that it so how to find out 

# lets say  
SELECT * 
FROM songs 
WHERE spotify_rating IN (
    (SELECT MIN(spotify_rating) FROM songs),
    (SELECT MAX(spotify_rating) FROM songs)
);



# similarly  Select all the songs with minimum and maximum release_year. 
SELECt * from songs 
where release_year in
(
(SELECT MIN(release_year) FROM songs),
(SELECT MAX(release_year) FROM songs)
) ;


#---------------------------------------------------------------------------------------------------
#
#                        2) so now we saw subquery returns a list of values as well 
#                AND 
#                        3) Subquery returns a table as well , lets see how
#---------------------------------------------------------------------------------------------------

## lets say my manager tells me , 
# select all the artists whose age > 70 and < 85
# lets get that age

select * from artists;

# so we will have to get the current age first 
# i dont remember , what to do ??????     -------> GOOGLE folks GOOGLE


SELECT 
name , YEAR(curdate())-birth_year as age
from artists;

# now lets apply condition , but where clause  wont work ,because it doesnt work with aggregates

SELECT 
name , YEAR(curdate())-birth_year as age
from artists where age > 30 and  age <65 ;

# but having will work right

SELECT 
name , YEAR(curdate())-birth_year as age
from artists having age > 30 and  age <65 ;

## coool we get it now , lets see how subquery returns a table

# so the query which we wrote returns a table , lets use this table to retrive without using HAVING clause

SELECT * from
(SELECT 
name , YEAR(curdate())-birth_year as age
from artists) as artists_age_table 
where age  > 30 and age < 65;

# and thats how we do it 

#---------------------------------------------------------------------------------------------------|
#                                                                                                   |
#	                                        so now we saw                                           |
#                                                                                                   |
#                        1) Subquery returns a value                                                |
#                                                                                                   |
#                        2) Subquery returns a list of values                                       |
#                                                                                                   |
#                        3) Subquery returns a table                                                |
#---------------------------------------------------------------------------------------------------|

#---------------------------------------------------------------------------------------------------|
#
#									LETS Study , ANY & ALL operators .
#
#---------------------------------------------------------------------------------------------------|


# lets say you want to select all the artists 
# who has worked in any of the songs with ids (51,68,76)


# one way to do it is using join 


SELECt a.name from artists a 
JOIN song_artist ma using (artist_id)
where song_id in (51,68,76);


# it works yea but  lets see what another way 

select artist_id from song_artist where song_id in (51,68,76);

# so how to get names? stuck ??

# lets use subquery now

SELECT name from artists 
where artist_id IN 
(select artist_id from song_artist 
where song_id in (51,68,76));

# this was better , we have another way we can use ANY 
# meaning select ANY song from this subquery , lets seee

SELECT name from artists 
where artist_id = ANY 
(select artist_id from song_artist 
where song_id in (51,68,76));

## looks more readable

## if you dont specify ANY and just say  artist_id = (subquery) 
#you will get an error because = sign is used to get a single value 
# and any is giving us a list of values

# so you either use ANY or IN , but any aligns more with our question
# and yea , better readablity

# lets see this new query

# select all the songs whose rating is greater than any of the 
# International Villager album songs 

SELECT * from songs where 
album = "International Villager";

# so how do you get all International Villager spotify_rating?

SELECT spotify_rating from songs 
where album = "International Villager";

# now lets use ANY 


SELECT * from songs 
where spotify_rating > ANY 
(SELECT spotify_rating from songs 
where album = "International Villager");

# do we have another way to write it ? , if we dont want to use ANY , yes we do 

SELECT * from songs 
where spotify_rating >  
(SELECT min(spotify_rating) from songs 
where album = "International Villager");


# so we see we get the same thing 

# so instead of ANY we can write SOME as well here , and it will work the same

SELECT * from songs 
where spotify_rating > SOME 
(SELECT spotify_rating from songs 
where album = "International Villager");

# now i want to get all the songs whose rating is more than ALL International Villager songs 

# lets see whats the max spotify_rating
SELECT max(spotify_rating) 
from songs where album like "%villager%";

# so we have to check if this query gives us more than 8.4 

SELECT * from songs
where spotify_rating > ALL(
SELECT spotify_rating from songs 
where album like "%villager%"
);

# we still have another way to write it , and see we get the same thing

SELECT * from songs
where spotify_rating > (
SELECT max(spotify_rating) from songs 
where album like "%villager%"
);


#---------------------------------------------------------------------------------------------------|



#---------------------------------------------------------------------------------------------------|
#
#					LETS Study , Co - related subquery , Performance analysis
#
#---------------------------------------------------------------------------------------------------|


# lets say you want 

# artist_id , name , song_cnt  -> meaning 
# how many songs the respecitive artists have performed in 

# so we can do it simply by

SELECT artist_id , 
count(song_id) as song_cnt
from song_artist
group by artist_id 
order by song_cnt DESC;

# but here name is missing ?

# okay sure we can  get that with simple JOIN

SELECT name , count(song_id) as song_cnt
FROM artists a
JOIN song_artist ma
USING (artist_id) 
GROUP BY artist_id
ORDER BY song_cnt DESC;

# see we got it 

# lets see if we have another way of doing that

select * from song_artist;

# okay lets fetch the count for one id


SELECT count(*) from song_artist where artist_id = 15; 

# ok so now we get the count of this id 15 artist is 12 ,
# this is only for 1 , i want  a for loop sort of thing 

# lets write our subquery

SELECT artist_id , name ,
(SELECT count(*) from song_artist 
where artist_id = artists.artist_id) as song_cnt
from artists
order by song_cnt DESC;

## okay fine , so we got it , this is called co-related subquery  .
# because we refered artists table in our subquery which is a outer table , so  CO-related sub_query 
# because its execution depend on outer table 


# you will go row by row in your outer table 

# lets say you pick the first_id = 50 , for that you will get a count from song_artist table

# now which one is better group by or this ??

# well depends what suits you and whos performance is faster 

# if we write explain analyze before a query we will get a log of the execution

EXPLAIN ANALYZE
SELECT artist_id , name ,
(SELECT count(*) from song_artist 
where artist_id = artists.artist_id) as song_cnt
from artists
order by song_cnt DESC;

#  (actual time=0.435..0.439 rows=67 loops=1)


# this means it tool 0.435secs for one row and 
# 0.439secs for all rows

# lets check for group by query  

EXPLAIN ANALYZE
SELECT name , count(song_id) as song_cnt
FROM artists a
JOIN song_artist ma
USING (artist_id) 
GROUP BY song_id
ORDER BY song_cnt DESC;


# (actual time=0.379..0.381 rows=39 loops=1)

-- see this took less time , compared to our subquery , so we will go with this 



#---------------------------------------------------------------------------------------------------|
#
#					         LETS Study an exotic topic ,
#		                     Common table expressions (CTE)
#				       		
#---------------------------------------------------------------------------------------------------|

# remember subqueries also return a table and we did this query where 

# select all the artists whose age > 30 and < 65

SELECT * 
from (SELECt name , 
YEAR(curdate()) - birth_year as age 
from artists) as artists_age
where age > 30 and age < 65;

# here we made a temporary  table and in outer query
# used age as critria to retrive something

# imagine we have some table instead of this inner query 


SELECT * from (sometable) 
where age > 35 and age < 60;


# so lets write that , using CTE

with artists_age as (SELECt name , 
YEAR(curdate()) - birth_year as age 
from artists)

SELECT * from artists_age
where age > 35 and age < 65;


# look at the beauty of this query its looks so 
# simple and readible compared to subquery

# lets go to mysql doc and see this CTE

##  https://dev.mysql.com/doc/refman/8.4/en/with.html

# okay we can see we have multiple CTE's as welll

# okay we can have different col name as well , 
# so inner columns name can be different and we can have new names as well

with artists_age (a_name , a_age) as (SELECt name as x , 
YEAR(curdate()) - birth_year as y 
from artists)

SELECT * from artists_age
where a_age > 35 and a_age < 65;

## niceee---------------------------

# lets take an example of something bit more complex

# show all songs that produced / made  more than 500%  profit or more 
# and their rating was less than avg_imdb rating of all songs 


# so this query looks to big and tricky , lets divide and conquer and make 2 queries out of it

#  1) show all songs that made  more than 500%  profit or more 

# we have financials table , lets see 

SELECt * , 
(revenue - budget)* 100 / budget as profit_pct 
from financials 
where profit_pct > 500;

# this above query wont work becasue we cant use aggregates / calc with where , we can use having

SELECt * , (revenue - budget)* 100 / budget as profit_pct 
from financials 
having profit_pct > 500;

# or we can use this also , same thing 

SELECt * , (revenue - budget)* 100 / budget as profit_pct 
from financials 
where (revenue - budget)* 100 / budget > 500;

# so this is done -------------------------------------------------------


#  2) songs whose spotify_rating is less than avg spotify_rating of all songs 

# we can get avg rating like this 
SELECt round(avg(spotify_rating) , 2) as avggg from songs;

# we can also get like this with subquery
 
select * from songs where spotify_rating < 
(SELECt round(avg(spotify_rating) , 2) from songs);


-- okay so now we have both tables and let combine them to get our answers 

# 1st table gives you pct prcnt ---lets call it --> x table
# 2nd table give you all the less than avg songs ---lets call it --> y table

# one thing if you see in common is , they have song_id in common

# lets join them ? 

# we can get our answer by subqueries and common tables expressions (CTE) both 

# lets do by subquery  1st 


SELECT * from 
(SELECt * , (revenue - budget)* 100 / budget as profit_pct 
from financials) as x
JOIN 
(select * from songs where spotify_rating < 
(SELECt round(avg(spotify_rating) , 2) from songs)) as y
using(song_id)
where profit_pct  > 500;

# i dont want every col , lets filter

SELECT song_id , title , profit_pct , spotify_rating from 
(SELECt * , (revenue - budget)* 100 / budget as profit_pct 
from financials) as x
JOIN 
(select * from songs where spotify_rating < 
(SELECt round(avg(spotify_rating) , 2) from songs)) as y
using(song_id)
where profit_pct  > 500;


# so we did get it but isnt it very messy 

# lets use CTE
# can we have soemthing like

-- ------------------------------------------------------------------------------ 
with x as () , 
	 y as ()

SELECt song_id  , profit_pct ,
title , spotify_rating
from x
JOIN y USING (song_id)
where profit_pct>500;

-- ------------------------------------------------------------------------------ 

-- okay lets do it


with x as (SELECt * , (revenue - budget)* 100 / budget as profit_pct 
from financials) , 
	 y as (select * from songs where spotify_rating < 
(SELECt round(avg(spotify_rating) , 2) from songs))

SELECt song_id  , profit_pct ,
title , spotify_rating
from x
JOIN y USING (song_id)
where profit_pct>500;



#---------------------------------------------------------------------------------------------------
# BENEFITS OF CTES
# 
# 1) SIMPLE QUERIES - as queires evolve , people keep on adding more and more where clauses etc and when there is issue in the 
#    system no one dares to touch that query because it will affect the whole system
# 2) SAME RESULT set can be referenced multiple times -  query reusablity
# 3) If you see some table used always , we can convert it into views , gives potential candidates for views
#---------------------------------------------------------------------------------------------------
