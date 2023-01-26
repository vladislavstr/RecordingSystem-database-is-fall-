CREATE TABLE [dbo].[Patient] (
    [Id]          INT           IDENTITY (1, 1) NOT NULL,
    [Name]        NVARCHAR (30) NOT NULL,
    [LastName]    NVARCHAR (30) NULL,
    [Age]         INT           NULL,
    [PhoneNumber] NVARCHAR (10) NOT NULL,
    [Email]       NVARCHAR (30) NULL,
    [StatusId]    INT           NULL,
    [Male]        BIT           NOT NULL,
    [IsDeleted]   BIT           DEFAULT ((0)) NULL,
    [Invalidity]  BIT           NULL,
    [Birthday]    DATE          NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CHECK ([Age]>(0) AND [Age]<(100)),
    FOREIGN KEY ([StatusId]) REFERENCES [dbo].[Status] ([Id])
);

