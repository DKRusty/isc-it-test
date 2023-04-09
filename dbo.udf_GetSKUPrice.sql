CREATE FUNCTION dbo.udf_GetSKUPrice(@ID_SKU int)
RETURNS decimal(18, 2)
AS
BEGIN
    DECLARE @res decimal(18, 2);
    SELECT @res = SUM(b.Quantity)/SUM(b.value)   
    FROM dbo.Basket b
    WHERE b.ID_SKU = @ID_SKU;
     IF (@res IS NULL)
        SET @res = 0;
    RETURN @res;
END;