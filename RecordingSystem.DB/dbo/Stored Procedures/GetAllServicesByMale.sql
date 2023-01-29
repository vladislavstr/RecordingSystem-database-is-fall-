CREATE PROCEDURE [dbo].[GetAllServicesByMale]
@Male bit
AS
SELECT Sp.Id, Sp.Name As SpecializationName, Se.Name AS ServiceName, Se.Price
FROM Service AS Se
INNER JOIN [dbo].Specialization AS Sp ON Se.SpecializationId = Sp.Id
WHERE @Male = Se.Male