create table dbo.SKU 
(ID int identity (1,1) not null,
Code  AS concat('s',ID) unique , 
Name varchar(30) not null,
CONSTRAINT PK_SKU PRIMARY KEY(ID));


create table dbo.Family 
(ID int identity not null, 
SurName varchar(30) not null, 
BudgetValue money,
CONSTRAINT PK_FAMILY PRIMARY KEY(ID));

create table dbo.Basket
(ID int identity not null,
ID_SKU int FOREIGN KEY REFERENCES dbo.SKU(ID),
ID_Family int FOREIGN KEY REFERENCES dbo.Family(ID),
Quantity numeric(100,2) CHECK(Quantity > 0.00),
Value numeric(100,2)  CHECK(Value > 0.00),
PurchaseDate datetime DEFAULT(SYSDATETIME()),
DiscountValue numeric(100,2) );