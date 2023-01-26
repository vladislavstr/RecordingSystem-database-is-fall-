CREATE TABLE [dbo].[Doctor] (
    [Id]               INT           IDENTITY (1, 1) NOT NULL,
    [Name]             NVARCHAR (20) NOT NULL,
    [LastName]         NVARCHAR (30) NOT NULL,
    [Male]             BIT           NOT NULL,
    [PhoneNumber]      NVARCHAR (10) NULL,
    [Email]            NVARCHAR (20) NULL,
    [SpecializationId] INT           NULL,
    [CabinetId]        INT           NULL,
    [TimeTableId]      INT           NULL,
    [IsDeleted]        BIT           DEFAULT ((0)) NULL,
    [Birthday]         DATE          NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    FOREIGN KEY ([CabinetId]) REFERENCES [dbo].[Cabinet] ([Id]),
    FOREIGN KEY ([SpecializationId]) REFERENCES [dbo].[Specialization] ([Id]),
    FOREIGN KEY ([TimeTableId]) REFERENCES [dbo].[TimeTable] ([Id])
);

