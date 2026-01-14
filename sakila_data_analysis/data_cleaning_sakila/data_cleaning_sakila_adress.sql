/* =====================================================
   Table: Address
   Description: Cleaning, standardization, and validation
   ===================================================== */
-- Inspect distinct address records
select distinct * from address;

-- Create a staging table
create table tab_address 
like address;

 insert into tab_address 
 select*from address;
 
 -- Identify empty or null values in address2 column
 SELECT COUNT(*) AS total_rows,
       SUM(CASE WHEN `address2` IS NULL OR TRIM(`address2`) = '' THEN 1 ELSE 0 END) AS empty_rows
FROM tab_address;

-- Drop address2 due to high null ratio and low analytical value
alter table tab_address 
drop column address2;

-- Remove leading and trailing spaces 
update tab_address 
set address=trim(address),
 district=trim(district),
 phone=trim(phone),
 postal_code=trim(postal_code);

-- Standardize address and district casing
update tab_address 
set address=concat(ucase(left(address,1)),lcase(substring(address,2))),
 district=concat(ucase(left(district,1)),lcase(substring(district,2)));
 
 -- Normalize spacing within address values
UPDATE tab_address
SET address = REGEXP_REPLACE(address, '\\s+', ' ');

-- Identify potential duplicate address records
with tab_address_pro as (
select*, row_number() over(partition by address, district,city_id,postal_code,phone) as num_row 
from tab_address)
select * from tab_address_pro where num_row>1;

-- Delete records where all major fields are missing
delete from tab_address 
where (address is null or trim(address)='')
and (district is null or trim(district)='')
and (city_id is null or trim(city_id)='')
and (postal_code is null or trim(postal_code)='')
and (phone is null or trim(phone)='');

-- Remove non-numeric characters from phone numbers
UPDATE tab_address
SET phone = REGEXP_REPLACE(phone, '[^0-9]', '');

-- Analyze phone number length distribution
SELECT LENGTH(phone) AS digits, COUNT(*) AS count
FROM tab_address
WHERE phone is not null
group by LENGTH(phone)
order by digits;

-- Modify phone column to support cleaned values
alter table tab_address
 modify phone varchar(20) null;

-- Set invalid phone numbers to NULL
update tab_address
 set phone = null 
 where phone='' or phone is null or length(phone) < 9;
 
 -- Normalize empty postal codes
update tab_address 
set postal_code = null
where postal_code='' or postal_code is null;

-- Analyze postal code length distribution
select length(postal_code) as pos, count(*)as count
 from tab_address 
 group by length(postal_code) 
 order by pos;

-- Standardize invalid postal codes
update tab_address 
set postal_code= null
where length( postal_code )<> 5;

-- Identify records
select * from tab_address 
where city_id is null or city_id='';

-- Detect city_id values not present in the city table
SELECT a.city_id
FROM tab_address a
LEFT JOIN city c ON a.city_id = c.city_id
WHERE c.city_id IS NULL;

