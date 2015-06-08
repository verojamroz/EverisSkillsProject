CREATE TABLE [dbo].[User] (
    [Id]           INT          IDENTITY (1, 1) NOT NULL,
    [UserName]     VARCHAR (50) NOT NULL,
    [Password]     VARCHAR (50) NOT NULL,
    [Role]         VARCHAR (10) NOT NULL,
    [Status]       INT          NOT NULL,
    [CreationDate] DATETIME     NOT NULL
);

