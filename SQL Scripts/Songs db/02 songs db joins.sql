# Lets say i have someone who says i want to know the songs which made the highest profit 
#
#
#                                           LETS EXPLORE JOINS
#---------------------------------------------------------------------------------------------------

# lets try a join , INNER JOIN , by default
select s.song_id ,  title , budget , unit  , currency 
from songs as s 
JOIN financials f 
ON s.song_id AND f.song_id;

# lets see another method , USING clause
# NOTE : We use using clause only when we both the joining names are same ,
# else we have to use ON clause

select 
s.song_id , title , budget , unit  , currency 
from songs s 
JOIN financials f 
USING (song_id);

# lets see left join
SELECT
s.song_id , title , budget , unit  , currency 
FROM songs s 
LEFT JOIN financials f 
using (song_id);

# lets see right join
SELECT
f.song_id , title , budget , unit  , currency 
FROM songs s 
RIGHT JOIN financials f 
using (song_id);

# lets see full join ,
# make sure the columns you are retriving should be the same

SELECT 
s.song_id , title , budget , unit  , currency 
FROM songs s 
LEFT JOIN financials f 
using (song_id)

UNION

SELECT 
f.song_id , title , budget , unit  , currency 
FROM songs s 
RIGHT JOIN financials f 
using (song_id);

#---------------------------------------------------------------------------------------------
#                             SALES DATA SET FOR CROSS JOIN                             
#---------------------------------------------------------------------------------------------

select * from items ;
select * from variants ;

# LETS study cross joins
select * from items 
CROSS JOIN variants;

SELECT *, 
concat(name ," - " , variant_name) as full_name , 
(price + variant_price) as full_prize 
from items 
CROSS JOIN variants;

## finally if you remove *  , menu is ready
SELECT 
concat(name ," - " , variant_name) as full_name , 
(price + variant_price) as full_prize 
from items 
CROSS JOIN variants;


#---------------------------------------------------------------------------------------------
#                    ANALYTICS ON TABLES    , lets go back on songs dataset                   
#---------------------------------------------------------------------------------------------

## NOW i want to get the movie name and the profit earned

SELECT 
s.song_id , title , budget ,
revenue , currency , unit , (revenue - budget) as profit
FROM songs s JOIN financials f USING (song_id);


## now i want only Romantic genre and according to profit 

SELECT 
s.song_id , title , budget ,
revenue , currency , unit , (revenue - budget) as profit
FROM songs s JOIN financials f USING (song_id)
WHERE genre = "Romantic"
ORDER BY profit DESC;

## but here we see because of units , we got wrong retrival
# we have to now neutralize the units to millions 

SELECT 
s.song_id , title , budget ,
revenue , currency , unit ,
CASE 
	WHEN unit = "thousands"  THEN (revenue - budget)/1000
	WHEN unit = "billions"  THEN (revenue - budget)*1000
    ELSE (revenue - budget)
END as profit_mln
FROM songs s JOIN financials f USING (song_id)
WHERE genre = "Romantic"
ORDER BY profit_mln DESC;

## now we can round this up

SELECT 
s.song_id , title , budget ,
revenue , currency , unit ,
CASE 
	WHEN unit = "thousands"  THEN ROUND((revenue - budget)/1000 , 1)
	WHEN unit = "billions"  THEN ROUND((revenue - budget)*1000 , 1)
    ELSE ROUND((revenue - budget),1)
END as profit_mln
FROM songs s JOIN financials f USING (song_id)
WHERE genre = "Romantic"
ORDER BY profit_mln DESC;


#---------------------------------------------------------------------------------------------
#                               JOIN MORE THAN 2 TABLES                
#---------------------------------------------------------------------------------------------


select * from songs;
select * from artists;
select * from song_artist;

## lets say i want like 
#                           |  song_id | title 			| artist name name          |
#			    			|  101     | getup jawani   |     honey singh , Badshah |
#
# WE WILL PERFORM A multi JOIN

SELECT s.song_id , s.title , a.name
FROM songs s
JOIN song_artist sa using (song_id)
JOIN artists a using (artist_id);
	
# but here we didnt get quite what we were looking for

# lets try something else , can we group something?  GROUP BY ??? YO lets doit

SELECT  s.title , a.name
FROM songs s
JOIN song_artist sa using (song_id)
JOIN artists a using (artist_id)
group by s.song_id ;

# ok  , no error but we didnt  get what we were looking for 
# google karte hai 

# ohhh i found group_concat 
SELECT  m.title , group_concat(a.name SEPARATOR " | ")
FROM songs m
JOIN song_artist ma using (song_id)
JOIN artists a using (artist_id)
group by m.song_id ;

### yeeeee we got it 


## now lets say we want report like reverse

## lets say i want like 
#                           | artist name  |  title                   |
#			    			| honey singh  |  brown rang , dope shope |
#
# WE WILL PERFORM A multi JOIN again 

SELECT a.name , group_Concat(s.title SEPARATOR " | " ) as songs  , 
count(s.title) as song_cnt 
FROM artists a 
JOIN song_artist sa USING (artist_id)
JOIN songs s USING (song_id)
GROUP BY artist_id
ORDER BY song_cnt DESC;


