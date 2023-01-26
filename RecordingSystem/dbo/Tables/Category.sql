CREATE TABLE [dbo].[Category] (
    [Id]         INT IDENTITY (1, 1) NOT NULL,
    [YoungerAge] BIT NULL,
    [MiddleAge]  BIT NULL,
    [OlderAge]   BIT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

