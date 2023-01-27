/*
Скрипт развертывания для RecordingSystem

Этот код был создан программным средством.
Изменения, внесенные в этот файл, могут привести к неверному выполнению кода и будут потеряны
в случае его повторного формирования.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "RecordingSystem"
:setvar DefaultFilePrefix "RecordingSystem"
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
USE [$(DatabaseName)];


GO
/*
Удаляется столбец [dbo].[Patient].[Age], возможна потеря данных.

Удаляется столбец [dbo].[Patient].[Invalidity], возможна потеря данных.
*/

IF EXISTS (select top 1 1 from [dbo].[Patient])
    RAISERROR (N'Обнаружены строки. Обновление схемы завершено из-за возможной потери данных.', 16, 127) WITH NOWAIT

GO
/*
Удаляется столбец [dbo].[Service].[CategoryId], возможна потеря данных.

Удаляется столбец [dbo].[Service].[ForInvalid], возможна потеря данных.

Удаляется столбец [dbo].[Service].[ForMen], возможна потеря данных.
*/

IF EXISTS (select top 1 1 from [dbo].[Service])
    RAISERROR (N'Обнаружены строки. Обновление схемы завершено из-за возможной потери данных.', 16, 127) WITH NOWAIT

GO
/*
Удаляется столбец [dbo].[TimeRecording].[10:00 - 11:00], возможна потеря данных.

Удаляется столбец [dbo].[TimeRecording].[11:00 - 12:00], возможна потеря данных.

Удаляется столбец [dbo].[TimeRecording].[12:00 - 13:00], возможна потеря данных.

Удаляется столбец [dbo].[TimeRecording].[13:00 - 14:00], возможна потеря данных.

Удаляется столбец [dbo].[TimeRecording].[14:00 - 15:00], возможна потеря данных.

Удаляется столбец [dbo].[TimeRecording].[15:00 - 16:00], возможна потеря данных.

Удаляется столбец [dbo].[TimeRecording].[16:00 - 17:00], возможна потеря данных.

Удаляется столбец [dbo].[TimeRecording].[17:00 - 18:00], возможна потеря данных.

Удаляется столбец [dbo].[TimeRecording].[18:00 - 19:00], возможна потеря данных.

Удаляется столбец [dbo].[TimeRecording].[19:00 - 20:00], возможна потеря данных.

Удаляется столбец [dbo].[TimeRecording].[20:00 - 21:00], возможна потеря данных.

Удаляется столбец [dbo].[TimeRecording].[21:00 - 22:00], возможна потеря данных.

Удаляется столбец [dbo].[TimeRecording].[8:00 - 9:00], возможна потеря данных.

Удаляется столбец [dbo].[TimeRecording].[9:00 - 10:00], возможна потеря данных.

Удаляется столбец [dbo].[TimeRecording].[Day], возможна потеря данных.

Необходимо добавить столбец [dbo].[TimeRecording].[Date] таблицы [dbo].[TimeRecording], но он не содержит значения по умолчанию и не допускает значения NULL. Если таблица содержит данные, скрипт ALTER окажется неработоспособным. Чтобы избежать возникновения этой проблемы, необходимо выполнить одно из следующих действий: добавить в столбец значение по умолчанию, пометить его как допускающий значения NULL или разрешить формирование интеллектуальных умолчаний в параметрах развертывания.
*/

IF EXISTS (select top 1 1 from [dbo].[TimeRecording])
    RAISERROR (N'Обнаружены строки. Обновление схемы завершено из-за возможной потери данных.', 16, 127) WITH NOWAIT

GO
/*
Удаляется столбец [dbo].[TimeTable].[Friday], возможна потеря данных.

Удаляется столбец [dbo].[TimeTable].[Monday], возможна потеря данных.

Удаляется столбец [dbo].[TimeTable].[Saturday], возможна потеря данных.

Удаляется столбец [dbo].[TimeTable].[Sunday], возможна потеря данных.

Удаляется столбец [dbo].[TimeTable].[Thursday], возможна потеря данных.

Удаляется столбец [dbo].[TimeTable].[Tuesday], возможна потеря данных.

Удаляется столбец [dbo].[TimeTable].[Wednesday], возможна потеря данных.
*/

IF EXISTS (select top 1 1 from [dbo].[TimeTable])
    RAISERROR (N'Обнаружены строки. Обновление схемы завершено из-за возможной потери данных.', 16, 127) WITH NOWAIT

GO
PRINT N'Идет удаление Ограничение по умолчанию ограничение без названия для [dbo].[Doctor]…';


GO
ALTER TABLE [dbo].[Doctor] DROP CONSTRAINT [DF__Doctor__IsDelete__44FF419A];


GO
PRINT N'Идет удаление Ограничение по умолчанию ограничение без названия для [dbo].[Patient]…';


GO
ALTER TABLE [dbo].[Patient] DROP CONSTRAINT [DF__Patient__IsDelet__46E78A0C];


GO
PRINT N'Идет удаление Внешний ключ ограничение без названия для [dbo].[ActiveRecording]…';


GO
ALTER TABLE [dbo].[ActiveRecording] DROP CONSTRAINT [FK__ActiveRec__Docto__5441852A];


GO
PRINT N'Идет удаление Внешний ключ ограничение без названия для [dbo].[Doctor_Service]…';


GO
ALTER TABLE [dbo].[Doctor_Service] DROP CONSTRAINT [FK__Doctor_Se__Docto__59063A47];


GO
PRINT N'Идет удаление Внешний ключ ограничение без названия для [dbo].[Doctor]…';


GO
ALTER TABLE [dbo].[Doctor] DROP CONSTRAINT [FK__Doctor__CabinetI__4F7CD00D];


GO
PRINT N'Идет удаление Внешний ключ ограничение без названия для [dbo].[Doctor]…';


GO
ALTER TABLE [dbo].[Doctor] DROP CONSTRAINT [FK__Doctor__Speciali__5070F446];


GO
PRINT N'Идет удаление Внешний ключ ограничение без названия для [dbo].[Doctor]…';


GO
ALTER TABLE [dbo].[Doctor] DROP CONSTRAINT [FK__Doctor__TimeTabl__5165187F];


GO
PRINT N'Идет удаление Внешний ключ ограничение без названия для [dbo].[ActiveRecording]…';


GO
ALTER TABLE [dbo].[ActiveRecording] DROP CONSTRAINT [FK__ActiveRec__Patie__5535A963];


GO
PRINT N'Идет удаление Внешний ключ ограничение без названия для [dbo].[Patient]…';


GO
ALTER TABLE [dbo].[Patient] DROP CONSTRAINT [FK__Patient__StatusI__5629CD9C];


GO
PRINT N'Идет удаление Внешний ключ ограничение без названия для [dbo].[Service]…';


GO
ALTER TABLE [dbo].[Service] DROP CONSTRAINT [FK__Service__Categor__571DF1D5];


GO
PRINT N'Идет удаление Внешний ключ ограничение без названия для [dbo].[TimeTable]…';


GO
ALTER TABLE [dbo].[TimeTable] DROP CONSTRAINT [FK__TimeTable__Frida__48CFD27E];


GO
PRINT N'Идет удаление Внешний ключ ограничение без названия для [dbo].[TimeTable]…';


GO
ALTER TABLE [dbo].[TimeTable] DROP CONSTRAINT [FK__TimeTable__Monda__49C3F6B7];


GO
PRINT N'Идет удаление Внешний ключ ограничение без названия для [dbo].[TimeTable]…';


GO
ALTER TABLE [dbo].[TimeTable] DROP CONSTRAINT [FK__TimeTable__Satur__4AB81AF0];


GO
PRINT N'Идет удаление Внешний ключ ограничение без названия для [dbo].[TimeTable]…';


GO
ALTER TABLE [dbo].[TimeTable] DROP CONSTRAINT [FK__TimeTable__Sunda__4BAC3F29];


GO
PRINT N'Идет удаление Внешний ключ ограничение без названия для [dbo].[TimeTable]…';


GO
ALTER TABLE [dbo].[TimeTable] DROP CONSTRAINT [FK__TimeTable__Thurs__4CA06362];


GO
PRINT N'Идет удаление Внешний ключ ограничение без названия для [dbo].[TimeTable]…';


GO
ALTER TABLE [dbo].[TimeTable] DROP CONSTRAINT [FK__TimeTable__Tuesd__4D94879B];


GO
PRINT N'Идет удаление Внешний ключ ограничение без названия для [dbo].[TimeTable]…';


GO
ALTER TABLE [dbo].[TimeTable] DROP CONSTRAINT [FK__TimeTable__Wedne__4E88ABD4];


GO
PRINT N'Идет удаление Ограничение уникальности ограничение без названия для [dbo].[TimeRecording]…';


GO
ALTER TABLE [dbo].[TimeRecording] DROP CONSTRAINT [UQ__TimeReco__C0301F12CCDA18C0];


GO
PRINT N'Идет удаление Ограничение уникальности ограничение без названия для [dbo].[TimeTable]…';


GO
ALTER TABLE [dbo].[TimeTable] DROP CONSTRAINT [UQ__TimeTabl__4A72E722485D43CD];


GO
PRINT N'Идет удаление Ограничение уникальности ограничение без названия для [dbo].[TimeTable]…';


GO
ALTER TABLE [dbo].[TimeTable] DROP CONSTRAINT [UQ__TimeTabl__FF9543B07290586E];


GO
PRINT N'Идет удаление Ограничение уникальности ограничение без названия для [dbo].[TimeTable]…';


GO
ALTER TABLE [dbo].[TimeTable] DROP CONSTRAINT [UQ__TimeTabl__C043F3C8ED3A39AD];


GO
PRINT N'Идет удаление Ограничение уникальности ограничение без названия для [dbo].[TimeTable]…';


GO
ALTER TABLE [dbo].[TimeTable] DROP CONSTRAINT [UQ__TimeTabl__BC9B79B36A75777F];


GO
PRINT N'Идет удаление Ограничение уникальности ограничение без названия для [dbo].[TimeTable]…';


GO
ALTER TABLE [dbo].[TimeTable] DROP CONSTRAINT [UQ__TimeTabl__E35C15E7463F2F89];


GO
PRINT N'Идет удаление Ограничение уникальности ограничение без названия для [dbo].[TimeTable]…';


GO
ALTER TABLE [dbo].[TimeTable] DROP CONSTRAINT [UQ__TimeTabl__C0D8F2F3E758C639];


GO
PRINT N'Идет удаление Ограничение уникальности ограничение без названия для [dbo].[TimeTable]…';


GO
ALTER TABLE [dbo].[TimeTable] DROP CONSTRAINT [UQ__TimeTabl__DE21DD839713C3F3];


GO
PRINT N'Идет удаление Проверочное ограничение ограничение без названия для [dbo].[Patient]…';


GO
ALTER TABLE [dbo].[Patient] DROP CONSTRAINT [CK__Patient__Age__5AEE82B9];


GO
PRINT N'Выполняется запуск перестройки таблицы [dbo].[Patient]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Patient] (
    [Id]          INT           IDENTITY (1, 1) NOT NULL,
    [Name]        NVARCHAR (30) NOT NULL,
    [LastName]    NVARCHAR (30) NULL,
    [PhoneNumber] NVARCHAR (10) NOT NULL,
    [Email]       NVARCHAR (30) NULL,
    [StatusId]    INT           NULL,
    [Male]        BIT           NOT NULL,
    [IsDeleted]   BIT           CONSTRAINT [DF__Patient__IsDelet__49C3F6B7] DEFAULT ((0)) NULL,
    [Birthday]    DATE          NOT NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK__Patient__3214EC078B1FA5B01] PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Patient])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Patient] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Patient] ([Id], [Name], [LastName], [PhoneNumber], [Email], [StatusId], [Male], [IsDeleted], [Birthday])
        SELECT   [Id],
                 [Name],
                 [LastName],
                 [PhoneNumber],
                 [Email],
                 [StatusId],
                 [Male],
                 [IsDeleted],
                 [Birthday]
        FROM     [dbo].[Patient]
        ORDER BY [Id] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Patient] OFF;
    END

DROP TABLE [dbo].[Patient];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Patient]', N'Patient';

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK__Patient__3214EC078B1FA5B01]', N'PK__Patient__3214EC078B1FA5B0', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Идет изменение Таблица [dbo].[Service]…';


GO
ALTER TABLE [dbo].[Service] DROP COLUMN [CategoryId], COLUMN [ForInvalid], COLUMN [ForMen];


GO
ALTER TABLE [dbo].[Service]
    ADD [Male] BIT NULL;


GO
PRINT N'Идет изменение Таблица [dbo].[TimeRecording]…';


GO
ALTER TABLE [dbo].[TimeRecording] DROP COLUMN [10:00 - 11:00], COLUMN [11:00 - 12:00], COLUMN [12:00 - 13:00], COLUMN [13:00 - 14:00], COLUMN [14:00 - 15:00], COLUMN [15:00 - 16:00], COLUMN [16:00 - 17:00], COLUMN [17:00 - 18:00], COLUMN [18:00 - 19:00], COLUMN [19:00 - 20:00], COLUMN [20:00 - 21:00], COLUMN [21:00 - 22:00], COLUMN [8:00 - 9:00], COLUMN [9:00 - 10:00], COLUMN [Day];


GO
ALTER TABLE [dbo].[TimeRecording]
    ADD [Date]        DATE NOT NULL,
        [TimeTableId] INT  NULL,
        [Occupied]    BIT  NULL;


GO
PRINT N'Идет изменение Таблица [dbo].[TimeTable]…';


GO
ALTER TABLE [dbo].[TimeTable] DROP COLUMN [Friday], COLUMN [Monday], COLUMN [Saturday], COLUMN [Sunday], COLUMN [Thursday], COLUMN [Tuesday], COLUMN [Wednesday];


GO
ALTER TABLE [dbo].[TimeTable]
    ADD [DoctorId]    INT NULL,
        [DayOfWeekId] INT NULL,
        [TimeSpanId]  INT NULL;


GO
PRINT N'Выполняется запуск перестройки таблицы [dbo].[Doctor]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Doctor] (
    [Id]               INT           IDENTITY (1, 1) NOT NULL,
    [Name]             NVARCHAR (20) NOT NULL,
    [LastName]         NVARCHAR (30) NOT NULL,
    [Male]             BIT           NOT NULL,
    [PhoneNumber]      NVARCHAR (10) NULL,
    [Email]            NVARCHAR (20) NULL,
    [SpecializationId] INT           NULL,
    [CabinetId]        INT           NULL,
    [TimeTableId]      INT           NULL,
    [IsDeleted]        BIT           CONSTRAINT [DF__Doctor__IsDelete__778AC167] DEFAULT ((0)) NULL,
    [Birthday]         DATE          NOT NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK__Doctor__3214EC07A918EE951] PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Doctor])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Doctor] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Doctor] ([Id], [Name], [LastName], [Male], [PhoneNumber], [Email], [SpecializationId], [CabinetId], [TimeTableId], [IsDeleted], [Birthday])
        SELECT   [Id],
                 [Name],
                 [LastName],
                 [Male],
                 [PhoneNumber],
                 [Email],
                 [SpecializationId],
                 [CabinetId],
                 [TimeTableId],
                 [IsDeleted],
                 [Birthday]
        FROM     [dbo].[Doctor]
        ORDER BY [Id] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Doctor] OFF;
    END

DROP TABLE [dbo].[Doctor];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Doctor]', N'Doctor';

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK__Doctor__3214EC07A918EE951]', N'PK__Doctor__3214EC07A918EE95', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


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
PRINT N'Идет создание Таблица [dbo].[Dop_Service]…';


GO
CREATE TABLE [dbo].[Dop_Service] (
    [DoctorId]  INT NULL,
    [ServiceId] INT NULL
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
PRINT N'Идет создание Внешний ключ [dbo].[FK__Doctor__CabinetI__08B54D69]…';


GO
ALTER TABLE [dbo].[Doctor] WITH NOCHECK
    ADD CONSTRAINT [FK__Doctor__CabinetI__08B54D69] FOREIGN KEY ([CabinetId]) REFERENCES [dbo].[Cabinet] ([Id]);


GO
PRINT N'Идет создание Внешний ключ [dbo].[FK__Doctor__Speciali__0A9D95DB]…';


GO
ALTER TABLE [dbo].[Doctor] WITH NOCHECK
    ADD CONSTRAINT [FK__Doctor__Speciali__0A9D95DB] FOREIGN KEY ([SpecializationId]) REFERENCES [dbo].[Specialization] ([Id]);


GO
PRINT N'Идет создание Внешний ключ [dbo].[FK_Patient_Status]…';


GO
ALTER TABLE [dbo].[Patient] WITH NOCHECK
    ADD CONSTRAINT [FK_Patient_Status] FOREIGN KEY ([StatusId]) REFERENCES [dbo].[Status] ([Id]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Dop_Service]…';


GO
ALTER TABLE [dbo].[Dop_Service] WITH NOCHECK
    ADD FOREIGN KEY ([ServiceId]) REFERENCES [dbo].[Service] ([Id]);


GO
PRINT N'Идет создание Внешний ключ [dbo].[FK__Doctor_Se__Docto__0D7A0286]…';


GO
ALTER TABLE [dbo].[Dop_Service] WITH NOCHECK
    ADD CONSTRAINT [FK__Doctor_Se__Docto__0D7A0286] FOREIGN KEY ([DoctorId]) REFERENCES [dbo].[Doctor] ([Id]);


GO
PRINT N'Идет создание Внешний ключ [dbo].[FK__ACtiveRec__Docto__05D8E0BE]…';


GO
ALTER TABLE [dbo].[ActiveRecording] WITH NOCHECK
    ADD CONSTRAINT [FK__ACtiveRec__Docto__05D8E0BE] FOREIGN KEY ([DoctorId]) REFERENCES [dbo].[Doctor] ([Id]);


GO
PRINT N'Идет создание Внешний ключ [dbo].[FK_ActiveRecording_Patient]…';


GO
ALTER TABLE [dbo].[ActiveRecording] WITH NOCHECK
    ADD CONSTRAINT [FK_ActiveRecording_Patient] FOREIGN KEY ([PatientId]) REFERENCES [dbo].[Patient] ([Id]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[TimeRecording]…';


GO
ALTER TABLE [dbo].[TimeRecording] WITH NOCHECK
    ADD FOREIGN KEY ([TimeTableId]) REFERENCES [dbo].[TimeTable] ([Id]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[TimeTable]…';


GO
ALTER TABLE [dbo].[TimeTable] WITH NOCHECK
    ADD FOREIGN KEY ([DayOfWeekId]) REFERENCES [dbo].[DayOfWeek] ([Id]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[TimeTable]…';


GO
ALTER TABLE [dbo].[TimeTable] WITH NOCHECK
    ADD FOREIGN KEY ([DoctorId]) REFERENCES [dbo].[Doctor] ([Id]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[TimeTable]…';


GO
ALTER TABLE [dbo].[TimeTable] WITH NOCHECK
    ADD FOREIGN KEY ([TimeSpanId]) REFERENCES [dbo].[TimeSpan] ([Id]);


GO
PRINT N'Идет обновление Процедура [dbo].[GetAllDoctorByServices]…';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[GetAllDoctorByServices]';


GO
PRINT N'Идет обновление Процедура [dbo].[GetAllServiceByDoctor]…';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[GetAllServiceByDoctor]';


GO
PRINT N'Идет обновление Процедура [dbo].[GetAllDoctorBySpecialization]…';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[GetAllDoctorBySpecialization]';


GO
PRINT N'Существующие данные проверяются относительно вновь созданных ограничений';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Doctor] WITH CHECK CHECK CONSTRAINT [FK__Doctor__CabinetI__08B54D69];

ALTER TABLE [dbo].[Doctor] WITH CHECK CHECK CONSTRAINT [FK__Doctor__Speciali__0A9D95DB];

ALTER TABLE [dbo].[Patient] WITH CHECK CHECK CONSTRAINT [FK_Patient_Status];

ALTER TABLE [dbo].[ActiveRecording] WITH CHECK CHECK CONSTRAINT [FK__ACtiveRec__Docto__05D8E0BE];

ALTER TABLE [dbo].[ActiveRecording] WITH CHECK CHECK CONSTRAINT [FK_ActiveRecording_Patient];


GO
CREATE TABLE [#__checkStatus] (
    id           INT            IDENTITY (1, 1) PRIMARY KEY CLUSTERED,
    [Schema]     NVARCHAR (256),
    [Table]      NVARCHAR (256),
    [Constraint] NVARCHAR (256)
);

SET NOCOUNT ON;

DECLARE tableconstraintnames CURSOR LOCAL FORWARD_ONLY
    FOR SELECT SCHEMA_NAME([schema_id]),
               OBJECT_NAME([parent_object_id]),
               [name],
               0
        FROM   [sys].[objects]
        WHERE  [parent_object_id] IN (OBJECT_ID(N'dbo.Dop_Service'), OBJECT_ID(N'dbo.TimeRecording'), OBJECT_ID(N'dbo.TimeTable'))
               AND [type] IN (N'F', N'C')
                   AND [object_id] IN (SELECT [object_id]
                                       FROM   [sys].[check_constraints]
                                       WHERE  [is_not_trusted] <> 0
                                              AND [is_disabled] = 0
                                       UNION
                                       SELECT [object_id]
                                       FROM   [sys].[foreign_keys]
                                       WHERE  [is_not_trusted] <> 0
                                              AND [is_disabled] = 0);

DECLARE @schemaname AS NVARCHAR (256);

DECLARE @tablename AS NVARCHAR (256);

DECLARE @checkname AS NVARCHAR (256);

DECLARE @is_not_trusted AS INT;

DECLARE @statement AS NVARCHAR (1024);

BEGIN TRY
    OPEN tableconstraintnames;
    FETCH tableconstraintnames INTO @schemaname, @tablename, @checkname, @is_not_trusted;
    WHILE @@fetch_status = 0
        BEGIN
            PRINT N'Проверка ограничения: ' + @checkname + N' [' + @schemaname + N'].[' + @tablename + N']';
            SET @statement = N'ALTER TABLE [' + @schemaname + N'].[' + @tablename + N'] WITH ' + CASE @is_not_trusted WHEN 0 THEN N'CHECK' ELSE N'NOCHECK' END + N' CHECK CONSTRAINT [' + @checkname + N']';
            BEGIN TRY
                EXECUTE [sp_executesql] @statement;
            END TRY
            BEGIN CATCH
                INSERT  [#__checkStatus] ([Schema], [Table], [Constraint])
                VALUES                  (@schemaname, @tablename, @checkname);
            END CATCH
            FETCH tableconstraintnames INTO @schemaname, @tablename, @checkname, @is_not_trusted;
        END
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH

IF CURSOR_STATUS(N'LOCAL', N'tableconstraintnames') >= 0
    CLOSE tableconstraintnames;

IF CURSOR_STATUS(N'LOCAL', N'tableconstraintnames') = -1
    DEALLOCATE tableconstraintnames;

SELECT N'Ошибка при проверке ограничения:' + [Schema] + N'.' + [Table] + N',' + [Constraint]
FROM   [#__checkStatus];

IF @@ROWCOUNT > 0
    BEGIN
        DROP TABLE [#__checkStatus];
        RAISERROR (N'Произошла ошибка при проверке ограничений', 16, 127);
    END

SET NOCOUNT OFF;

DROP TABLE [#__checkStatus];


GO
PRINT N'Обновление завершено.';


GO
