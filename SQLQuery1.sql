USE [Training_19Sep19_Pune]
GO

/****** Object:  Table [46008420].[Business]    Script Date: 11/7/2019 12:55:43 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING OFF
GO

CREATE TABLE [46008420].[Business](
	[BusinessId] [int] IDENTITY(1,1) NOT NULL,
	[FirmName] [varchar](50) NOT NULL,
	[ActivityNature] [varchar](50) NOT NULL,
	[FirmAddress] [varchar](50) NOT NULL,
	[OwnerName] [varchar](50) NOT NULL,
	[MobileNo] [varchar](20) NOT NULL,
	[EmailAddress] [varchar](40) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BusinessId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


