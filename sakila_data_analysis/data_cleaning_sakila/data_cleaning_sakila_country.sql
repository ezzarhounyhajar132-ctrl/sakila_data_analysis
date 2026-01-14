/* =====================================================
   Table: country
   Description: Cleaning, standardization, and validation
   ===================================================== */
-- Inspect table structure
describe country;

-- Create a staging table
create table country_tab 
like country;

insert into country_tab
 select * from country;

 -- Identify records with missing critical values
select * from country 
where country is null or country='';

-- Remove leading and trailing spaces from country names
update country_tab
set country= trim(country);

-- Standardize country name for consistency
UPDATE country_tab
SET country = 'Democratic Republic of Congo'
WHERE country LIKE 'Congo, The Democratic Republic%';
 
 update country_tab 
 set country= concat(ucase(left(country,1)),lcase(substring(country, 1)));