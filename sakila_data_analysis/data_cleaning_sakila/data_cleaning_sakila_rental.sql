 /* =====================================================
   Table: rental
   Description: Cleaning, standardization, and validation
   ===================================================== */
-- Inspect table structure
describe rental;

-- Check for invalid inventory references
select r.inventory_id 
from rental r
left join inventory i on r.inventory_id=i.inventory_id 
where i.inventory_id is null;

-- Check for invalid customer references
select r.customer_id 
from rental r 
left join customer i on r.customer_id=i.customer_id
where i.customer_id is null;

-- Check for invalid staff references
select r.staff_id
from rental r 
left join staff i on r.staff_id=i.staff_id 
where i.staff_id is null;

-- Identify Missing Data
select sum(rental_date is null) as rental_null,
sum(return_date is null) as null_return_date
from rental;

-- create a staging table
create table rental_tab
 like rental;

insert into rental_tab 
select * from rental;

-- Update NULL return_date values
UPDATE rental_tab
SET return_date = rental_date + INTERVAL 7 DAY
WHERE return_date IS NULL;
