USE ap;
-- 1. Get all invoices greater than the average invoice total

select *
from invoices i 
where invoice_total > (select avg(invoice_total) from invoices);

-- 2. Find all invoices for vendors from New Jersey. 
-- Provide the invoice number, invoice date and invoice total in the result
select invoice_number, invoice_date, invoice_total
from invoices i 
join vendors v on v.vendor_id = i.vendor_id
where v.vendor_state = 'NJ';


-- 3. Get all invoices amount that's greater than the vendor's average invoice total  
-- Provide the invoice number, invoice date and invoice total in the result

select invoice_number, invoice_date, invoice_total, avg_vendor
from invoices 
join  (
	select vendor_id, avg(invoice_total) as avg_vendor from invoices group by vendor_id) t 
    using (vendor_id)
    where invoice_total > avg_vendor;


-- 4. Get invoices that are larger than the largest invoice for vendor 34 

select * 
from invoices 
where invoice_total > 
(select max(invoice_total)
from invoices 
where vendor_id = 34);


-- 5. Get invoices that are smaller than any invoice for vendor 34 
select * 
from invoices 
where invoice_total <
(select min(invoice_total)
from invoices 
where vendor_id = 34);


-- 6. Use the EXISTS clause to find vendors without any invoices 
 select *
 from vendors
 where not exists (select * from invoices where invoices.vendor_id = vendors.vendor_id);
  
 
 -- 7. Get the largest invoice_total for each state 
select max(invoice_total)
from invoices