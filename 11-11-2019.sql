
Use Training_19Sep19_Chennai
go

create schema [46009966]
go
create table [46009966].CarTable(
Id INT NOT NULL IDENTITY(1,1),
Model varchar(50) unique,
ManufacturerId int ,
TypeId int Foreign Key  (TypeId) REFERENCES [46009966].CISCarType(Id),
Engine varchar(50),
BHP int,
TransmissionId int Foreign Key  (transmissionId) REFERENCES [46009966].CISCarTransmissionType(Id),
Mileage int not null,
Seat int not null,
AirBagDetails varchar(20) not null,
BootSpace varchar(20) not null,
Price varchar(20) not null);
--foreign key

ALTER TABLE [46009966].CarTable  WITH CHECK 
ADD CONSTRAINT [FK_CIMSCar_ManufacturerId] FOREIGN KEY(ManufacturerId)
REFERENCES [46009966].ManufacturerTable (Id)
ON DELETE CASCADE
GO

insert into [46009966].CarTable   values('Maisto',1,1,'4.6L',60,1,45,4,'Driver & front seat','400L',50000);
insert into [46009966].CarTable   values('Presso',2,2,'5.6L',50,1,55,5,'Driver','500L',50000);
insert into [46009966].CarTable   values('Rover',3,3,'7.6L',40,2,65,5,'Driver','500L',50000);



select * from [46009966].CarTable


drop table [46009966].CarTable

drop table [46009966].ManufacturerTable

create  table [46009966].ManufacturerTable
(Id int primary key ,
ManufacturerName varchar(50) unique,
ContactPerson varchar(50) unique,
RegisteredOffice varchar(50) not null)

select * from [46009966].ManufacturerTable

create table [46009966].CarTypetable
(Id int primary key identity(1,1),
carType varchar(20) unique);

drop table [46009966].CarTypeTable


create table [46009966].CarTransmissionTable
(
Id int primary key identity(1,1),
TransmissionName varchar(20) unique);

drop table [46009966].CarTransmissionTable

CREATE SEQUENCE  ManufactureIdSeq AS INT
 START WITH 1
 INCREMENT BY 1
GO

drop proc [46009966].usp_InsertAdmin

create procedure [46009966].usp_InsertAdmin
(
	@Model varchar(50),
	@Engine varchar(50),
	@BHP int,
	@Mileage int,
	@Seat int,
	@AirBagDetails varchar(50),
	@BootSpace varchar(50),
	@Price int,
	@ManufacturerName varchar(50),
	@ContactPerson varchar(50),
	@RegisteredOffice varchar(50),
	@TypeId int,
	@TransmissionId int
)
As
begin
insert into [46009966].ManufacturerTable values (next value for ManufactureIdSeq,@ManufacturerName,@ContactPerson,@RegisteredOffice)
insert into [46009966].CarTable (Model,ManufacturerId,TypeId,Engine,BHP,TransmissionId,Mileage,Seat,AirBagDetails,BootSpace,Price) values (@Model,(select Id from [46009966].ManufacturerTable where @ManufacturerName=ManufacturerName),
@TypeId,@Engine,@BHP,@TransmissionId,@Mileage,@Seat,@AirBagDetails,@BootSpace,@Price) 
end 
GO 

exec [46009966].usp_InsertAdmin  @Model='R100',@Engine ='5.6L',@BHP=50,@Mileage=10,@Seat=4,@AirBagDetails='Driver',@BootSpace='400',@Price=1000,@ManufacturerName='Acad',@ContactPerson='Rao',@RegisteredOffice='Pune',@TypeId=1,@TransmissionId=1
exec [46009966].usp_InsertAdmin  @Model='D100',@Engine ='5.6L',@BHP=50,@Mileage=10,@Seat=4,@AirBagDetails='Driver',@BootSpace='400',@Price=1000,@ManufacturerName='Bricklin',@ContactPerson='Sachin',@RegisteredOffice='Chennai',@TypeId=1,@TransmissionId=1
exec [46009966].usp_InsertAdmin  @Model='E100',@Engine ='4.6L',@BHP=50,@Mileage=10,@Seat=4,@AirBagDetails='Driver',@BootSpace='400',@Price=1000,@ManufacturerName='Brooklin',@ContactPerson='STR',@RegisteredOffice='CHN',@TypeId=1,@TransmissionId=1

 select * from [46009966].CarTable;

 drop table [46009966].CISManufacturerTable

 insert into [46009966].ManufacturerTable values(next value for ManufactureIdSeq,'Audi','Kiran','Pune')
 insert into [46009966].ManufacturerTable values(next value for ManufactureIdSeq,'BMW','Raj','Mumbai')
 insert into [46009966].ManufacturerTable values(next value for ManufactureIdSeq,'Benz','Srikanth','Hyderabad')
 insert into [46009966].ManufacturerTable values(next value for ManufactureIdSeq,'Hyundai','Suresh','Bangalore')
 --insert into [46009966].ManufacturerTable values(5,'Suzuki','Ramesh','Chennai')
 -- insert into [46009966].ManufacturerTable values(6,'Volkswagon','Karthik','Vijayawada')

  select * from [46009966].CarTypetable;
 insert into [46009966].CarTypetable values ('HatchBack');
 insert into [46009966].CarTypetable values ('Sedan');
 insert into [46009966].CarTypetable values ('SUV');

 select * from [46009966].CarTransmissionTable;
 insert into [46009966].CarTransmissionTable values('Automatic');
 insert into [46009966].CarTransmissionTable values('Manual');

 DBCC DROPCLEANBUFFERS
GO
 create procedure [46009966].usp_deleteAdmin

	@Model varchar(50)

AS begin 
   DELETE FROM [46009966].ManufacturerTable WHERE Id IN
   (SELECT ManufacturerId FROM [46009966].CarTable WHERE Model = @Model ) 
   
delete from [46009966].CIMSCar where Model = @Model
end
go

drop procedure [46009966].usp_deleteAdmin

exec [46009966].usp_deleteAdmin 'B00'

create procedure [46009966].usp_Update_manuf(
@Model varchar(50),
@ManufacturerName varchar(50),
	@ContactPerson varchar(50),
	@RegisteredOffice varchar(50))
	as
begin
update  [46009966].ManufacturerTable
set ManufacturerName=@ManufacturerName,ContactPerson=@ContactPerson,RegisteredOffice=@RegisteredOffice
where Id=(select ManufacturerId from [46009966].CarTable where Model=@Model)
end

exec [46009966].usp_Update_manuf 'Egg','Sindhu','Iop','Pune'
create procedure [46009966].usp_Update_car(
@Model varchar(50),
	@Engine varchar(50),
	@BHP int,
	@Mileage int,
	@Seat int,
	@AirBagDetails varchar(50),
	@BootSpace varchar(50),
	@Price int,
	
	
	@TypeId int,
	@TransmissionId int)
	as
begin
update [46009966].CarTable	

set Engine=@Engine,BHP=@BHP,Mileage=@Mileage,Seat=@Seat,AirBagDetails=@AirBagDetails,BootSpace=@BootSpace,Price=@Price,TypeId=@TypeId,TransmissionId=@TransmissionId
where Model=@Model
end

exec [46009966].usp_Update_car 'Egg','5.4L',100,45,8,'Show','805L',4585,'2','1'
select * from [46009966].CarTable

create procedure [46009966].usp_UpdateAdmin
(
	@Model varchar(50),
	@Engine varchar(50),
	@BHP int,
	@Mileage int,
	@Seat int,
	@AirBagDetails varchar(50),
	@BootSpace varchar(50),
	@Price int,
	@ManufacturerName varchar(50),
	@ContactPerson varchar(50),
	@RegisteredOffice varchar(50),
	
	@TypeId int,
	@TransmissionId int
	
)
as
begin
update [46009966].CarTable	
set Engine=@Engine,BHP=@BHP,Mileage=@Mileage,Seat=@Seat,AirBagDetails=@AirBagDetails,BootSpace=@BootSpace,Price=@Price,TypeId=@TypeId,TransmissionId=@TransmissionId
where Model=@Model
update [46009966].ManufacturerTable
set ManufacturerName=@ManufacturerName,ContactPerson=@ContactPerson,RegisteredOffice=@RegisteredOffice
where Id=(select ManufacturerId from [46009966].CarTable where Model=@Model)
end

exec [46009966].usp_UpdateAdmin 'B100','5.2L',40,60, 5, 'Driver & front seat','500L',60000,'Boler','Lokes','Pune',2,2



create procedure [46009966].usp_GetCarTypeTable
as begin
 select * from [46009966].CarTypetable;
end

create procedure [46009966].usp_GetCartransmissionTable
as begin
 
 select * from [46009966].CarTransmissionTable;
end





exec [46009966].usp_SearchCarDetails 'B10'

create procedure [46009966].usp_SearchCarDetails
(
	@Model varchar(50)
)
As
begin
select x.Id as ModelId,x.Model,x.TypeId,x.TransmissionId,x.Engine,x.Price,x.AirBagDetails,x.Price,x.BootSpace,x.BHP,x.Mileage,x.Seat,y.Id as ManufacturerId,y.ManufacturerName,y.ContactPerson,y.RegisteredOffice from [46009966].CarTable x, [46009966].ManufacturerTable y 
where  x.Model =@Model and y.Id =x.ManufacturerId
end



create procedure [46009966].usp_SearchByTypeAdmin
(
	@ManufacturerName varchar(50),
	@CarType varchar(50)
)
As
Begin
select * from [46009966].CarTable FULL OUTER JOIN [46009966].ManufacturerTable  on ((ManufacturerId=(select Id from [46009966].ManufacturerTable where ManufacturerName=@ManufacturerName))and(TypeId=(select Id from [46009966].CarTypetable where carType=@CarType)))
where ManufacturerName=@ManufacturerName
end

exec [46009966].usp_SearchByTypeAdmin 'Anasuya','Hatchback'



alter procedure [46009966].usp_DisplayAll
As
begin
--select x.Id as Model_Id,x.Model,x.TypeId,z.carType,x.TransmissionId,q.TransmissionName,x.Engine,x.AirBagDetails,x.Price,x.BootSpace,x.BHP,x.Mileage,x.Seat,y.Id as ManufacturerId,y.ManufacturerName,y.ContactPerson,y.RegisteredOffice from [46009966].CarTable x, [46009966].ManufacturerTable y ,[46009966].CarTypetable z,[46009966].CarTransmissionTable q
--Order By x.Id

end

exec [46009966].usp_DisplayAllData

select * from [46009966].CarTypeTable
select * from [46009966].CarTable
select * from [46009966].ManufacturerTable
select * from [46009966].CarTransmissionTable


alter proc [46009966].usp_DisplayAllData
as
begin

select [46009966].CarTable.Id,Model as Model_Name,[46009966].CarTypeTable.carType,Engine,BHP,Mileage,Seat as Seats,AirBagDetails,BootSpace,Price, [46009966].CarTransmissionTable.TransmissionName, [46009966].ManufacturerTable.ManufacturerName  from [46009966].CarTable join [46009966].CarTypeTable on [46009966].CarTable.TypeId = [46009966].CarTypeTable.Id 
																																					join [46009966].CarTransmissionTable on [46009966].CarTable.TransmissionId = [46009966].CarTransmissionTable.Id
																																					join [46009966].ManufacturerTable on [46009966].CarTable.ManufacturerId = [46009966].ManufacturerTable.Id

end