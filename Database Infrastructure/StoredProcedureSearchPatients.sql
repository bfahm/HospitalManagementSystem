

CREATE PROCEDURE sp_search_patients
@Id int = NULL,
@Name nvarchar(50) = NULL,
@Number nvarchar(50) = NULL,
@Count int out

AS
BEGIN
	SELECT * FROM Ent_Patient
	WHERE	(Pid = @Id OR @Id is NULL) AND
			(Pname = @Name OR @Name is NULL) AND
			(Pnumber = @Number OR @Number is NULL) 
			--AND(Pdisease = @Disease OR @Disease is NULL)

	SELECT @Count = (SELECT COUNT(*) FROM Ent_Patient
	WHERE	(Pid = @Id OR @Id is NULL) AND
			(Pname = @Name OR @Name is NULL) AND
			(Pnumber = @Number OR @Number is NULL))
	
END


