/*
Скрипт развертывания для RecordingSystemDB

Этот код был создан программным средством.
Изменения, внесенные в этот файл, могут привести к неверному выполнению кода и будут потеряны
в случае его повторного формирования.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "RecordingSystemDB"
:setvar DefaultFilePrefix "RecordingSystemDB"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Проверьте режим SQLCMD и отключите выполнение скрипта, если режим SQLCMD не поддерживается.
Чтобы повторно включить скрипт после включения режима SQLCMD выполните следующую инструкцию:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'Для успешного выполнения этого скрипта должен быть включен режим SQLCMD.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Идет создание базы данных $(DatabaseName)…'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE Cyrillic_General_CI_AS
GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Параметры базы данных изменить нельзя. Применить эти параметры может только пользователь SysAdmin.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Параметры базы данных изменить нельзя. Применить эти параметры может только пользователь SysAdmin.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Идет создание Таблица [dbo].[Cabinet]…';


GO
CREATE TABLE [dbo].[Cabinet] (
    [Id]             INT           IDENTITY (1, 1) NOT NULL,
    [Number]         INT           NOT NULL,
    [Status]         INT           NULL,
    [Specialization] NVARCHAR (30) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Patient]…';


GO
CREATE TABLE [dbo].[Patient] (
    [Id]          INT           IDENTITY (1, 1) NOT NULL,
    [Name]        NVARCHAR (30) NOT NULL,
    [LastName]    NVARCHAR (30) NULL,
    [PhoneNumber] NVARCHAR (10) NOT NULL,
    [Email]       NVARCHAR (30) NULL,
    [StatusId]    INT           NULL,
    [Male]        BIT           NOT NULL,
    [IsDeleted]   BIT           NULL,
    [Birthday]    DATE          NOT NULL,
    CONSTRAINT [PK__Patient__3214EC078B1FA5B0] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Diagnosis]…';


GO
CREATE TABLE [dbo].[Diagnosis] (
    [Id]              INT           IDENTITY (1, 1) NOT NULL,
    [Name]            NVARCHAR (50) NULL,
    [Recommendations] NVARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    UNIQUE NONCLUSTERED ([Name] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[RecordingHistory]…';


GO
CREATE TABLE [dbo].[RecordingHistory] (
    [Id]                INT IDENTITY (1, 1) NOT NULL,
    [DiagnosisId]       INT NULL,
    [ActiveRecordingId] INT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[ActiveRecording]…';


GO
CREATE TABLE [dbo].[ActiveRecording] (
    [Id]        INT      IDENTITY (1, 1) NOT NULL,
    [PatientId] INT      NULL,
    [DoctorId]  INT      NULL,
    [DateTime]  DATETIME NULL,
    [Coming]    BIT      NULL,
    [IsDeleted] BIT      NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[TimeSpan]…';


GO
CREATE TABLE [dbo].[TimeSpan] (
    [Id]    INT      IDENTITY (1, 1) NOT NULL,
    [Start] TIME (7) NOT NULL,
    [End]   TIME (7) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[DayOfWeek]…';


GO
CREATE TABLE [dbo].[DayOfWeek] (
    [Id]   INT           IDENTITY (1, 1) NOT NULL,
    [Name] NVARCHAR (10) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    UNIQUE NONCLUSTERED ([Name] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[TimeTable]…';


GO
CREATE TABLE [dbo].[TimeTable] (
    [Id]          INT IDENTITY (1, 1) NOT NULL,
    [DoctorId]    INT NULL,
    [DayOfWeekId] INT NULL,
    [TimeSpanId]  INT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[TimeRecording]…';


GO
CREATE TABLE [dbo].[TimeRecording] (
    [Id]          INT  IDENTITY (1, 1) NOT NULL,
    [Date]        DATE NOT NULL,
    [TimeTableId] INT  NULL,
    [Occupied]    BIT  NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Status]…';


GO
CREATE TABLE [dbo].[Status] (
    [Id]       INT           IDENTITY (1, 1) NOT NULL,
    [Name]     NVARCHAR (10) NULL,
    [Discount] INT           NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Doctor]…';


GO
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
    [IsDeleted]        BIT           NULL,
    [Birthday]         DATE          NOT NULL,
    CONSTRAINT [PK__Doctor__3214EC07A918EE95] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Service]…';


GO
CREATE TABLE [dbo].[Service] (
    [Id]               INT           IDENTITY (1, 1) NOT NULL,
    [Name]             NVARCHAR (50) NOT NULL,
    [ServiceCategory]  NVARCHAR (50) NULL,
    [Price]            FLOAT (53)    NOT NULL,
    [SpecializationId] INT           NULL,
    [IsDeleted]        BIT           NULL,
    [Male]             BIT           NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Specialization]…';


GO
CREATE TABLE [dbo].[Specialization] (
    [Id]   INT           IDENTITY (1, 1) NOT NULL,
    [Name] NVARCHAR (20) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Dop_Service]…';


GO
CREATE TABLE [dbo].[Dop_Service] (
    [DoctorId]  INT NULL,
    [ServiceId] INT NULL
);


GO
PRINT N'Идет создание Ограничение по умолчанию [dbo].[DF__Patient__IsDelet__49C3F6B7]…';


GO
ALTER TABLE [dbo].[Patient]
    ADD CONSTRAINT [DF__Patient__IsDelet__49C3F6B7] DEFAULT ((0)) FOR [IsDeleted];


GO
PRINT N'Идет создание Ограничение по умолчанию ограничение без названия для [dbo].[ActiveRecording]…';


GO
ALTER TABLE [dbo].[ActiveRecording]
    ADD DEFAULT ((0)) FOR [IsDeleted];


GO
PRINT N'Идет создание Ограничение по умолчанию [dbo].[DF__Doctor__IsDelete__778AC167]…';


GO
ALTER TABLE [dbo].[Doctor]
    ADD CONSTRAINT [DF__Doctor__IsDelete__778AC167] DEFAULT ((0)) FOR [IsDeleted];


GO
PRINT N'Идет создание Ограничение по умолчанию ограничение без названия для [dbo].[Service]…';


GO
ALTER TABLE [dbo].[Service]
    ADD DEFAULT ((0)) FOR [IsDeleted];


GO
PRINT N'Идет создание Внешний ключ [dbo].[FK_Patient_Status]…';


GO
ALTER TABLE [dbo].[Patient]
    ADD CONSTRAINT [FK_Patient_Status] FOREIGN KEY ([StatusId]) REFERENCES [dbo].[Status] ([Id]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[RecordingHistory]…';


GO
ALTER TABLE [dbo].[RecordingHistory]
    ADD FOREIGN KEY ([ActiveRecordingId]) REFERENCES [dbo].[ActiveRecording] ([Id]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[RecordingHistory]…';


GO
ALTER TABLE [dbo].[RecordingHistory]
    ADD FOREIGN KEY ([DiagnosisId]) REFERENCES [dbo].[Diagnosis] ([Id]);


GO
PRINT N'Идет создание Внешний ключ [dbo].[FK__ACtiveRec__Docto__05D8E0BE]…';


GO
ALTER TABLE [dbo].[ActiveRecording]
    ADD CONSTRAINT [FK__ACtiveRec__Docto__05D8E0BE] FOREIGN KEY ([DoctorId]) REFERENCES [dbo].[Doctor] ([Id]);


GO
PRINT N'Идет создание Внешний ключ [dbo].[FK_ActiveRecording_Patient]…';


GO
ALTER TABLE [dbo].[ActiveRecording]
    ADD CONSTRAINT [FK_ActiveRecording_Patient] FOREIGN KEY ([PatientId]) REFERENCES [dbo].[Patient] ([Id]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[TimeTable]…';


GO
ALTER TABLE [dbo].[TimeTable]
    ADD FOREIGN KEY ([DayOfWeekId]) REFERENCES [dbo].[DayOfWeek] ([Id]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[TimeTable]…';


GO
ALTER TABLE [dbo].[TimeTable]
    ADD FOREIGN KEY ([DoctorId]) REFERENCES [dbo].[Doctor] ([Id]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[TimeTable]…';


GO
ALTER TABLE [dbo].[TimeTable]
    ADD FOREIGN KEY ([TimeSpanId]) REFERENCES [dbo].[TimeSpan] ([Id]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[TimeRecording]…';


GO
ALTER TABLE [dbo].[TimeRecording]
    ADD FOREIGN KEY ([TimeTableId]) REFERENCES [dbo].[TimeTable] ([Id]);


GO
PRINT N'Идет создание Внешний ключ [dbo].[FK__Doctor__CabinetI__08B54D69]…';


GO
ALTER TABLE [dbo].[Doctor]
    ADD CONSTRAINT [FK__Doctor__CabinetI__08B54D69] FOREIGN KEY ([CabinetId]) REFERENCES [dbo].[Cabinet] ([Id]);


GO
PRINT N'Идет создание Внешний ключ [dbo].[FK__Doctor__Speciali__0A9D95DB]…';


GO
ALTER TABLE [dbo].[Doctor]
    ADD CONSTRAINT [FK__Doctor__Speciali__0A9D95DB] FOREIGN KEY ([SpecializationId]) REFERENCES [dbo].[Specialization] ([Id]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Service]…';


GO
ALTER TABLE [dbo].[Service]
    ADD FOREIGN KEY ([SpecializationId]) REFERENCES [dbo].[Specialization] ([Id]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Dop_Service]…';


GO
ALTER TABLE [dbo].[Dop_Service]
    ADD FOREIGN KEY ([ServiceId]) REFERENCES [dbo].[Service] ([Id]);


GO
PRINT N'Идет создание Внешний ключ [dbo].[FK__Doctor_Se__Docto__0D7A0286]…';


GO
ALTER TABLE [dbo].[Dop_Service]
    ADD CONSTRAINT [FK__Doctor_Se__Docto__0D7A0286] FOREIGN KEY ([DoctorId]) REFERENCES [dbo].[Doctor] ([Id]);


GO
PRINT N'Идет создание Процедура [dbo].[GetAllDoctorBySpecialization]…';


GO
CREATE procedure [dbo].[GetAllDoctorBySpecialization]
@Id_Specialization Int
AS
select S.Name, D.Name, D.LastName, D.Id from dbo.[Specialization] AS S
Inner Join dbo.[Doctor] AS D ON  D.SpecializationId = S.ID
where S.Id = @Id_Specialization
GO
PRINT N'Идет создание Процедура [dbo].[GetAllDoctorByServices]…';


GO
CREATE procedure [dbo].[GetAllDoctorByServices]
@Id_Services Int
AS
select S.Name, D.Name, D.LastName, D.Id from dbo.Service AS S
Inner Join dbo.Specialization AS Sp ON S.SpecializationId = Sp.Id 
Inner Join dbo.Doctor AS D ON D.SpecializationId = Sp.Id
where @Id_Services = S.Id
GO
PRINT N'Идет создание Процедура [dbo].[GetAllServiceByDoctor]…';


GO
CREATE procedure [dbo].[GetAllServiceByDoctor]
@Id_Doctor Int
AS
select D.Name, D.LastName, S.Name, S.Price from dbo.[Doctor] AS D
Inner Join dbo.Specialization AS Sp ON D.SpecializationId = Sp.Id 
Inner Join dbo.Service AS S ON Sp.Id = S.SpecializationId
where @Id_Doctor = D.Id
GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET MULTI_USER 
    WITH ROLLBACK IMMEDIATE;


GO
PRINT N'Обновление завершено.';


GO
