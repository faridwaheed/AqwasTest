/****** Object:  Table [dbo].[Category]    Script Date: 01/12/2019 01:11:55 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feeds]    Script Date: 01/12/2019 01:11:55 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feeds](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NOT NULL,
	[Link] [nvarchar](max) NULL,
	[CategoryId] [int] NOT NULL,
	[FeedDate] [date] NULL,
	[IsSubscribed] [bit] NULL,
 CONSTRAINT [PK_Feeds] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserFeeds]    Script Date: 01/12/2019 01:11:55 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserFeeds](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[FeedId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 01/12/2019 01:11:55 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](250) NOT NULL,
	[Username] [nvarchar](250) NOT NULL,
	[Password] [nvarchar](250) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([Id], [Name]) VALUES (1, N'General')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (2, N'Sport')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (3, N'Economy')
SET IDENTITY_INSERT [dbo].[Category] OFF
SET IDENTITY_INSERT [dbo].[Feeds] ON 

INSERT [dbo].[Feeds] ([Id], [Name], [Link], [CategoryId], [FeedDate], [IsSubscribed]) VALUES (1, N'Okaz', N'https://www.okaz.com.sa/rssFeed/0', 1, NULL, NULL)
INSERT [dbo].[Feeds] ([Id], [Name], [Link], [CategoryId], [FeedDate], [IsSubscribed]) VALUES (2, N'AlWatan', N'https://www.alwatan.com.sa/rssFeed/0', 1, NULL, 1)
INSERT [dbo].[Feeds] ([Id], [Name], [Link], [CategoryId], [FeedDate], [IsSubscribed]) VALUES (3, N'AlSharq AlAwsat', N'https://aawsat.com/feed', 1, NULL, NULL)
INSERT [dbo].[Feeds] ([Id], [Name], [Link], [CategoryId], [FeedDate], [IsSubscribed]) VALUES (4, N'WAS', N'https://www.spa.gov.sa/rss.xml', 1, NULL, NULL)
INSERT [dbo].[Feeds] ([Id], [Name], [Link], [CategoryId], [FeedDate], [IsSubscribed]) VALUES (6, N'Ajel', N'https://ajel.sa/rss', 1, NULL, 1)
INSERT [dbo].[Feeds] ([Id], [Name], [Link], [CategoryId], [FeedDate], [IsSubscribed]) VALUES (7, N'BBC', N'http://feeds.bbci.co.uk/arabic/rss.xml', 1, NULL, NULL)
INSERT [dbo].[Feeds] ([Id], [Name], [Link], [CategoryId], [FeedDate], [IsSubscribed]) VALUES (8, N'CNN', N'http://arabic.cnn.com/rss/cnnarabic_topnews.rss', 1, NULL, NULL)
INSERT [dbo].[Feeds] ([Id], [Name], [Link], [CategoryId], [FeedDate], [IsSubscribed]) VALUES (9, N'AlArabiya', N'https://www.alarabiya.net/.mrss/ar.xml', 1, NULL, 1)
INSERT [dbo].[Feeds] ([Id], [Name], [Link], [CategoryId], [FeedDate], [IsSubscribed]) VALUES (10, N'GoalCom', N'https://www.goal.com/feeds/ar/news', 2, NULL, NULL)
INSERT [dbo].[Feeds] ([Id], [Name], [Link], [CategoryId], [FeedDate], [IsSubscribed]) VALUES (11, N'AlArabiya Sport', N'https://www.alarabiya.net/.mrss/ar/sport.xml', 2, NULL, NULL)
INSERT [dbo].[Feeds] ([Id], [Name], [Link], [CategoryId], [FeedDate], [IsSubscribed]) VALUES (12, N'AlEqt', N'http://www.aleqt.com/feed/rss_section/aswaq', 3, NULL, NULL)
INSERT [dbo].[Feeds] ([Id], [Name], [Link], [CategoryId], [FeedDate], [IsSubscribed]) VALUES (13, N'CNBC Arabia', N'https://www.cnbcarabia.com/latest.rss', 3, NULL, NULL)
INSERT [dbo].[Feeds] ([Id], [Name], [Link], [CategoryId], [FeedDate], [IsSubscribed]) VALUES (14, N'Arabian Business', N'https://arabic.arabianbusiness.com/feed/context/news/feed.xml', 3, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Feeds] OFF
SET IDENTITY_INSERT [dbo].[UserFeeds] ON 

INSERT [dbo].[UserFeeds] ([Id], [UserId], [FeedId]) VALUES (2, 4, 12)
INSERT [dbo].[UserFeeds] ([Id], [UserId], [FeedId]) VALUES (3, 4, 2)
INSERT [dbo].[UserFeeds] ([Id], [UserId], [FeedId]) VALUES (4, 4, 6)
INSERT [dbo].[UserFeeds] ([Id], [UserId], [FeedId]) VALUES (5, 4, 9)
SET IDENTITY_INSERT [dbo].[UserFeeds] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Id], [Email], [Username], [Password]) VALUES (4, N'80:00:0B:44:61:D3', N'80:00:0B:44:61:D3', NULL)
SET IDENTITY_INSERT [dbo].[Users] OFF
ALTER TABLE [dbo].[Feeds]  WITH CHECK ADD  CONSTRAINT [FKCategory] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Feeds] CHECK CONSTRAINT [FKCategory]
GO
ALTER TABLE [dbo].[UserFeeds]  WITH CHECK ADD FOREIGN KEY([FeedId])
REFERENCES [dbo].[Feeds] ([Id])
GO
ALTER TABLE [dbo].[UserFeeds]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
/****** Object:  StoredProcedure [dbo].[GetUserFeeds]    Script Date: 01/12/2019 01:11:55 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[GetUserFeeds]
@userId int
AS
SELECT f.Id, f.Name,f.FeedDate FROM dbo.Feeds f INNER JOIN dbo.UserFeeds uf
ON f.Id=uf.FeedId WHERE uf.UserId=@userId
GO
/****** Object:  StoredProcedure [dbo].[SubscribedUserFeeds]    Script Date: 01/12/2019 01:11:55 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SubscribedUserFeeds]
@userId int,
@feedId int
AS
INSERT INTO dbo.UserFeeds
(
    UserId,
    FeedId
)
VALUES
(
  @userId, @feedId
)
GO
/****** Object:  StoredProcedure [dbo].[UpdateFeedsToBeSubscribed]    Script Date: 01/12/2019 01:11:55 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[UpdateFeedsToBeSubscribed]
@id int
AS 
UPDATE dbo.Feeds
SET
    dbo.Feeds.IsSubscribed = 1 -- bit
	WHERE dbo.Feeds.Id=@id
GO
