CREATE PROCEDURE dbo.usp_MakeFamilyPurchase
    @FamilySurName varchar(255)    
AS 
if exists (select surname from dbo.Family where surname = @FamilySurName)
begin
	with t1 (id_f,sVal) as 
		(select id_family,sum(b.Value)  
		from dbo.family f inner join dbo.Basket b
		on f.id=b.ID_Family
		where @FamilySurName=surname
		group by id_family)
		
		update dbo.family
		set BudgetValue = BudgetValue -t1.sVal 
		from dbo.family f inner join t1 
		on t1.id_f=f.id		
end
else 
begin
	raiserror('Family not found', 16, 1, @FamilySurName);
end