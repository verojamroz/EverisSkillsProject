CREATE TABLE [dbo].[Employee] (
    [Id]           INT          IDENTITY (1, 1) NOT NULL,
    [IdUser]       INT          NOT NULL,
    [FirstName]    VARCHAR (50) NOT NULL,
    [LastName]     VARCHAR (50) NOT NULL,
    [Phone]        VARCHAR (50) NOT NULL,
    [Email]        VARCHAR (50) NOT NULL,
    [DNI]          INT          NOT NULL,
    [Status]       INT          NOT NULL,
    [CreationDate] DATETIME     NOT NULL
);

