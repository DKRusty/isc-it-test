CREATE FUNCTION dbo.udf_GetSKUPrice(@ID_SKU int)
RETURNS decimal(18, 2)
AS
BEGIN
    DECLARE @res decimal(18, 2);
    SELECT @res = isnull(SUM(b.Quantity)/SUM(b.value),0)   
    FROM dbo.Basket b
    WHERE b.ID_SKU = @ID_SKU;
    RETURN @res;
END;