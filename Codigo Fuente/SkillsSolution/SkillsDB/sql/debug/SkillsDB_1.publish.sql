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
USE [$(DatabaseName)];


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
