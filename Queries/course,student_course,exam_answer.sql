--table_course
 
 -- select
CREATE  PROCEDURE Selectcourse  @Crs_Id int = NULL
with encryption
as
  SELECT * FROM Course where   Crs_Id=@Crs_Id
  
  
  -- insert
  create  PROCEDURE  course_Insert 
 (
@Crs_Id INTEGER  = NULL,
@Crs_Name  VARCHAR(20)  = NULL,
@Crs_Duration INTEGER  = NULL,
@Top_Id INTEGER  = NULL
)
with encryption
as


  BEGIN	TRY
  INSERT INTO Course 
  (
  Crs_Id,
  Crs_Name ,
  Crs_Duration,
  Top_Id
  )
  VALUES
  (
  @Crs_Id,
  @Crs_Name,
  @Crs_Duration,
  @Top_Id)
  END TRY
		BEGIN CATCH
		IF ERROR_NUMBER() = 2627 
			select  'insert a unique course ID' AS [ERROR] 
		ELSE
			SELECT ' No Topic with ID = ' + convert(varchar(20),   @Top_Id) AS [ERROR]
		END CATCH
		
		--update
create  PROCEDURE  course_Update 
(
@Crs_Id INTEGER = NULL,
@Crs_Name  VARCHAR(20)= NULL,
@Crs_Duration INTEGER = NULL,
@Top_Id INTEGER = NULL
)
with encryption
as 
		BEGIN TRY
  UPDATE Course 
  SET 
Crs_Name=      case when @Crs_Name     is NULL then Crs_Name     else    @Crs_Name end,
Crs_Duration=  case when @Crs_Duration is NULL then Crs_Duration  else   @Crs_Duration end ,
Top_Id=        case when @Top_Id       is NULL then Top_Id        else    @Top_Id end
 WHERE Crs_Id = @Crs_Id 
     
        END TRY
		BEGIN CATCH
			select 'No Topic with ID  = ' + convert(varchar(20),  @Top_Id) AS [ERROR]
		END CATCH

 
 -- delete

 create  PROCEDURE  course_Delete @Crs_Id int = NULL
 with encryption
as
		BEGIN 
     DELETE FROM Course
     WHERE Crs_Id = @Crs_Id 
     END

	
	

-- Stud_Course


 -- select
create   PROCEDURE Stud_Course_Select  @Crs_Id int = NULL, @St_Id int = NULL

with encryption
as
  SELECT * FROM Stud_Course where Crs_Id=@Crs_Id and St_Id= @St_Id
  
  -- insert
  create  PROCEDURE  Stud_Courses_Insert
 (
@Crs_Id INTEGER = NULL,
@St_Id INTEGER = NULL ,
@Grade INTEGER = NULL

)
with encryption
as 
  BEGIN	TRY
  INSERT INTO Stud_Course
  (
  Crs_Id,
  St_Id ,
  Grade
  )
  VALUES
  (
  @Crs_Id,
  @St_Id,
  @Grade)
 END TRY
		BEGIN CATCH
		IF ERROR_NUMBER() = 2627 
		select  'insert a unique  Crs_Id+St_Id' AS [ERROR]
		END CATCH
	
	
	    --update
create  PROCEDURE  Stud_Course_Update
(
@Crs_Id INTEGER = NULL,
@St_Id INTEGER = NULL,
@Grade INTEGER = NULL
)
with encryption
as 
  BEGIN	
  UPDATE Stud_Course
  SET Grade =case when @Grade is NULL then Grade else @Grade end

 WHERE  Crs_Id= @Crs_Id  AND  St_Id = @St_Id 
 END
 

        --delete
 create PROCEDURE  Stud_Course_Delete 
 (@Crs_Id INTEGER = NULL ,
 @St_Id INTEGER = NULL)
 
  with encryption
as
  BEGIN
     DELETE FROM Stud_Course
     WHERE  Crs_Id= @Crs_Id  AND  St_Id = @St_Id 
     END
	 


	 --	Report 3


 create PROCEDURE courseName_numStudent_perCourse @Ins_Id int
 as
 select Crs_Name ,count(S.St_Id) AS CountOfStudent
 from Student S ,Stud_Course SC , Course C,Ins_Course IC,Instructor I 
 WHERE I.Ins_Id=@Ins_Id and S.St_Id =SC.St_Id and SC.Crs_Id=C.Crs_Id and C.Crs_Id =IC.Crs_Id
 and IC.Ins_Id=I.Ins_Id 
 group by(C.Crs_Name)

 courseName_numStudent_perCourse 1



 ----- exam answer


 ALTER PROCEDURE ExamAnswer  @Ex_Id int, @Std_Id int ,@St_Answer varchar(20),@Q_Id int

  with encryption
 as 
 begin 
 insert into  Student_Exam_Answer (Exam_Id,St_Id,St_Answer,[Q-Id]) values(@Ex_Id,@Std_Id,@St_Answer,@Q_Id )

 end
 