CREATE TRIGGER dbo.TR_Basket_insert_update
ON dbo.basket  
AFTER INSERT   
as
with t1 (t_id,ct) 
as (select i.id_sku,count(i.id_sku) from inserted i
		group by i.id_sku)
update dbo.Basket 
set DiscountValue = case 
	when @@ROWCOUNT>=2 and t1.ct>=2 then b.value*0.05
	when @@ROWCOUNT>=2 and t1.ct<2 then b.value*0
	when @@ROWCOUNT<2  then b.value*0
	end from  dbo.Basket b,t1,inserted i 
where t1.t_id=b.id_sku
and b.value=i.value 
and b.DiscountValue=i.DiscountValue 
and i.id_sku=b.id_sku;