## lets learn inserting in the existing tables 

-- ----------------------------------------------------



# lets say i want to update the songs table

select * from songs;
--
##lets decode it first how it looks 

INSERT INTO `songs_db_demo`.`songs` (`song_id`, `title`,
 `genre`, `release_year`, 
 `spotify_rating`, `album`,`language_id`) VALUES 
 ('141', 'symbi radio',
 'Pop', 2025, 
 '9.9', 'SSE records', '1');


## lets write it owr way

INSERT INTO songs
values ('141', 'symbi radio',
 'Pop', 2025, 
 '9.9', 'SSE records', '1');


## this is also some way ,to insert only for specific records
# it gives error , language id is not by deafult

INSERT INTO songs
		(title, language_id)
values 
		('The professor' , 3);

INSERT INTO songs
		(title , release_year , language_id)
values 
		('The professor delux' , 2065 , 1);

## but if you pass only one value without 
# mentioning the column name , it will not work

INSERT INTO songs
values ('The professor');  -- see this wont work


-- --------------- lets do the right way
INSERT INTO songs
values (DEFAULT, 'The professor ft draps',
		NULL, NULL, 
		NULL, NULL, '1');
        
        
        
## but now see this magic , you only need to know
# inserting one records , 
# rest is all gonna be a peice of cake 


INSERT INTO songs
		(title , release_year , language_id)
values 
		('Divesh bro'   , 2065 , 1),
		('Divesh bro 2' , 2075 , 1),
		('Divesh bro 3' , 2085 , 1),
		('Divesh bro 4' , 2095 , 1);


# but you cant have conditons or insert 
# a record in existing records

INSERT INTO songs
(release_year)
values (2026)
where title like "Divesh bro 4";

# so this above action which you tried to do 
# was updation and not insertion

-- ----------------------------------------------------

## lets learn inserting and updating the tables 

-- ----------------------------------------------------


## lets get the original query first

UPDATE `songsdb`.`songs` 
SET `release_year` = 2030 
WHERE (`song_id` = '142');


##lets write our version

UPDATE songs
SET release_year = 2030
where(song_id = 143);

##lets update more columns now 

## lets looks have the original query first

UPDATE `songsdb`.`songs` 
SET `release_year` = 2027, 
`album` = 'SSE productions', 
`language_id` = '2' 
WHERE (`song_id` = '142');

## lets see our way 

UPDATE songs
SET release_year = 2035 , 
album = 'SSE mixers', 
language_id = '2'
where(song_id = 145);

## so yea its updating 

# now how to update multiple values at once


## original one , looks safe , 
# did you observe they are explicitly telling the id number 

UPDATE `songsdb`.`songs` SET `genre` = 'SSE-POP' 
WHERE (`song_id` = '142');

UPDATE `songsdb`.`songs` 
SET `genre` = 'Symbiwood' WHERE (`song_id` = '145');

## our version

## always first check the querya and the write the main query 

Select * from songs
where title like "%Divesh%";

UPDATE songs 
SET  genre = "techy"
where title like "%Divesh%";


# but using such queries are unsafe because it might mess up some time 
## so its always good to explicity give the id number


UPDATE songs 
SET  genre = "melodic"
where song_id in (81 , 82,141);

# so this is nice


-- ----------------------------------------------------

## lets learn deleting the tables or in the tables

-- ----------------------------------------------------

## lets see the original way

DELETE FROM `songsdb`.`songs` 
WHERE (`song_id` = '146');

## lets see the our way

DELETE FROM songs
WHERE (song_id = 146);


DELETE FROM songs
WHERE song_id in (142 , 145);


# lets see safe query first

SELECT *  FROM songs
WHERE title like "%divesh%";

DELETE FROM songs
WHERE title like "%divesh%";

# and thats how we do it ............

--                  ---    pEAcE  ---                            