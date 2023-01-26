CREATE TABLE [dbo].[TimeRecording] (
    [Id]            INT  IDENTITY (1, 1) NOT NULL,
    [Day]           DATE NOT NULL,
    [8:00 - 9:00]   BIT  NOT NULL,
    [9:00 - 10:00]  BIT  NOT NULL,
    [10:00 - 11:00] BIT  NOT NULL,
    [11:00 - 12:00] BIT  NOT NULL,
    [12:00 - 13:00] BIT  NOT NULL,
    [13:00 - 14:00] BIT  NOT NULL,
    [14:00 - 15:00] BIT  NOT NULL,
    [15:00 - 16:00] BIT  NOT NULL,
    [16:00 - 17:00] BIT  NOT NULL,
    [17:00 - 18:00] BIT  NOT NULL,
    [18:00 - 19:00] BIT  NOT NULL,
    [19:00 - 20:00] BIT  NOT NULL,
    [20:00 - 21:00] BIT  NOT NULL,
    [21:00 - 22:00] BIT  NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    UNIQUE NONCLUSTERED ([Day] ASC)
);

