CREATE PROCEDURE [dbo].[AddDoctor]
	@Name nvarchar(20),
	@LastName nvarchar(30),
	@Male bit,
	@PhoneNumber nvarchar(10),
	@Email nvarchar(20),
	@SpecializationId int,
	@CabinetId int,
	@TimeTableId int,
	@Birthday date
AS
INSERT INTO dbo.[Doctor]
(
	Name,
	LastName,
	Male,
	PhoneNumber,
	Email,
	SpecializationId,
	CabinetId,
	TimeTableId,
	Birthday 
)
VALUES
(
	@LastName,
	@Male,
	@PhoneNumber,
	@Email,
	@SpecializationId,
	@CabinetId,
	@TimeTableId,
	@Birthday
)
