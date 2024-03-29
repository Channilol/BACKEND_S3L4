USE [AutoEpicode]
GO
/****** Object:  Table [dbo].[ListaPreventivi]    Script Date: 15/02/2024 16:41:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ListaPreventivi](
	[IdPreventivo] [int] IDENTITY(1,1) NOT NULL,
	[IdMacchina] [int] NOT NULL,
	[Cliente] [varchar](50) NOT NULL,
	[Garanzia] [money] NOT NULL,
 CONSTRAINT [PK_ListaPreventivi] PRIMARY KEY CLUSTERED 
(
	[IdPreventivo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ListaPreventivi]  WITH CHECK ADD  CONSTRAINT [FK_ListaPreventivi_ListaMacchine] FOREIGN KEY([IdMacchina])
REFERENCES [dbo].[ListaMacchine] ([Id])
GO
ALTER TABLE [dbo].[ListaPreventivi] CHECK CONSTRAINT [FK_ListaPreventivi_ListaMacchine]
GO
