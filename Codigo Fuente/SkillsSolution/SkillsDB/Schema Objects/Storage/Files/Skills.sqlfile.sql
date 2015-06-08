ALTER DATABASE [$(DatabaseName)]
    ADD FILE (NAME = [Skills], FILENAME = '$(DefaultDataPath)$(DatabaseName).mdf', FILEGROWTH = 1024 KB) TO FILEGROUP [PRIMARY];

