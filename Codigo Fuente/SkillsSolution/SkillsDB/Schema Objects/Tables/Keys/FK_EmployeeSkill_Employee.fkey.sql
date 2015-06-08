ALTER TABLE [dbo].[EmployeeSkill]
    ADD CONSTRAINT [FK_EmployeeSkill_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [dbo].[Employee] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

