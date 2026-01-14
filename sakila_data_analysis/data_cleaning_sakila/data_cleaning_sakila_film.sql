 /* =====================================================
   Table: film
   Description: Cleaning, standardization, and validation
   ===================================================== */
-- Inspect table structure
describe film;

-- Create a staging table
create table film_tab
 like film;

insert into film_tab 
select*from film;

-- Trim whitespace from text fields
update film_tab 
set title= trim(title), 
`description`= trim(`description`),
 special_features = trim(special_features);
 
 -- Capitalize first letter for title and special_features
 update film_tab
 set title= concat(ucase(left(title,1)),lcase(substring(title,2))),
 special_features= concat(ucase(left(special_features,1)),lcase(substring(special_features,2)));

-- Identify Missing Data
 SELECT 
    SUM(title IS NULL) AS missing_title,
    SUM(description IS NULL) AS missing_description,
    SUM(release_year IS NULL) AS missing_year,
    SUM(language_id IS NULL) AS missing_language
FROM film;

-- Replace missing descriptions with default text
 update film_tab
 set description = 'no description' 
 where description is null or description ='';
 
 -- Remove films with missing titles 
 delete from film_tab 
 where title is null or title ='';
 
 -- Identify Duplicate Titles
 with title_dup as (
 select*, row_number() over(partition by title) as title_tab from film_tab
 )select * from title_dup where title_tab >1;
  
  -- Basic statistics on film length
 select min(length),
 max(length),
 avg(length) 
 from film_tab;
 
 -- Check for unrealistic release years
 select* from film_tab 
 where release_year <1900;
 
 -- Films with unexpected language_id
 select * from film_tab 
 where language_id <>1;
 
 -- Films with original language specified
 select * from film_tab 
 where original_language_id is not null;
 
 -- Drop unnecessary column
 alter table film_tab 
 drop column original_language_id;

-- Replace missing or empty ratings with default 'PG'
update film_tab
set rating='PG'
where rating is null or rating='';

