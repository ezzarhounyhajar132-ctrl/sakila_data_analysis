 /* =====================================================
   Table:staff
   Description: Cleaning, standardization, and validation
   ===================================================== */
   -- Inspect table structure
describe staff;

-- create a staging table
create table staff_tab 
like staff;

insert into staff_tab 
select* from staff;

-- Trim whitespace from text fields
update staff_tab
set first_name= trim(first_name),
 last_name=trim(last_name),
 username=trim(username),
 email=trim(email);

-- Standardize title and description
update staff_tab
set first_name=concat(ucase(left(first_name,1)),lcase(substring(first_name,2))),
 last_name=concat(ucase(left(last_name,1)),lcase(substring(last_name,2))),
username=concat(ucase(left(username,1)),lcase(substring(username,2)));

-- Standardize email format
update staff_tab
set email=lower(concat(first_name,'.',last_name,'@sakilastaff.com'));