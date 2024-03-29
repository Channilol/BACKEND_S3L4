USE [AutoEpicode]
GO
/****** Object:  Table [dbo].[ListaMacchine]    Script Date: 15/02/2024 16:41:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ListaMacchine](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Brand] [varchar](50) NOT NULL,
	[Modello] [varchar](100) NOT NULL,
	[Prezzo] [money] NOT NULL,
	[Image] [varchar](500) NOT NULL,
 CONSTRAINT [PK_ListaMacchine] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
