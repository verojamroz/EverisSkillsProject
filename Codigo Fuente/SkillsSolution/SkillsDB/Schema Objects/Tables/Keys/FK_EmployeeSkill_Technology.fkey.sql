ALTER TABLE [dbo].[EmployeeSkill]
    ADD CONSTRAINT [FK_EmployeeSkill_Technology] FOREIGN KEY ([IdTechnology]) REFERENCES [dbo].[Technology] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

