CREATE TRIGGER dbo.TR_Basket_insert_update
ON dbo.basket  
AFTER INSERT   
AS 
if @@ROWCOUNT>=2 
begin
		update dbo.Basket 
		set DiscountValue=b.value*0.05 from  dbo.Basket b,inserted i
		where b.id_sku in (select distinct i.id_sku from inserted i
		group by i.id_sku
		having count(i.id_sku)>=2) 
		and b.value=i.value 
		and b. DiscountValue=i. DiscountValue 
		and i.id_sku=b.id_sku
		update dbo.Basket
		set DiscountValue=b.value*0 from  dbo.Basket b,inserted i
		where b.id_sku in (select distinct i.id_sku from inserted i
		group by i.id_sku 
		having count(i.id_sku)<2) 
		and b.value=i.value 
		and b. DiscountValue=i. DiscountValue 
		and i.id_sku=b.id_sku
	end
else 
	begin
		update dbo.Basket
		set DiscountValue=b.value*0 from  dbo.Basket b,inserted i
		where b.id_sku in (select distinct i.id_sku from inserted i
		group by i.id_sku
		having count(id_sku)<2) 
		and b.value=i.value 
		and b. DiscountValue=i.DiscountValue 
		and i.id_sku=b.id_sku
end;