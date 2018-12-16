CREATE PROCEDURE sp_calculate_days_till_date 
@PatientID int
--,@Bill int OUT
AS
BEGIN
DECLARE @DaysSince int;
DECLARE @HisDayIn Date = (SELECT PdayIn FROM Ent_Patient where Pid = @PatientID);
DECLARE @HisDayOut Date= (SELECT PdayOut FROM Ent_Patient where Pid = @PatientID);

IF (@HisDayOut IS NULL)
BEGIN
	--SELECT @Bill = (
		SELECT DATEDIFF(Day,@HisDayIn,GETDATE()) as DateDiff
	--);
END

ELSE
BEGIN
	--SELECT @Bill = (
		SELECT DATEDIFF(Day,@HisDayIn,@HisDayOut) as DateDiff
	--);
END
END


