﻿ALTER TABLE [dbo].[Employee]
    ADD CONSTRAINT [FK_Employee_User] FOREIGN KEY ([IdUser]) REFERENCES [dbo].[User] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
