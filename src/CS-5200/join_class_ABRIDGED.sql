-- Review UNION and JOIN
-- OUTER JOIN (LEFT, RIGHT)
-- NESTED QUERIES 
-- these operations allows us to gather information from multiple tables 

 use AP;

-- UNION allows you to glue the results of 2 or more SQL SELECT commands together
-- example
-- retrieve all vendor_ids in the ap database.

 
 -- JOIN
 -- Many times, the data you want in your result is in multiple tables.
-- The JOIN operation allows you to retrieve data from multiple tables and put semantic restrictions 
-- on the result tuples when needed.
-- It is typically considered analogous to multiplication since 
-- if table A has m tuples and table B has n tuples, A JOIN B can have as many as m*n tuples. 
-- There are two different syntaxes for  expressing a JOIN: the implicit join and the explicit join.
-- The implicit join is the older method for expressing a join and is not used in industry

-- Last week you saw different syntaxes for JOIN as well as different variations of JOIN 
-- We are focused on the explicit INNER JOIN 

-- JOIN between the vendors and the invoices table
-- explicit join syntax 
-- SELECT select_list
-- FROM table_1
--    [INNER] JOIN table_2
 --      ON join_condition_1
 --  [[INNER] JOIN table_3
 --       ON join_condition_2]...
 
 l
  
  -- verification of the results by counting records 
S
  
  -- add as many tables as I need to get the results I want 

  
-- check the number of tuples returned 

-- We can add as many tables as we need 
 
 

 -- example of a self join 
-- sometimes the data you want to JOIN is in the same table 
-- for example what if we wanted to identify vendors in the same city 
-- must use table aliases to distinguish the two copies of the same table 
-- each field needs to be prefixed with the table name for disambiguation



-- An OUTER JOIN allows you to specify one of the tables as always contributing to the result. 
-- show Venn diagram for an OUTER JOIN 
-- Example of an OUTER JOIN 
-- OUTER keyword is optional 
-- There are 2 types of OUTER JOINS: LEFT OUTER JOIN and RIGHT OUTER JOIN. 
-- LEFT OUTER JOIN specifies that the tuples in the table to the LEFT of the JOIN keyword always contributes to the result. 
-- RIGHT OUTER JOIN specifies that the tuples in the table to the RIGHT of the JOIN keyword always contributes to the result
 -- SELECT select_list
-- FROM table_1
   --  {LEFT|RIGHT} [OUTER] JOIN table_2
    --     ON join_condition_1
  --  [{LEFT|RIGHT} [OUTER] JOIN table_3
   --      ON join_condition_2]...
   -- want to report on the vendors for an invoice BUT you also want report on ALL vendors 
  

-- Aggregation with an OUTER JOIN
-- Example of an OUTER JOIN - 

      
-- find all vendors whose sum is NULL

   


      
-- ALSO YOU can mix the types of JOINS you want.  One query can have NATURAL, OUTER, and INNER JOINs within it. 
-- Let’s say you want to retrieve for each vendor the description of the terms used.


-- NESTED QUERIES 
-- what if you wanted invoices above the average invoice??
-- I want to write 
-- SELECT invoice_id, invoice_total FROM invoices 
  -- WHERE invoice_total > ?????
-- you know how to write a query to find the average value for a column 

SELECT avg(invoice_total) FROM invoices;
-- this returns a number - I want to use this number when filtering my invoices
-- we can use the query as a subquery in a query 
-- Find invoices above the average 


-- what if you want the vendor_name as well
-- we need a JOIN 
-- Find invoices above the average report the vendor_name and the invoice_id 


  -- Here we introduce a subquery in the WHERE clause 
  
  
-- How do you think a query like this is implemented by the DBMS? 
-- It computes the subquery then use that value in the outer query 
-- 1. get the value for : SELECT avg(invoice_total) FROM invoices - call it x.
-- 2. run the outer query with x : SELECT invoice_id, invoice_total WHERE onvoice_total > x;
-- This is known as an uncorrelated query. The subquery is run only once for the outer query. 


-- This is an example of a nested query 
-- In SQL we can place a subquery in the following places
-- In a WHERE clause as a search condition
-- In a HAVING clause as a search condition
-- In the FROM clause as a table specification
-- In the SELECT clause as a column specification


-- The above example has the subquery in the WHERE clause
-- SUBQUERIES ARE ALWAYS SURROUNDED BY PARENTHESES  
-- A subquery can return a single value, a list of values or a table of values.
-- A subquery may contain other subqueries. 

  
  
-- A common way to introduce a query in the WHERE clause is with the IN OPERATOR
-- example: find all invoices for Californian vendors

-- query should return only 1 field 

  
  -- can use more than 1 field for matching with IN 
  
  
  
-- example of a nested query in the SELECT clause
-- you want to report the average invoice for each vendor 
-- first show average across all vendors
use ap;


-- more useful to report the average per vendor as oppose to across all invoices 

-- this is a correlated query the inner query is run for each tuple in the outer query

-- This nested query can be rewritten as a JOIN
-- we still need to nest since we need to compute the average for each vendor 



-- Can you think of another way to write the same query? 

 
  
-- More complicated nested query 
-- nested queries find all vendors whose invoices total is above the average for all vendors 
-- break up into steps compute the average for all vendors
-- 1. first need to find the total amount for each vendor
-- 2. Compute the average across all vendors 
-- 3. Use this average to filter the result from query 1. 


-- want to compute the average of these values 
-- I create a nested query where the FROM is this query result 
-- here we introduce the subquery in the FROM clause 


-- Here WE Introduce a query in the FROM clause as well as the HAVING clause       

      
-- If this seems a bit redundant to you you can also express the query
-- using a common table expression 
-- this way the duplicated subquery is not written in the query twice

  
  
  -- CREATE A TABLE FROM THE RESULT OF A QUERY
  


-- sometimes there is a disconnect between the return values from the subquery and the outer query

  -- ANY, ALL 
  
  -- generates an error since the outer query needs one value for the comparison instead of a list of values 
 
    
    -- ALL WILL RETURN TRUE IF THE CONDITION IS MET FOR ALL VALUES FROM THE SUBQUERY

    
    
 --   With a correlated query the inner query has access to the field values in the outer query. 
 -- For each tuple in the outer query the inner query is computed.  
 -- A correlated query is comparable to executing a loop in a host language.

    -- EXISTS and NOT EXISTS 
    -- SOMETIMES YOU DO NOT CARE WHAT THE VALUES ARE IN THE DATABASE YOU ARE ONLY CONCERNED
    -- WITH THE EXISTENCE OF THE RESULT IN THE DB
    -- IF THIS IS TRUE CAN USE not exists or exists 
    
 
      
      -- Negate it to find the vendors without invoices 
      

-- EXAMPLE OF A CORRELATED QUERY 

-- We do have other SET OPERATIONS IN SQL
-- We do not have a keyword for INTERSECTION but we do have many ways to simulate INTERSECTION in MySQL. 
-- The simplest is the IN operator or with an INNER JOIN. We will look at other methods when we review subqueries.

-- SET DIFFERENCE we do not have a keyword for SET DIFFERENCE but we do have many ways to simulate SET DIFFERENCE in MySQL. 
-- The simplest in the NOT IN operator or with an OUTER JOIN. We will look at other methods when we review subqueries. 