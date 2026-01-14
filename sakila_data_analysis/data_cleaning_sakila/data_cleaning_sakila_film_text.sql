 /* =====================================================
   Table: film_text
   Description: Cleaning, standardization, and validation
   ===================================================== */
-- create a staging table
create table film_text_tab 
like film_text;

insert into film_text_tab 
select * from film_text;

-- Trim whitespace from text fields
update film_text_tab 
set title = trim(title), description=trim(description);

-- Standardize title and description
update film_text_tab 
set title= concat(ucase(left(title,1)),lcase(substring(title,2))),
`description`=concat(ucase(left(`description`,1)),lcase(substring(`description`,2)));