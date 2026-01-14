/* ===========================================
   Table: Film_Actor
   Purpose: Exploratory checks and data validation
   Note: No cleaning performed on this table; only SELECT queries.
================================================== */
-- Count appearances of actor_id = 1
select count(*) 
from film_actor
 where actor_id = 1;
 
-- Check for invalid actor references
select f.actor_id from film_actor f 
join actor a on f.actor_id=a.actor_id 
where a.actor_id is null;

--  Check for invalid film references
select f.film_id from film_actor f
 join film a on f.film_id=f.film_id 
 where a.film_id is null;