/* =====================================================
   Table: category
   Description: Cleaning, standardization, and validation
   ===================================================== */
-- Inspect distinct category records
select distinct * from category;

-- Create a staging table
create table category_tab 
like category;
insert into category_tab 
select* from category;

-- Remove leading and trailing spaces from category names
update category_tab 
set name = trim(name);

-- Standardize category names
update category_tab
set name= concat(ucase(left(name,1)),LCASE(substring(name,2)));

-- Update last_update to the current timestamp
update category_tab 
set last_update =now();
