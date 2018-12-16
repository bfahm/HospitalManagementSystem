CREATE PROCEDURE sp_disadmit_patient
@PatientID int,
@output int out
AS

BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			UPDATE Ent_Patient SET PdayOut = GETDATE()
			WHERE Pid = @PatientID ;

			UPDATE Ent_Patient SET PisAssigned = 0
			WHERE Pid = @PatientID ;

			DELETE FROM Rel_Serves 
			WHERE Pid = @PatientID ;		--Its okay if no patients where found

			DELETE FROM Rel_Treats 
			WHERE Pid = @PatientID ;		--Its okay if no patients where found
		COMMIT TRANSACTION
		SET @output = 1;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		SET @output = -1;
	END CATCH
END






