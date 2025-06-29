# --------------------------------------------------------------------------------------------------

#                     Retrieve Data Using Text Query (SELECT, WHERE, DISTINCT, LIKE)

# --------------------------------------------------------------------------------------------------

# select all songs
SELECT * FROM songs;

# lets select a specific column or columns
SELECT genre FROM songs;
SELECT album , genre FROM songs;
SELECT title, release_year , album FROM songs;

# select all bollywood songs
SELECT * FROM songs WHERE genre = "Bollywood";

# lets count how many rows 
SELECT count(*) FROM songs;

# lets count how many rows we have in EDM
SELECT count(*) FROM songs WHERE genre = "EDM"; 

# lets get unique album names or genre names
SELECT DISTINCT album from songs;
SELECT DISTINCT genre from songs;

# lets find all thor songs
SELECT * FROM songs WHERE title LIKE "%Rolling%";  ## wildcard
SELECT * FROM songs WHERE title LIKE "%boy%";
SELECT * FROM songs WHERE title LIKE "%Blinding Lights%";


# --------------------------------------------------------------------------------------------------

#                     TILL HERE IT WAS TEXT BASED RETRIVAL , LETS EXPLORE NUMERICAL BASED

# --------------------------------------------------------------------------------------------------

#                  Retrieve Data Using Numeric Query (BETWEEN, IN, ORDER BY, LIMIT, OFFSET)

# --------------------------------------------------------------------------------------------------


# lets see blank values
SELECT * FROM songs WHERE album = "";    

# lets find the max rating and min rating
SELECT album , max(spotify_rating) as max_rating FROM songs;
SELECT title , min(spotify_rating) as min_rating FROM songs;


# lets see the songs whose rating is more than 9 
SELECT * FROM songs WHERE spotify_rating > 9;

# lets see the songs whose rating is more less than 5 
SELECT * FROM songs WHERE spotify_rating < 8;

# lets use AND operator 
SELECT * FROM songs WHERE spotify_rating >= 8 AND spotify_rating <= 8.5 ;

# lets use BETWEEN , AND operator , like a range function
# retrieve spotify_rating records 
SELECT * FROM songs WHERE spotify_rating BETWEEN 6 AND 9;

# retrieve release year records 
SELECT * FROM songs WHERE release_year BETWEEN 2019 AND 2022;


# lets use IN operator and retrieve from years 2019 and 2022 
# note that its IN and not BETWEEN
SELECT * FROM songs WHERE release_year IN (2018 , 2023);
SELECT * FROM songs WHERE genre IN ("Pop" , "Rap");
SELECT count(*) FROM songs WHERE album IN ("After Hours" , "Gully Boy");


# lets use NULL and NOT NULL , works only on numerical columns
# Retrieve all null and not null columns from spotify_rating
SELECT * FROM songs WHERE spotify_rating is NULL;
SELECT * FROM songs WHERE spotify_rating is NOT NULL;

# lets use or operator
SELECT * FROM songs WHERE release_year = 2022 or release_year = 2019 or release_year = 2018 ;

## lets use ORDER BY clause to print  songs  according to spotify_rating
SELECT * FROM songs where genre = "Punjabi Pop" ORDER BY spotify_rating ;

## lets use ORDER BY clause , ASC by default to print  songs  according to spotify_rating
SELECT * FROM songs where genre = "POP" ORDER BY spotify_rating ASC;

## lets use ORDER BY clause , DESC to print  songs  according to spotify_rating 
SELECT * FROM songs where genre = "POP" ORDER BY spotify_rating DESC;

## lets use ORDER BY clause , DESC to print  songs  according to spotify_rating and album is not empty
SELECT * FROM songs where genre = "RAP" AND album != "" ORDER BY spotify_rating DESC;


# -------------------------------------------------------------------------------------------

#                            FUNCTIONS - eg : HANDS , legs , buttons etc
#                          BASIC Summary Analytics (MIN, MAX, AVG, GROUP BY)

# -------------------------------------------------------------------------------------------

# count function , lets count total unique album 
select distinct count(album) FROM songs;

# min and max functions , spotify_rating
SELECT max(spotify_rating) as max_rating FROM songs;
SELECT min(spotify_rating) as min_rating FROM songs;

# average function ,avg spotify_rating
SELECT avg(spotify_rating) FROM songs;
# round up 
SELECT ROUND(avg(spotify_rating) , 2) as avgg FROM songs;

# select count of hollywood songs 
SELECT count(*) from songs where genre = "Pop";

#### NOW I WANT table like this
##                                        Pop	= 13
##                                        Romantic = 18
##                                        Punjabi Pop = 6

select genre ,count(*) as ind_countt FROM songs GROUP BY genre; 

## same for album
select album ,count(*) as alb_countt FROM songs WHERE album != "" GROUP BY album order by alb_countt DESC LIMIT 5 ;

## now i want 
##   genre   , SONG COUNT , avg spotify rating

SELECT genre , count(genre) as song_cnt , avg(spotify_rating) as avg_rating FROM songs GROUP BY genre; 

# same for album
SELECT 
album , 
count(album) as album_cnt , 
ROUND(avg(spotify_rating) , 2) as avg_rating 
FROM songs 
WHERE album != "" 
GROUP BY album 
ORDER BY album_cnt DESC ;


# -------------------------------------------------------------------------------------------
#                                                NEW 
#                                           HAVING CLAUSE 
# -------------------------------------------------------------------------------------------


 #                          RELEASE YEAR | CNT of songs|
 #                              2022     |        5     |
 #                              2021     |        3     |
 #
## select all the years where more than 2 songs were released
SELECT release_year , count(*) as cnt FROM songs GROUP BY release_year ORDER BY cnt DESC ; 

#### now most part is done , we only want to filter out more than 2 but if we us this query we will get error

SELECT release_year , count(*) as cnt FROM songs where cnt>2 GROUP BY release_year ORDER BY cnt DESC ;

## see we have an error

## USING HAVING CLAUSE , there you go 
SELECT release_year , count(*) as cnt FROM songs GROUP BY release_year HAVING cnt > 2 ORDER BY cnt DESC ;

# -------------------------------------------------------------------------------------------
### key point , where does not has to be in SELECT 

SELECT title FROM songs WHERE release_year = 2022;

## see this one willl give you error
SELECT title FROM songs HAVING release_year = 2022;

# but if you this one
SELECT title , album FROM songs HAVING album like "%Kabir%";

# -------------------------------------------------------------------------------------------
#                                   FLOW OF QUERYING
#                                                                                  
#            SELECT -> FROM -> WHERE -> GROUP BY -> HAVING -> ORDER BY                                                                         
#                                                                                       
# -------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------

#                      Calculated Columns (IF, CASE, YEAR, CURYEAR)

# -------------------------------------------------------------------------------------------

## lets say we have to calculate a few things
# like what is the average age of an artist in pop songs
# who is the youngest actor in Punjabi Pop culture

## so to get current age ====>> Current date(year) - Birthdate(year)

SELECT * FROM artists;

## let do that , see we got the age

SELECT * , YEAR(curdate()) - birth_year as age FROM artists;


## lets move to financials

SELECT * FROM financials;

# profit = revenue - budget , lets do that

SELECT * , (revenue - budget) as profit FROM financials;


# Now say we want to print the revenue in single currency because we have INR and USD
# units also we have million , billion , thousands

# USD ---> INR = 80 ratio , new column we will have revenue INR

SELECT * , 
IF(currency = 'USD' , revenue * 80 , revenue) as revenue_inr 
FROM financials;


# now lets convert all the units into MILLIONS
# 1 BILLION = 1000 MILLION   <--conversion--> n*1000
# 1 MILLION = 1000 THOUSANDS <--conversion--> n/1000

# lets select unique units first
SELECT 
DISTINCT unit 
FROM financials;


# now lets finally convert all the units into MILLIONS
SELECT *, 
       CASE
           WHEN unit = 'thousands' THEN revenue / 1000  
           WHEN unit = 'billions'   THEN revenue * 1000 
           WHEN unit = 'millions'   THEN revenue 
       END AS revenue_mln
FROM financials;