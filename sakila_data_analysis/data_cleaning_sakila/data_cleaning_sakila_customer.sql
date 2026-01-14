 /* =====================================================
   Table: customer
   Description: Cleaning, standardization, and validation
   ===================================================== */
   -- Preview first 10 customer records
 select distinct* from customer limit 10;

-- create a staging table
create table customer_tab 
like customer;

insert into customer_tab 
select * from customer;

-- Identify records with missing or invalid critical fields
select* from customer_tab 
where store_id is null
or first_name is null or first_name =''
or last_name is  null or last_name =''
or email is null or email = ''
or address_id is null 
or `active`is null;

-- Replace NULL values in "active" column with '0'
update customer_tab 
set active = '0'
where active is null;

-- Trim whitespace from names and email
update customer_tab 
set first_name = trim(first_name),
    last_name= trim(last_name),
	email=trim(email);

-- Standardize first_name and last_name casing
update customer_tab
 set first_name= concat(ucase(left(first_name,1)),lcase(substring(first_name,2))),
last_name= concat(ucase(left(last_name,1)),lcase(substring(last_name,2)));

-- Standardize email format
update customer_tab 
SET email = LOWER(CONCAT(first_name, '.', last_name, customer_id, '@sakilacustomer.org'));

-- Identify customer records with invalid store_id
select c.store_id  from customer c 
left join store s on c.store_id=s.store_id 
where s.store_id is null;

-- Identify customer records with invalid address_id
select c.address_id from customer c 
left join address a on c.address_id= a.address_id 
where a.address_id is null;