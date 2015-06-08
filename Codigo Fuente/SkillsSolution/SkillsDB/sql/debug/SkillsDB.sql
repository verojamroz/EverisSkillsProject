/*
Deployment script for Skills
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "Skills"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL10_50.PKZ\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL10_50.PKZ\MSSQL\DATA\"

GO
:on error exit
GO
USE [master]
GO
IF (DB_ID(N'$(DatabaseName)') IS NOT NULL
    AND DATABASEPROPERTYEX(N'$(DatabaseName)','Status') <> N'ONLINE')
BEGIN
    RAISERROR(N'The state of the target database, %s, is not set to ONLINE. To deploy to this database, its state must be set to ONLINE.', 16, 127,N'$(DatabaseName)') WITH NOWAIT
    RETURN
END

GO
IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creating $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [Skills], FILENAME = '$(DefaultDataPath)$(DatabaseName).mdf', FILEGROWTH = 1024 KB)
    LOG ON (NAME = [Skills_log], FILENAME = '$(DefaultLogPath)$(DatabaseName)_log.ldf', MAXSIZE = 2097152 MB, FILEGROWTH = 10 %) COLLATE SQL_Latin1_General_CP1_CI_AS
GO
EXECUTE sp_dbcmptlevel [$(DatabaseName)], 100;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
USE [$(DatabaseName)]
GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
/*
 Pre-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be executed before the build script.	
 Use SQLCMD syntax to include a file in the pre-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the pre-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

GO
PRINT N'Creating [dbo].[Employee]...';


GO
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


GO
PRINT N'Creating PK_Employee_1...';


GO
ALTER TABLE [dbo].[Employee]
    ADD CONSTRAINT [PK_Employee_1] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating [dbo].[EmployeeSkill]...';


GO
CREATE TABLE [dbo].[EmployeeSkill] (
    [IdEmployee]   INT NOT NULL,
    [IdTechnology] INT NOT NULL,
    [IdSkill]      INT NOT NULL
);


GO
PRINT N'Creating PK_EmployeeSkill_1...';


GO
ALTER TABLE [dbo].[EmployeeSkill]
    ADD CONSTRAINT [PK_EmployeeSkill_1] PRIMARY KEY CLUSTERED ([IdEmployee] ASC, [IdTechnology] ASC, [IdSkill] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating [dbo].[Skill]...';


GO
CREATE TABLE [dbo].[Skill] (
    [Id]          INT           IDENTITY (1, 1) NOT NULL,
    [Description] VARCHAR (100) NOT NULL
);


GO
PRINT N'Creating PK_Skill...';


GO
ALTER TABLE [dbo].[Skill]
    ADD CONSTRAINT [PK_Skill] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating [dbo].[Technology]...';


GO
CREATE TABLE [dbo].[Technology] (
    [Id]          INT            IDENTITY (1, 1) NOT NULL,
    [Name]        VARCHAR (1000) NOT NULL,
    [Description] VARCHAR (100)  NOT NULL,
    [Status]      INT            NOT NULL
);


GO
PRINT N'Creating PK_Technology...';


GO
ALTER TABLE [dbo].[Technology]
    ADD CONSTRAINT [PK_Technology] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating [dbo].[User]...';


GO
CREATE TABLE [dbo].[User] (
    [Id]           INT          IDENTITY (1, 1) NOT NULL,
    [UserName]     VARCHAR (50) NOT NULL,
    [Password]     VARCHAR (50) NOT NULL,
    [Role]         VARCHAR (10) NOT NULL,
    [Status]       INT          NOT NULL,
    [CreationDate] DATETIME     NOT NULL
);


GO
PRINT N'Creating PK_User...';


GO
ALTER TABLE [dbo].[User]
    ADD CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating FK_Employee_User...';


GO
ALTER TABLE [dbo].[Employee] WITH NOCHECK
    ADD CONSTRAINT [FK_Employee_User] FOREIGN KEY ([IdUser]) REFERENCES [dbo].[User] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK_EmployeeSkill_Employee...';


GO
ALTER TABLE [dbo].[EmployeeSkill] WITH NOCHECK
    ADD CONSTRAINT [FK_EmployeeSkill_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [dbo].[Employee] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK_EmployeeSkill_Skill...';


GO
ALTER TABLE [dbo].[EmployeeSkill] WITH NOCHECK
    ADD CONSTRAINT [FK_EmployeeSkill_Skill] FOREIGN KEY ([IdSkill]) REFERENCES [dbo].[Skill] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK_EmployeeSkill_Technology...';


GO
ALTER TABLE [dbo].[EmployeeSkill] WITH NOCHECK
    ADD CONSTRAINT [FK_EmployeeSkill_Technology] FOREIGN KEY ([IdTechnology]) REFERENCES [dbo].[Technology] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
-- Refactoring step to update target server with deployed transaction logs
CREATE TABLE  [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
GO
sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
GO

GO
/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
SET IDENTITY_INSERT [user] ON
GO
INSERT INTO [user] (id, UserName, [Password], [Role], [Status], CreationDate)
VALUES(1, 'admin', 'a', 'Admin', 1, GETDATE())

INSERT INTO [user] (id, UserName, [Password], [Role], [Status], CreationDate)
VALUES(2, 'jdoe', 'a', 'User', 1, GETDATE())

INSERT INTO [user] (id, UserName, [Password], [Role], [Status], CreationDate)
VALUES(3, 'pobrien', 'a', 'User', 1, GETDATE())

INSERT INTO [user] (id, UserName, [Password], [Role], [Status], CreationDate)
VALUES(4, 'hsolo', 'a', 'User', 1, GETDATE())

INSERT INTO [user] (id, UserName, [Password], [Role], [Status], CreationDate)
VALUES(5, 'mmoore', 'a', 'User', 1, GETDATE())

INSERT INTO [user] (id, UserName, [Password], [Role], [Status], CreationDate)
VALUES(6, 'jbond', 'a', 'User', 1, GETDATE())

INSERT INTO [user] (id, UserName, [Password], [Role], [Status], CreationDate)
VALUES(7, 'jroberts', 'a', 'User', 1, GETDATE())

INSERT INTO [user] (id, UserName, [Password], [Role], [Status], CreationDate)
VALUES(8, 'bdickinson', 'a', 'User', 1, GETDATE())

SET IDENTITY_INSERT [user] OFF
GO


SET IDENTITY_INSERT Employee ON
GO
INSERT INTO Employee(Id, IdUser, FirstName, LastName, Phone, Email, DNI, [Status], CreationDate)
VALUES(1, 2, 'John', 'Doe', '1234423', 'test@test.com', 28456789, 1, GETDATE())
GO
INSERT INTO Employee(Id, IdUser, FirstName, LastName, Phone, Email, DNI, [Status], CreationDate)
VALUES(2, 3, 'Peter', 'OBrien', '1234423', 'test@test.com', 28456789, 1, GETDATE())
GO
INSERT INTO Employee(Id, IdUser, FirstName, LastName, Phone, Email, DNI, [Status], CreationDate)
VALUES(3, 4, 'Hans', 'Solo', '1234423', 'test@test.com', 28456789, 1, GETDATE())
GO

INSERT INTO Employee(Id, IdUser, FirstName, LastName, Phone, Email, DNI, [Status], CreationDate)
VALUES(4, 5, 'Michael', 'Moore', '1234423', 'test@test.com', 28456789, 1, GETDATE())
GO
INSERT INTO Employee(Id, IdUser, FirstName, LastName, Phone, Email, DNI, [Status], CreationDate)
VALUES(5, 6, 'James', 'Bond', '1234423', 'test@test.com', 28456789, 1, GETDATE())
GO
INSERT INTO Employee(Id, IdUser, FirstName, LastName, Phone, Email, DNI, [Status], CreationDate)
VALUES(6, 7, 'Julia', 'Roberts', '1234423', 'test@test.com', 28456789, 1, GETDATE())
GO
INSERT INTO Employee(Id, IdUser, FirstName, LastName, Phone, Email, DNI, [Status], CreationDate)
VALUES(7, 8, 'Bruce', 'Dickinson', '1234423', 'test@test.com', 28456789, 1, GETDATE())
GO

SET IDENTITY_INSERT Employee OFF
GO


/*Niguna, Básico, Intermedio, Avanzado, Experto*/
SET IDENTITY_INSERT Skill ON
GO
INSERT INTO Skill(Id, [Description])
VALUES (1, 'Ninguna')
GO
INSERT INTO Skill(Id, [Description])
VALUES (2, 'Básico')
GO
INSERT INTO Skill(Id, [Description])
VALUES (3, 'Intermedio')
GO
INSERT INTO Skill(Id, [Description])
VALUES (4, 'Avanzado')
GO
INSERT INTO Skill(Id, [Description])
VALUES (5, 'Experto')
GO
SET IDENTITY_INSERT Skill OFF
GO

SET IDENTITY_INSERT Technology ON
GO
/*NET, Java, PHP, Cobol, Javascript, HTML5, Ruby*/
INSERT INTO Technology(Id, [Name], [Description], [Status])
VALUES (1, '.NET', '',1)
GO
INSERT INTO Technology(Id, [Name], [Description], [Status])
VALUES (2, 'Java', '',1)
GO
INSERT INTO Technology(Id, [Name], [Description], [Status])
VALUES (3, 'PHP', '', 1)
GO
INSERT INTO Technology(Id, [Name], [Description], [Status])
VALUES (4, 'Cobol', '', 1)
GO
INSERT INTO Technology(Id, [Name], [Description], [Status])
VALUES (5, 'Javascript', '', 1)
GO
INSERT INTO Technology(Id, [Name], [Description], [Status])
VALUES (6, 'HTML5', '', 1)
GO
INSERT INTO Technology(Id, [Name], [Description], [Status])
VALUES (7, 'Ruby', '',  1)
GO
SET IDENTITY_INSERT Technology OFF
GO

GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Employee] WITH CHECK CHECK CONSTRAINT [FK_Employee_User];

ALTER TABLE [dbo].[EmployeeSkill] WITH CHECK CHECK CONSTRAINT [FK_EmployeeSkill_Employee];

ALTER TABLE [dbo].[EmployeeSkill] WITH CHECK CHECK CONSTRAINT [FK_EmployeeSkill_Skill];

ALTER TABLE [dbo].[EmployeeSkill] WITH CHECK CHECK CONSTRAINT [FK_EmployeeSkill_Technology];


GO
