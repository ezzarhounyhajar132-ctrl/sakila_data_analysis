/* =====================================================
   Table: city
   Description: Cleaning, standardization, and validation
   ===================================================== */
-- Inspect table structure
describe city;

-- Create a staging table
create table city_tab
 like city;
insert into city_tab 
select * from city;
 
 -- Identify records with missing critical values
SELECT * FROM city
WHERE city IS NULL OR country_id IS NULL;

-- Remove leading and trailing spaces from city names
update city_tab 
set city=trim(city);

-- Standardize city names 
update city_tab
set city=concat(ucase(left(city,1)),lcase(substring(city,2)));

-- Identify city records with country_id not present in the country table
select t.country_id 
from city t left join country c
 on t.country_id=c.country_id 
where c.country_id is null;
