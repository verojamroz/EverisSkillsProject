/*
Script de implementación para Skills

Una herramienta generó este código.
Los cambios realizados en este archivo podrían generar un comportamiento incorrecto y se perderán si
se vuelve a generar el código.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "Skills"
:setvar DefaultFilePrefix "Skills"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detectar el modo SQLCMD y deshabilitar la ejecución del script si no se admite el modo SQLCMD.
Para volver a habilitar el script después de habilitar el modo SQLCMD, ejecute lo siguiente:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'El modo SQLCMD debe estar habilitado para ejecutar correctamente este script.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creando $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
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
        PRINT N'No se puede modificar la configuración de la base de datos. Debe ser un administrador del sistema para poder aplicar esta configuración.';
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
        PRINT N'No se puede modificar la configuración de la base de datos. Debe ser un administrador del sistema para poder aplicar esta configuración.';
    END


GO
USE [$(DatabaseName)];


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

GO
PRINT N'Creando [dbo].[Employee]...';


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
    [CreationDate] DATETIME     NOT NULL,
    CONSTRAINT [PK_Employee_1] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creando [dbo].[EmployeeSkill]...';


GO
CREATE TABLE [dbo].[EmployeeSkill] (
    [IdEmployee]   INT NOT NULL,
    [IdTechnology] INT NOT NULL,
    [IdSkill]      INT NOT NULL,
    CONSTRAINT [PK_EmployeeSkill_1] PRIMARY KEY CLUSTERED ([IdEmployee] ASC, [IdTechnology] ASC, [IdSkill] ASC)
);


GO
PRINT N'Creando [dbo].[Skill]...';


GO
CREATE TABLE [dbo].[Skill] (
    [Id]          INT           IDENTITY (1, 1) NOT NULL,
    [Description] VARCHAR (100) NOT NULL,
    CONSTRAINT [PK_Skill] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creando [dbo].[Technology]...';


GO
CREATE TABLE [dbo].[Technology] (
    [Id]          INT            IDENTITY (1, 1) NOT NULL,
    [Name]        VARCHAR (1000) NOT NULL,
    [Description] VARCHAR (100)  NOT NULL,
    [Status]      INT            NOT NULL,
    CONSTRAINT [PK_Technology] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creando [dbo].[User]...';


GO
CREATE TABLE [dbo].[User] (
    [Id]           INT          IDENTITY (1, 1) NOT NULL,
    [UserName]     VARCHAR (50) NOT NULL,
    [Password]     VARCHAR (50) NOT NULL,
    [Role]         VARCHAR (10) NOT NULL,
    [Status]       INT          NOT NULL,
    [CreationDate] DATETIME     NOT NULL,
    CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creando FK_Employee_User...';


GO
ALTER TABLE [dbo].[Employee]
    ADD CONSTRAINT [FK_Employee_User] FOREIGN KEY ([IdUser]) REFERENCES [dbo].[User] ([Id]);


GO
PRINT N'Creando FK_EmployeeSkill_Technology...';


GO
ALTER TABLE [dbo].[EmployeeSkill]
    ADD CONSTRAINT [FK_EmployeeSkill_Technology] FOREIGN KEY ([IdTechnology]) REFERENCES [dbo].[Technology] ([Id]);


GO
PRINT N'Creando FK_EmployeeSkill_Skill...';


GO
ALTER TABLE [dbo].[EmployeeSkill]
    ADD CONSTRAINT [FK_EmployeeSkill_Skill] FOREIGN KEY ([IdSkill]) REFERENCES [dbo].[Skill] ([Id]);


GO
PRINT N'Creando FK_EmployeeSkill_Employee...';


GO
ALTER TABLE [dbo].[EmployeeSkill]
    ADD CONSTRAINT [FK_EmployeeSkill_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [dbo].[Employee] ([Id]);


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

GO
PRINT N'Actualización completada.'
GO
