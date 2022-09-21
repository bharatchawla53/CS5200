-- Question 2:
-- 2a) 3 databases are created by the script.
-- 2b) 1. ap database and tables that are created under it are: general_ledger_accounts, terms, vendors,
--        invoices, invoice_line_items, vendor_contacts, invoice_archive.
--     2. ex database and tables that are created under it are: null_sample, departments, employees, projects,
--        customers, color_sample, string_sample, float_sample, date_sample, active_invoices, paid_invoices.
--     3. om database and tables that are created under it are: customers, items, orders, order_details.
-- 2c) 68 records were inserted into the om.order_details by the script.
-- 2d) 114 records were inserted into the ap.invoices by the script.
-- 2e) 122 records were inserted into the ap.vendors by the script.
-- 2f) Yes, there is a foreign key between the ap.invoices and the ap.vendors table.
-- 2g) ap.vendors has 2 foreign keys to it.
-- 2h) customer_id is the primary key for the om.customers table.
-- 2i) Write a SQL command that will retrieve all values for all fields from the orders table
       select *
       from om.orders
-- 2j) Write a SQL command that will retrieve the fields: title and artist from the om.items table
       select title, artist
       from om.items


-- Question 5:
-- 5a) 11 tables are created by the script.
-- 5b) Tables that created under Chinook database are : Album, Artist, Customer,
--     Employee, Genre, Invoice, InvoiceLine, MediaType, Playlist, PlaylistTrack,
--     Track.
-- 5c) 347 records inserted into Album table.
-- 5d) AlbumId is the primary key for Album table.
-- 5e) Write a SQL SELECT command to retrieve all data from all columns and rows in the Artist table.
       select *
       from Chinook.Artist
-- 5f) Write a SQL SELECT command to retrieve the fields FirstName, LastName and Title from the Employee table
       select FirstName, LastName, Title
       from Chinook.Employee
