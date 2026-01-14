/* ===========================================
   Table: film_category
   Purpose: Exploratory checks and data validation
   Note: No cleaning performed on this table; only SELECT queries.
================================================== */
-- Inspect table structure
describe film_category;

-- Check for invalid film references
select c.film_id from film_category c left join  film f 
on c.film_id = f.film_id
where f.film_id is null;

-- Check for invalid category references
select f.category_id from film_category f left join category c
 on f.category_id= c.category_id 
where c.category_id is null;