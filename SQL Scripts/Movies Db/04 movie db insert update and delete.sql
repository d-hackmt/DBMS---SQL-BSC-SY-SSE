## lets learn inserting in the existing tables 

-- ----------------------------------------------------



# lets say i want to update the movies table

select * from movies;

##lets decode it first how it looks 

INSERT INTO `movies_db_demo`.`movies` (`movie_id`, `title`,
 `industry`, `release_year`, 
 `imdb_rating`, `studio`,`language_id`) VALUES 
 ('141', 'Divesh The professor',
 'Symbiwood', 2025, 
 '9.9', 'SSE productions', '1');


## lets write it owr way

INSERT INTO movies
values ('141', 'Divesh The professor',
		'Symbiwood', 2025, 
		'9.9', 'SSE productions', '1');


## this is also some way ,to insert only for specific records

INSERT INTO movies
		(title)
values 
		('Divesh The sir');

INSERT INTO movies
		(title , release_year , language_id)
values 
		('Divesh bro' , 2065 , 4);

## but if you pass only one value without 
# mentioning the column name , it will not work

INSERT INTO movies
values ('Divesh The sir');  -- see this wont work


-- --------------- lets do the right way
INSERT INTO movies
values (DEFAULT, 'Divesh The professor',
		NULL, NULL, 
		NULL, NULL, '1');
        
        
        
## but now see this magic , you only need to know
# inserting one records , 
# rest is all gonna be a peice of cake 


INSERT INTO movies
		(title , release_year , language_id)
values 
		('Divesh bro'   , 2065 , 1),
		('Divesh bro 2' , 2075 , 1),
		('Divesh bro 3' , 2085 , 1),
		('Divesh bro 4' , 2095 , 1);


# but you cant have conditons or insert 
# a record in existing records

INSERT INTO movies
(release_year)
values (2026)
where title like "Divesh The sir";

# so this above action which you tried to do 
# was updation and not insertion

-- ----------------------------------------------------

## lets learn inserting and updating the tables 

-- ----------------------------------------------------


## lets get the original query first

UPDATE `moviesdb`.`movies` 
SET `release_year` = 2030 
WHERE (`movie_id` = '142');


##lets write our version

UPDATE movies
SET release_year = 2030
where(movie_id = 143);

##lets update more columns now 

## lets looks have the original query first

UPDATE `moviesdb`.`movies` 
SET `release_year` = 2027, 
`studio` = 'SSE productions', 
`language_id` = '2' 
WHERE (`movie_id` = '142');

## lets see our way 

UPDATE movies
SET release_year = 2035 , 
studio = 'SSE productions', 
language_id = '2'
where(movie_id = 143);

## so yea its updating 

# now how to update multiple values at once



## original one , looks safe , 
# did you observe they are explicitly telling the id number 

UPDATE `moviesdb`.`movies` SET `industry` = 'Symbiwood' 
WHERE (`movie_id` = '142');

UPDATE `moviesdb`.`movies` 
SET `industry` = 'Symbiwood' WHERE (`movie_id` = '143');

## our version

## always first check the querya and the write the main query 

Select * from movies
where title like "%Divesh%";

UPDATE movies 
SET  industry = "Symbiwood"
where title like "%Divesh%";


# but using such queries are unsafe because it might mess up some time 
## so its always good to explicity give the id number


UPDATE movies 
SET  industry = "Symbiwood"
where movie_id in (138 , 139,140);

# so this is nice


-- ----------------------------------------------------

## lets learn deleting the tables or in the tables

-- ----------------------------------------------------

## lets see the original way

DELETE FROM `moviesdb`.`movies` 
WHERE (`movie_id` = '145');

## lets see the our way

DELETE FROM movies
WHERE (movie_id = 145);


DELETE FROM movies
WHERE movie_id in (146 , 147);


# lets see safe query first

SELECT *  FROM movies
WHERE title like "%divesh%";

DELETE FROM movies
WHERE title like "%divesh%";

# and thats how we do it ............

--                  ---    pEAcE  ---                            