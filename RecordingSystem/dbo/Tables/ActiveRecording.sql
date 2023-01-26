CREATE TABLE [dbo].[ActiveRecording] (
    [Id]        INT      IDENTITY (1, 1) NOT NULL,
    [PatientId] INT      NULL,
    [DoctorId]  INT      NULL,
    [DateTime]  DATETIME NULL,
    [Coming]    BIT      NULL,
    [IsDeleted] BIT      DEFAULT ((0)) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    FOREIGN KEY ([DoctorId]) REFERENCES [dbo].[Doctor] ([Id]),
    FOREIGN KEY ([PatientId]) REFERENCES [dbo].[Patient] ([Id])
);

