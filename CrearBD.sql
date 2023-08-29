CREATE TABLE Tiers
(
	Id int,
	rowName varchar(40),
	rowNumber int,
	numCells int
)
GO
INSERT INTO Tiers(Id, rowName, rowNumber, numCells)
VALUES(1, 'Best', 1, 2)
INSERT INTO Tiers(Id, rowName, rowNumber, numCells)
VALUES(2, 'High', 2, 3)
INSERT INTO Tiers(Id, rowName, rowNumber, numCells)
VALUES(3, 'Mid', 3, 3)
INSERT INTO Tiers(Id, rowName, rowNumber, numCells)
VALUES(4, 'Bad', 4, 4)

GO
CREATE TABLE Item
(
	Id int,
	titulo varchar(40),
	imageId int,
	ranking int,
	itemType int,
	tierId int
)
GO
INSERT INTO Item(Id, titulo, imageId, ranking, itemType, tierId)
VALUES(1, 'Luffy', 1, 0, 1, 0)
INSERT INTO Item(Id, titulo, imageId, ranking, itemType, tierId)
VALUES(2, 'Zoro', 2, 0, 1, 0)
INSERT INTO Item(Id, titulo, imageId, ranking, itemType, tierId)
VALUES(3, 'Nami', 3, 0, 1, 0)
INSERT INTO Item(Id, titulo, imageId, ranking, itemType, tierId)
VALUES(4, 'Usopp', 4, 0, 1, 0)
INSERT INTO Item(Id, titulo, imageId, ranking, itemType, tierId)
VALUES(5, 'Sanji', 5, 0, 1, 0)
INSERT INTO Item(Id, titulo, imageId, ranking, itemType, tierId)
VALUES(6, 'Chopper', 6, 0, 1, 0)
INSERT INTO Item(Id, titulo, imageId, ranking, itemType, tierId)
VALUES(7, 'Robin', 7, 0, 1, 0)
INSERT INTO Item(Id, titulo, imageId, ranking, itemType, tierId)
VALUES(8, 'Franky', 8, 0, 1, 0)
INSERT INTO Item(Id, titulo, imageId, ranking, itemType, tierId)
VALUES(9, 'Brook', 9, 0, 1, 0)
INSERT INTO Item(Id, titulo, imageId, ranking, itemType, tierId)
VALUES(10, 'Jinbe', 10, 0, 1, 0)

GO
CREATE PROCEDURE dbo.EmptyTier(@idTier int)
AS
BEGIN
	UPDATE dbo.Item SET tierId = 0, ranking = 0 WHERE tierId = @idTier
END
GRANT EXECUTE ON dbo.EmptyTier TO  za
GO
CREATE FUNCTION dbo.GetMaxTierIdNumber()
RETURNS int
AS 
BEGIN
	DECLARE @maxTierIdNumber int
	SET @maxTierIdNumber = 0
	SELECT @maxTierIdNumber = MAX(Id) FROM Tiers
	RETURN ISNULL(@maxTierIdNumber, 0)
END
GO
GRANT EXECUTE ON dbo.GetMaxTierRowNumber TO  za
GO
CREATE FUNCTION dbo.GetMaxTierRowNumber()
RETURNS int
AS 
BEGIN
	DECLARE @maxTierRowNumber int
	SET @maxTierRowNumber = 0
	SELECT @maxTierRowNumber = MAX(rowNumber) FROM Tiers
	RETURN ISNULL(@maxTierRowNumber,0)
END
GO
GRANT EXECUTE ON dbo.GetMaxTierRowNumber TO  za
GO
CREATE PROCEDURE dbo.EditTier(@id int, @rowName varchar(40), @numCells int)
AS
BEGIN
	DECLARE @prevCellNum int
	SELECT @prevCellNum = numCells FROM Tiers WHERE Id =@id
	IF(@numCells < @prevCellNum)
	BEGIN
		UPDATE Item SET ranking = 0, tierId = 0 WHERE tierId = @id AND ranking > @numCells
	END
	UPDATE Tiers SET rowName = @rowName, numCells = @numCells WHERE Id =@id
END
GO
GRANT EXECUTE ON dbo.EditTier TO za
GO
CREATE PROCEDURE dbo.ResetType(@itemType int)
AS
BEGIN
	UPDATE Item SET ranking = 0, tierId = 0 WHERE itemType = @itemType
END
GO
GRANT EXECUTE ON dbo.ResetType TO za
