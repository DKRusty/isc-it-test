CREATE FUNCTION dbo.udf_GetSKUPrice(@ID_SKU int)
RETURNS decimal(18, 2)
AS
begin
    DECLARE @res decimal(18, 2);
	DECLARE @sum decimal(18, 2);
	set @sum=(select SUM(b.value)  
    FROM dbo.Basket b
    WHERE b.ID_SKU = @ID_SKU)
	IF @sum=0
	begin
	select @res=0 FROM dbo.Basket b
    WHERE b.ID_SKU = @ID_SKU
	end
	else
	begin
    SELECT @res = SUM(b.Quantity)/SUM(b.value)  
    FROM dbo.Basket b
    WHERE b.ID_SKU = @ID_SKU
	end
end;