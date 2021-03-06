USE [master]
GO
/****** Object:  Database [ProjectZ]    Script Date: 13/10/20 12:04:21 ******/
CREATE DATABASE [ProjectZ]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ProjectZ', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\ProjectZ.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ProjectZ_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\ProjectZ_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ProjectZ] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ProjectZ].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ProjectZ] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ProjectZ] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ProjectZ] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ProjectZ] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ProjectZ] SET ARITHABORT OFF 
GO
ALTER DATABASE [ProjectZ] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ProjectZ] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ProjectZ] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ProjectZ] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ProjectZ] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ProjectZ] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ProjectZ] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ProjectZ] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ProjectZ] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ProjectZ] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ProjectZ] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ProjectZ] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ProjectZ] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ProjectZ] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ProjectZ] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ProjectZ] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ProjectZ] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ProjectZ] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ProjectZ] SET  MULTI_USER 
GO
ALTER DATABASE [ProjectZ] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ProjectZ] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ProjectZ] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ProjectZ] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [ProjectZ] SET DELAYED_DURABILITY = DISABLED 
GO
USE [ProjectZ]
GO
/****** Object:  Table [dbo].[FavouriteProducts]    Script Date: 13/10/20 12:04:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FavouriteProducts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK_FavouriteProducts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Groups]    Script Date: 13/10/20 12:04:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Groups](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GroupName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Groups] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Images]    Script Date: 13/10/20 12:04:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Images](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](32) NOT NULL,
	[Extension] [nvarchar](10) NOT NULL,
	[Path] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_ProductImages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductBalance]    Script Date: 13/10/20 12:04:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductBalance](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NOT NULL,
	[Balance] [int] NOT NULL,
 CONSTRAINT [PK_ProductBalance] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 13/10/20 12:04:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[MtMeasureUnit] [int] NOT NULL,
	[Price] [smallmoney] NOT NULL,
	[MtGroup] [int] NOT NULL,
	[ImageId] [int] NULL,
 CONSTRAINT [PK_Goods] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sales]    Script Date: 13/10/20 12:04:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sales](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SDate] [date] NOT NULL,
	[SDocNumber] [int] NOT NULL,
	[CustomerId] [int] NOT NULL,
	[City] [nvarchar](50) NULL,
	[Street] [nvarchar](50) NULL,
	[PostalCode] [nvarchar](4) NULL,
	[Appartment] [nvarchar](50) NULL,
	[MtId] [int] NOT NULL,
	[MtQty] [int] NOT NULL,
	[MtPrice] [smallmoney] NOT NULL,
	[Comment] [nvarchar](250) NULL,
 CONSTRAINT [PK_Sales] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TopicComments]    Script Date: 13/10/20 12:04:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TopicComments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[TopicId] [int] NOT NULL,
	[Comment] [nvarchar](max) NOT NULL,
	[CommentDate] [datetime] NOT NULL,
 CONSTRAINT [PK_TopicComments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Topics]    Script Date: 13/10/20 12:04:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Topics](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](250) NOT NULL,
	[Text] [nvarchar](max) NOT NULL,
	[ImageId] [int] NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastEditDate] [datetime] NOT NULL,
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK_Topics] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserCart]    Script Date: 13/10/20 12:04:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserCart](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[Result] [bit] NULL,
 CONSTRAINT [PK_UserCart] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserCartProducts]    Script Date: 13/10/20 12:04:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserCartProducts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserCartId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Qty] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_UserCartProducts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 13/10/20 12:04:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](128) NOT NULL,
	[City] [nvarchar](50) NULL,
	[Street] [nvarchar](50) NULL,
	[PostalCode] [nvarchar](4) NULL,
	[Appartment] [nvarchar](50) NULL,
	[IsAdministrator] [bit] NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastEditionDate] [datetime] NOT NULL,
	[LastLoginDate] [datetime] NULL,
 CONSTRAINT [PK_UserConfirmed] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserToConfirm]    Script Date: 13/10/20 12:04:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserToConfirm](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](128) NOT NULL,
	[City] [nvarchar](50) NULL,
	[Street] [nvarchar](50) NULL,
	[PostalCode] [nvarchar](4) NULL,
	[Appartment] [nvarchar](50) NULL,
	[ConfirmationCode] [nvarchar](32) NOT NULL,
	[IsAdministrator] [bit] NULL,
	[CreationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_UserToConfirm] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[FavouriteProducts] ON 

INSERT [dbo].[FavouriteProducts] ([Id], [ProductId], [UserId]) VALUES (8, 26, 5)
INSERT [dbo].[FavouriteProducts] ([Id], [ProductId], [UserId]) VALUES (9, 26, 1)
INSERT [dbo].[FavouriteProducts] ([Id], [ProductId], [UserId]) VALUES (10, 31, 1)
SET IDENTITY_INSERT [dbo].[FavouriteProducts] OFF
GO
SET IDENTITY_INSERT [dbo].[Groups] ON 

INSERT [dbo].[Groups] ([Id], [GroupName]) VALUES (1, N'ძაღლი')
INSERT [dbo].[Groups] ([Id], [GroupName]) VALUES (2, N'კატა')
INSERT [dbo].[Groups] ([Id], [GroupName]) VALUES (3, N'მღრღნელი')
SET IDENTITY_INSERT [dbo].[Groups] OFF
GO
SET IDENTITY_INSERT [dbo].[Images] ON 

INSERT [dbo].[Images] ([Id], [Name], [Extension], [Path]) VALUES (9, N'b3afb6d39def46089669ba76c70c5639', N'.jpg', N'/Content/images/')
INSERT [dbo].[Images] ([Id], [Name], [Extension], [Path]) VALUES (17, N'cccd7f01ce304974be9a844b194a1fa6', N'.jpg', N'/Content/images/')
INSERT [dbo].[Images] ([Id], [Name], [Extension], [Path]) VALUES (18, N'7b0fa7259a5c4eeeb79250726f17ce46', N'.jpg', N'/Content/images/')
INSERT [dbo].[Images] ([Id], [Name], [Extension], [Path]) VALUES (19, N'0930fd2dd9a74c44bd4573c9b6fb90ee', N'.jpg', N'/Content/images/')
INSERT [dbo].[Images] ([Id], [Name], [Extension], [Path]) VALUES (20, N'4680da73cf6c4b3b8da8b2412f789277', N'.jpg', N'/Content/images/')
INSERT [dbo].[Images] ([Id], [Name], [Extension], [Path]) VALUES (21, N'd6b4bb40df854271bb6cabcd9c39438c', N'.jpg', N'/Content/images/')
INSERT [dbo].[Images] ([Id], [Name], [Extension], [Path]) VALUES (22, N'4887bd6da8e64da7904b97cfa9ac9cce', N'.jpg', N'/Content/images/')
INSERT [dbo].[Images] ([Id], [Name], [Extension], [Path]) VALUES (23, N'54da3a0071c4460a899e1d6ded85a085', N'.jpg', N'/Content/images/')
INSERT [dbo].[Images] ([Id], [Name], [Extension], [Path]) VALUES (24, N'2d88df1d27b946ca9e31b170ecdb7007', N'.jpg', N'/Content/images/')
INSERT [dbo].[Images] ([Id], [Name], [Extension], [Path]) VALUES (25, N'46e9f7478c45444594fa62a56d91dfb9', N'.jpg', N'/Content/images/')
INSERT [dbo].[Images] ([Id], [Name], [Extension], [Path]) VALUES (26, N'87ee4aa112074e62adfa729c7c5f5136', N'.jpg', N'/Content/images/')
INSERT [dbo].[Images] ([Id], [Name], [Extension], [Path]) VALUES (27, N'6f11b45e46404d98813d34ec4d52f1a5', N'.jpg', N'/Content/images/')
INSERT [dbo].[Images] ([Id], [Name], [Extension], [Path]) VALUES (28, N'6616530eeb2d4b8e839d58b77bdb3830', N'.jpg', N'/Content/images/')
INSERT [dbo].[Images] ([Id], [Name], [Extension], [Path]) VALUES (29, N'1cc8eca2dc0247ae9cd9237c6d8fb8c1', N'.jpg', N'/Content/images/')
INSERT [dbo].[Images] ([Id], [Name], [Extension], [Path]) VALUES (30, N'e862fb1ef9a048e38b9be96e2dc0249a', N'.jpg', N'/Content/images/')
INSERT [dbo].[Images] ([Id], [Name], [Extension], [Path]) VALUES (31, N'60351c4ec4614f1bb8206558a3e28fe6', N'.jpg', N'/Content/images/')
INSERT [dbo].[Images] ([Id], [Name], [Extension], [Path]) VALUES (32, N'694d91a302ea4d0d8ba21416ea6e8128', N'.jpg', N'/Content/images/')
INSERT [dbo].[Images] ([Id], [Name], [Extension], [Path]) VALUES (33, N'a772f2a771d647579bea349496cedcb5', N'.jpg', N'/Content/images/')
INSERT [dbo].[Images] ([Id], [Name], [Extension], [Path]) VALUES (34, N'7457f96dcb3d4ea090163fae182af743', N'.jpg', N'/Content/images/')
INSERT [dbo].[Images] ([Id], [Name], [Extension], [Path]) VALUES (35, N'486472f4418c4fff8f117c8222aa0aeb', N'.jpg', N'/Content/images/')
INSERT [dbo].[Images] ([Id], [Name], [Extension], [Path]) VALUES (36, N'7578eee2e7a24a2784ed2264eaa024a8', N'.jpg', N'/Content/images/')
INSERT [dbo].[Images] ([Id], [Name], [Extension], [Path]) VALUES (37, N'8abe84e5494b4f189236f6ba5d5e725a', N'.jpg', N'/Content/images/')
SET IDENTITY_INSERT [dbo].[Images] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Id], [Name], [Description], [MtMeasureUnit], [Price], [MtGroup], [ImageId]) VALUES (26, N'სათამაშო', N'რბილი სათამაშო', 0, 8.0000, 1, 17)
INSERT [dbo].[Products] ([Id], [Name], [Description], [MtMeasureUnit], [Price], [MtGroup], [ImageId]) VALUES (27, N'რბილი სათამაშო', N'ძაღლის რბილი სათამაშო', 0, 15.0000, 1, 18)
INSERT [dbo].[Products] ([Id], [Name], [Description], [MtMeasureUnit], [Price], [MtGroup], [ImageId]) VALUES (31, N'საკვები', N'პედიგრი', 0, 12.0000, 1, 20)
INSERT [dbo].[Products] ([Id], [Name], [Description], [MtMeasureUnit], [Price], [MtGroup], [ImageId]) VALUES (32, N'ფერადი ბურთი', N'სილიკონის ბურთი', 0, 15.0000, 2, 26)
INSERT [dbo].[Products] ([Id], [Name], [Description], [MtMeasureUnit], [Price], [MtGroup], [ImageId]) VALUES (33, N'სათამაშო საკვებით', N'საკვების ჩასაყრელი ბურთი', 0, 20.0000, 1, 27)
INSERT [dbo].[Products] ([Id], [Name], [Description], [MtMeasureUnit], [Price], [MtGroup], [ImageId]) VALUES (34, N'ფერადი ბურთები', N'სათამაშო ბურთები', 0, 14.0000, 3, 28)
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[Sales] ON 

INSERT [dbo].[Sales] ([Id], [SDate], [SDocNumber], [CustomerId], [City], [Street], [PostalCode], [Appartment], [MtId], [MtQty], [MtPrice], [Comment]) VALUES (13, CAST(N'2020-02-28' AS Date), 1, 1, N'თბილისი', N'ქიზიყის 7ბ', N'0182', N'15', 26, 1, 8.0000, NULL)
INSERT [dbo].[Sales] ([Id], [SDate], [SDocNumber], [CustomerId], [City], [Street], [PostalCode], [Appartment], [MtId], [MtQty], [MtPrice], [Comment]) VALUES (14, CAST(N'2020-03-06' AS Date), 2, 1, N'თბილისი', N'ქიზიყის 7ბ', N'0182', N'15', 26, 15, 8.0000, NULL)
INSERT [dbo].[Sales] ([Id], [SDate], [SDocNumber], [CustomerId], [City], [Street], [PostalCode], [Appartment], [MtId], [MtQty], [MtPrice], [Comment]) VALUES (15, CAST(N'2020-03-06' AS Date), 3, 1, N'თბილისი', N'ქიზიყის 7ბ', N'0182', N'15', 31, 1, 12.0000, NULL)
INSERT [dbo].[Sales] ([Id], [SDate], [SDocNumber], [CustomerId], [City], [Street], [PostalCode], [Appartment], [MtId], [MtQty], [MtPrice], [Comment]) VALUES (16, CAST(N'2020-03-06' AS Date), 3, 1, N'თბილისი', N'ქიზიყის 7ბ', N'0182', N'15', 26, 1, 8.0000, NULL)
INSERT [dbo].[Sales] ([Id], [SDate], [SDocNumber], [CustomerId], [City], [Street], [PostalCode], [Appartment], [MtId], [MtQty], [MtPrice], [Comment]) VALUES (17, CAST(N'2020-03-06' AS Date), 3, 1, N'თბილისი', N'ქიზიყის 7ბ', N'0182', N'15', 27, 3, 15.0000, NULL)
SET IDENTITY_INSERT [dbo].[Sales] OFF
GO
SET IDENTITY_INSERT [dbo].[TopicComments] ON 

INSERT [dbo].[TopicComments] ([Id], [UserId], [TopicId], [Comment], [CommentDate]) VALUES (11, 1, 13, N'asad', CAST(N'2020-02-28T17:36:39.830' AS DateTime))
SET IDENTITY_INSERT [dbo].[TopicComments] OFF
GO
SET IDENTITY_INSERT [dbo].[Topics] ON 

INSERT [dbo].[Topics] ([Id], [Title], [Text], [ImageId], [CreationDate], [LastEditDate], [UserId]) VALUES (8, N'რა სურს შენს ზაზუნას?', N'<p>შემთხვევითად გენერირებული ტექსტი ეხმარება დიზაინერებს და ტიპოგრაფიული ნაწარმის შემქმნელებს, რეალურთან მაქსიმალურად მიახლოებული შაბლონი წარუდგინონ შემფასებელს. ხშირადაა შემთხვევა, როდესაც დიზაინის შესრულებისას საჩვენებელია, თუ როგორი იქნება ტექსტის ბლოკი. სწორედ ასეთ დროს არის მოსახერხებელი ამ გენერატორით შექმნილი ტექსტის გამოყენება, რადგან უბრალოდ „ტექსტი ტექსტი ტექსტი“ ან სხვა გამეორებადი სიტყვების ჩაყრა, ხელოვნურ ვიზუალურ სიმეტრიას ქმნის და არაბუნებრივად გამოიყურება.</p>', 37, CAST(N'2020-02-27T09:37:00.787' AS DateTime), CAST(N'2020-02-28T13:03:31.380' AS DateTime), 5)
INSERT [dbo].[Topics] ([Id], [Title], [Text], [ImageId], [CreationDate], [LastEditDate], [UserId]) VALUES (9, N'აცრები უპირველეს ყოვლისა!', N'<p>შემთხვევითად გენერირებული ტექსტი ეხმარება დიზაინერებს და ტიპოგრაფიული ნაწარმის შემქმნელებს, რეალურთან მაქსიმალურად მიახლოებული შაბლონი წარუდგინონ შემფასებელს. ხშირადაა შემთხვევა, როდესაც დიზაინის შესრულებისას საჩვენებელია, თუ როგორი იქნება ტექსტის ბლოკი. სწორედ ასეთ დროს არის მოსახერხებელი ამ გენერატორით შექმნილი ტექსტის გამოყენება, რადგან უბრალოდ „ტექსტი ტექსტი ტექსტი“ ან სხვა გამეორებადი სიტყვების ჩაყრა, ხელოვნურ ვიზუალურ სიმეტრიას ქმნის და არაბუნებრივად გამოიყურება.</p>', 36, CAST(N'2020-02-27T10:36:17.390' AS DateTime), CAST(N'2020-02-28T13:01:58.540' AS DateTime), 5)
INSERT [dbo].[Topics] ([Id], [Title], [Text], [ImageId], [CreationDate], [LastEditDate], [UserId]) VALUES (10, N'ახალი მეგობარი ', N'<p>შემთხვევითად გენერირებული ტექსტი ეხმარება დიზაინერებს და ტიპოგრაფიული ნაწარმის შემქმნელებს, რეალურთან მაქსიმალურად მიახლოებული შაბლონი წარუდგინონ შემფასებელს. ხშირადაა შემთხვევა, როდესაც დიზაინის შესრულებისას საჩვენებელია, თუ როგორი იქნება ტექსტის ბლოკი. სწორედ ასეთ დროს არის მოსახერხებელი ამ გენერატორით შექმნილი ტექსტის გამოყენება, რადგან უბრალოდ „ტექსტი ტექსტი ტექსტი“ ან სხვა გამეორებადი სიტყვების ჩაყრა, ხელოვნურ ვიზუალურ სიმეტრიას ქმნის და არაბუნებრივად გამოიყურება.</p>', 34, CAST(N'2020-02-27T10:40:32.390' AS DateTime), CAST(N'2020-02-28T13:00:14.673' AS DateTime), 5)
INSERT [dbo].[Topics] ([Id], [Title], [Text], [ImageId], [CreationDate], [LastEditDate], [UserId]) VALUES (11, N'კატის 10 ჩვევა ', N'<p>შემთხვევითად გენერირებული ტექსტი ეხმარება დიზაინერებს და ტიპოგრაფიული ნაწარმის შემქმნელებს, რეალურთან მაქსიმალურად მიახლოებული შაბლონი წარუდგინონ შემფასებელს. ხშირადაა შემთხვევა, როდესაც დიზაინის შესრულებისას საჩვენებელია, თუ როგორი იქნება ტექსტის ბლოკი. სწორედ ასეთ დროს არის მოსახერხებელი ამ გენერატორით შექმნილი ტექსტის გამოყენება, რადგან უბრალოდ „ტექსტი ტექსტი ტექსტი“ ან სხვა გამეორებადი სიტყვების ჩაყრა, ხელოვნურ ვიზუალურ სიმეტრიას ქმნის და არაბუნებრივად გამოიყურება.</p>', 33, CAST(N'2020-02-27T10:56:46.413' AS DateTime), CAST(N'2020-02-28T12:59:43.017' AS DateTime), 5)
INSERT [dbo].[Topics] ([Id], [Title], [Text], [ImageId], [CreationDate], [LastEditDate], [UserId]) VALUES (12, N'ჭკვიანი ძაღლი ', N'<p>შემთხვევითად გენერირებული ტექსტი ეხმარება დიზაინერებს და ტიპოგრაფიული ნაწარმის შემქმნელებს, რეალურთან მაქსიმალურად მიახლოებული შაბლონი წარუდგინონ შემფასებელს. ხშირადაა შემთხვევა, როდესაც დიზაინის შესრულებისას საჩვენებელია, თუ როგორი იქნება ტექსტის ბლოკი. სწორედ ასეთ დროს არის მოსახერხებელი ამ გენერატორით შექმნილი ტექსტის გამოყენება, რადგან უბრალოდ „ტექსტი ტექსტი ტექსტი“ ან სხვა გამეორებადი სიტყვების ჩაყრა, ხელოვნურ ვიზუალურ სიმეტრიას ქმნის და არაბუნებრივად გამოიყურება.</p>', 35, CAST(N'2020-02-27T10:59:48.037' AS DateTime), CAST(N'2020-02-28T13:00:54.870' AS DateTime), 5)
INSERT [dbo].[Topics] ([Id], [Title], [Text], [ImageId], [CreationDate], [LastEditDate], [UserId]) VALUES (13, N'დილის რუტინა', N'<p>შემთხვევითად გენერირებული ტექსტი ეხმარება დიზაინერებს და ტიპოგრაფიული ნაწარმის შემქმნელებს, რეალურთან მაქსიმალურად მიახლოებული შაბლონი წარუდგინონ შემფასებელს. ხშირადაა შემთხვევა, როდესაც დიზაინის შესრულებისას საჩვენებელია, თუ როგორი იქნება ტექსტის ბლოკი. სწორედ ასეთ დროს არის მოსახერხებელი ამ გენერატორით შექმნილი ტექსტის გამოყენება, რადგან უბრალოდ „ტექსტი ტექსტი ტექსტი“ ან სხვა გამეორებადი სიტყვების ჩაყრა, ხელოვნურ ვიზუალურ სიმეტრიას ქმნის და არაბუნებრივად გამოიყურება.</p>', 31, CAST(N'2020-02-27T11:04:59.397' AS DateTime), CAST(N'2020-02-28T12:57:26.350' AS DateTime), 5)
SET IDENTITY_INSERT [dbo].[Topics] OFF
GO
SET IDENTITY_INSERT [dbo].[UserCart] ON 

INSERT [dbo].[UserCart] ([Id], [UserId], [CreationDate], [Result]) VALUES (26, 1, CAST(N'2020-02-28T17:36:00.517' AS DateTime), 1)
INSERT [dbo].[UserCart] ([Id], [UserId], [CreationDate], [Result]) VALUES (27, 1, CAST(N'2020-03-06T13:05:46.530' AS DateTime), 1)
INSERT [dbo].[UserCart] ([Id], [UserId], [CreationDate], [Result]) VALUES (28, 1, CAST(N'2020-03-06T13:06:15.330' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[UserCart] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Email], [Password], [City], [Street], [PostalCode], [Appartment], [IsAdministrator], [CreationDate], [LastEditionDate], [LastLoginDate]) VALUES (1, N'ალექსანდრე', N'პეტროსიანი', N'skdnopd1802@gmail.com', N'a50fee0ebff53fcd6706a80c8b714755e6ff75db0a74f3b315dd20c7502b34aeb0cfbd34ee9ecf85d409ba3e2e73cbc2fb48915824c34ecfd8ce71bd043f7213', N'თბილისი', N'ქიზიყის 7ბ', N'0182', N'15', 1, CAST(N'2020-01-03T16:28:00.440' AS DateTime), CAST(N'2020-01-28T11:44:25.700' AS DateTime), CAST(N'2020-03-06T13:05:42.590' AS DateTime))
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Email], [Password], [City], [Street], [PostalCode], [Appartment], [IsAdministrator], [CreationDate], [LastEditionDate], [LastLoginDate]) VALUES (5, N'ნელი', N'ტაბატაძე', N'nelitabatadze@gmail.com', N'57efbedf1e7b53afd09557b2c17c780f84880073f2e94c9bb5b3dfe1188d167571e2094e9954770b065e7a6de198f4131148a64fccecd070c74376255708cfd9', N'თბილისი', N'ჭავჭავაძე', N'0112', N'128', 1, CAST(N'2020-02-27T09:26:53.917' AS DateTime), CAST(N'2020-02-27T09:27:16.607' AS DateTime), CAST(N'2020-02-28T12:47:20.873' AS DateTime))
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[FavouriteProducts]  WITH CHECK ADD  CONSTRAINT [FK_FavouriteProducts_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[FavouriteProducts] CHECK CONSTRAINT [FK_FavouriteProducts_Products]
GO
ALTER TABLE [dbo].[FavouriteProducts]  WITH CHECK ADD  CONSTRAINT [FK_FavouriteProducts_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[FavouriteProducts] CHECK CONSTRAINT [FK_FavouriteProducts_Users]
GO
ALTER TABLE [dbo].[ProductBalance]  WITH CHECK ADD  CONSTRAINT [FK_ProductBalance_Products1] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[ProductBalance] CHECK CONSTRAINT [FK_ProductBalance_Products1]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Groups] FOREIGN KEY([MtGroup])
REFERENCES [dbo].[Groups] ([Id])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Groups]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_ProductImages] FOREIGN KEY([ImageId])
REFERENCES [dbo].[Images] ([Id])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_ProductImages]
GO
ALTER TABLE [dbo].[Sales]  WITH CHECK ADD  CONSTRAINT [FK_Sales_Products] FOREIGN KEY([MtId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[Sales] CHECK CONSTRAINT [FK_Sales_Products]
GO
ALTER TABLE [dbo].[Sales]  WITH CHECK ADD  CONSTRAINT [FK_Sales_UserConfirmed] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Sales] CHECK CONSTRAINT [FK_Sales_UserConfirmed]
GO
ALTER TABLE [dbo].[TopicComments]  WITH CHECK ADD  CONSTRAINT [FK_TopicComments_Topics] FOREIGN KEY([TopicId])
REFERENCES [dbo].[Topics] ([Id])
GO
ALTER TABLE [dbo].[TopicComments] CHECK CONSTRAINT [FK_TopicComments_Topics]
GO
ALTER TABLE [dbo].[TopicComments]  WITH CHECK ADD  CONSTRAINT [FK_TopicComments_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[TopicComments] CHECK CONSTRAINT [FK_TopicComments_Users]
GO
ALTER TABLE [dbo].[Topics]  WITH CHECK ADD  CONSTRAINT [FK_Topics_Images] FOREIGN KEY([ImageId])
REFERENCES [dbo].[Images] ([Id])
GO
ALTER TABLE [dbo].[Topics] CHECK CONSTRAINT [FK_Topics_Images]
GO
ALTER TABLE [dbo].[Topics]  WITH CHECK ADD  CONSTRAINT [FK_Topics_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Topics] CHECK CONSTRAINT [FK_Topics_Users]
GO
ALTER TABLE [dbo].[UserCart]  WITH CHECK ADD  CONSTRAINT [FK_UserCart_UserConfirmed] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[UserCart] CHECK CONSTRAINT [FK_UserCart_UserConfirmed]
GO
ALTER TABLE [dbo].[UserCartProducts]  WITH CHECK ADD  CONSTRAINT [FK_UserCartProducts_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[UserCartProducts] CHECK CONSTRAINT [FK_UserCartProducts_Products]
GO
ALTER TABLE [dbo].[UserCartProducts]  WITH CHECK ADD  CONSTRAINT [FK_UserCartProducts_UserCart] FOREIGN KEY([UserCartId])
REFERENCES [dbo].[UserCart] ([Id])
GO
ALTER TABLE [dbo].[UserCartProducts] CHECK CONSTRAINT [FK_UserCartProducts_UserCart]
GO
USE [master]
GO
ALTER DATABASE [ProjectZ] SET  READ_WRITE 
GO
