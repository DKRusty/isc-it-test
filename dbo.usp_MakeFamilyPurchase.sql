CREATE PROCEDURE dbo.usp_MakeFamilyPurchase
    @FamilySurName varchar(255)    
AS 
If @FamilySurName in (select surname from dbo.family)
		update dbo.family
		set BudgetValue =(select f.BudgetValue-sum(b.Value)  
		from dbo.family f inner join dbo.Basket b
		on f.id=b.ID_Family
		where @FamilySurName=surname
		group by f.BudgetValue)
	where @FamilySurName=surname;
else 
	print 'Family not found';