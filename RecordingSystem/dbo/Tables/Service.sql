CREATE TABLE [dbo].[Service] (
    [Id]               INT           IDENTITY (1, 1) NOT NULL,
    [Name]             NVARCHAR (50) NOT NULL,
    [ServiceCategory]  NVARCHAR (50) NULL,
    [Price]            FLOAT (53)    NOT NULL,
    [SpecializationId] INT           NULL,
    [IsDeleted]        BIT           DEFAULT ((0)) NULL,
    [ForMen]           BIT           NULL,
    [CategoryId]       INT           NULL,
    [ForInvalid]       BIT           NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[Category] ([Id]),
    FOREIGN KEY ([SpecializationId]) REFERENCES [dbo].[Specialization] ([Id])
);

