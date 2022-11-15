--Group Members: Zheng Cao, Ce Zhang, Yangkai Zhang, Junwei Li 

USE master;
GO

IF DB_ID('CAOZ7') IS NOT NULL
	DROP DATABASE CAOZ7;
GO

CREATE DATABASE CAOZ7;
GO

USE CAOZ7;


CREATE TABLE [Account] (
	AccountID int NOT NULL DEFAULT '0',
	Name varchar(50) NOT NULL,
	Password varchar(30) NOT NULL UNIQUE,
	Email varchar(50) NOT NULL,
	SchID int NOT NULL,
	MajorID int NOT NULL,
  CONSTRAINT [PK_ACCOUNT] PRIMARY KEY CLUSTERED
  (
  [AccountID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [Course] (
	CourseID int NOT NULL,
	CourseScore int NOT NULL DEFAULT '0',
	CourseName varchar(50) NOT NULL,
  CONSTRAINT [PK_COURSE] PRIMARY KEY CLUSTERED
  (
  [CourseID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [Professor] (
	ProfessorID int NOT NULL,
	ProfessorName varchar(50) NOT NULL,
	ProfessorScore int NOT NULL DEFAULT '0',
	CourseID int NOT NULL DEFAULT '0',
	MajorID int NOT NULL DEFAULT '0',
  CONSTRAINT [PK_PROFESSOR] PRIMARY KEY CLUSTERED
  (
  [ProfessorID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [School] (
	SchID int NOT NULL,
	SchoolName varchar(100) NOT NULL,
	CommentID int NOT NULL,
  CONSTRAINT [PK_SCHOOL] PRIMARY KEY CLUSTERED
  (
  [SchID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [Major] (
	MajorID int NOT NULL,
	SchID int NOT NULL,
	MajorName varchar(30) NOT NULL,
  CONSTRAINT [PK_MAJOR] PRIMARY KEY CLUSTERED
  (
  [MajorID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [Comment] (
	CommentID int NOT NULL,
	CourseID int NOT NULL,
	Context varchar(5000) NOT NULL,
	AccountID int NOT NULL,
  CONSTRAINT [PK_COMMENT] PRIMARY KEY CLUSTERED
  (
  [CommentID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO

ALTER TABLE [Account] WITH CHECK ADD CONSTRAINT [Account_fk0] FOREIGN KEY ([SchID]) REFERENCES [School]([SchID])
ON UPDATE CASCADE
GO
ALTER TABLE [Account] CHECK CONSTRAINT [Account_fk0]
GO


ALTER TABLE [Professor] WITH CHECK ADD CONSTRAINT [Professor_fk0] FOREIGN KEY ([CourseID]) REFERENCES [Course]([CourseID])
ON UPDATE CASCADE
GO
ALTER TABLE [Professor] CHECK CONSTRAINT [Professor_fk0]
GO

ALTER TABLE [Professor] WITH CHECK ADD CONSTRAINT [Professor_fk1] FOREIGN KEY ([MajorID]) REFERENCES [Major]([MajorID])
ON UPDATE CASCADE
GO
ALTER TABLE [Professor] CHECK CONSTRAINT [Professor_fk1]
GO


ALTER TABLE [Major] WITH CHECK ADD CONSTRAINT [Major_fk0] FOREIGN KEY ([SchID]) REFERENCES [School]([SchID])
ON UPDATE CASCADE
GO
ALTER TABLE [Major] CHECK CONSTRAINT [Major_fk0]
GO

ALTER TABLE [Comment] WITH CHECK ADD CONSTRAINT [Comment_fk0] FOREIGN KEY ([CourseID]) REFERENCES [Course]([CourseID])
ON UPDATE CASCADE
GO
ALTER TABLE [Comment] CHECK CONSTRAINT [Comment_fk0]
GO


CREATE PROCEDURE SelectUser
AS
SELECT * FROM dbo.Account
go

CREATE PROCEDURE SelectSchool
AS
SELECT * FROM dbo.School
go

CREATE PROCEDURE SelectSchoolBySchoolid @id INT
AS
SELECT * FROM dbo.School WHERE SchID=@id
go

CREATE PROCEDURE SelectProfessor
AS
SELECT * FROM dbo.Professor
go

CREATE PROCEDURE SelectMajor
AS
SELECT * FROM dbo.Major
go

CREATE PROCEDURE SelectCourse
AS
SELECT * FROM dbo.Course
go

CREATE PROCEDURE SelectComment
AS
SELECT * FROM dbo.Comment
go
