USE [AutoEpicode]
GO
/****** Object:  Table [dbo].[ListaOptionals]    Script Date: 15/02/2024 16:41:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ListaOptionals](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdPreventivo] [int] NOT NULL,
	[Optional] [int] NOT NULL,
 CONSTRAINT [PK_ListaOptionals] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ListaOptionals]  WITH CHECK ADD  CONSTRAINT [FK_ListaOptionals_ListaPreventivi] FOREIGN KEY([IdPreventivo])
REFERENCES [dbo].[ListaPreventivi] ([IdPreventivo])
GO
ALTER TABLE [dbo].[ListaOptionals] CHECK CONSTRAINT [FK_ListaOptionals_ListaPreventivi]
GO
ALTER TABLE [dbo].[ListaOptionals]  WITH CHECK ADD  CONSTRAINT [FK_ListaOptionals_Optionals] FOREIGN KEY([Optional])
REFERENCES [dbo].[Optionals] ([IdOptional])
GO
ALTER TABLE [dbo].[ListaOptionals] CHECK CONSTRAINT [FK_ListaOptionals_Optionals]
GO
