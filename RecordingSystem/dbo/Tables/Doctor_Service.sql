CREATE TABLE [dbo].[Doctor_Service] (
    [DoctorId]  INT NULL,
    [ServiceId] INT NULL,
    FOREIGN KEY ([DoctorId]) REFERENCES [dbo].[Doctor] ([Id]),
    FOREIGN KEY ([ServiceId]) REFERENCES [dbo].[Service] ([Id])
);

