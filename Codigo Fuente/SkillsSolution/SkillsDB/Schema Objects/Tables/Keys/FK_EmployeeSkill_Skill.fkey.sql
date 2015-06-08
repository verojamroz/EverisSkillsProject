ALTER TABLE [dbo].[EmployeeSkill]
    ADD CONSTRAINT [FK_EmployeeSkill_Skill] FOREIGN KEY ([IdSkill]) REFERENCES [dbo].[Skill] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

