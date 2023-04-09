CREATE VIEW dbo.vw_SKUPrice 
AS 
select s.*, dbo.udf_GetSKUPrice(ID_SKU) as SKUPrice 
from dbo.SKU s inner join dbo.basket b on s.id=b.id_sku
where s.ID=b.ID_SKU
group by s.id,s.code,s.name,dbo.udf_GetSKUPrice(ID_SKU);