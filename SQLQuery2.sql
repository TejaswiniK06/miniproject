USE [Training_19Sep19_Pune]
GO

/****** Object:  StoredProcedure [46008420].[SP_Business]    Script Date: 11/7/2019 12:56:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [46008420].[SP_Business]

@FirmName varchar(50),
@ActivityNature	varchar(50),
@FirmAddress varchar(50),
@OwnerName varchar(50),
@MobileNo varchar(50),
@EmailAddress varchar(50)
					
as
begin
insert into [46008420].Business values(@FirmName,@ActivityNature,@FirmAddress,@OwnerName,@MobileNo,@EmailAddress)
end

GO


