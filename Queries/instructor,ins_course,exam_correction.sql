--select
create proc selectInstructor @ID int = NULL
with encryption
as
select * from Instructor where Ins_Id = @ID

--selectInstructor


--insert
create proc insertInstructor
(
 @id        int = NULL,  
 @name      nvarchar(50) = NULL,  
 @Degree    nvarchar(50)= NULL,
 @Salary     money = NULL,  
 @Dept_Id    int = NULL
) 
with encryption
as
	   BEGIN TRY
            INSERT INTO Instructor 
                        (Ins_Id ,
                         Ins_Name,  
					     Ins_Degree ,  
                         Salary,  
                         Dept_Id
						 )
            VALUES     ( @id ,
                         @name,  
                         @Degree ,  
                         @Salary,  
                         @Dept_Id 
						  )
        END TRY
		BEGIN CATCH
		IF ERROR_NUMBER() = 2627 --error number for non unique value
			select  'insert a unique instructor ID' AS [ERROR] 
		ELSE
			SELECT ' No department with ID = ' + convert(varchar(20), @Dept_Id) AS [ERROR]
		END CATCH

--insertInstructor 1000,"esraa",50,778,10



create proc updateInstructor 
(
 @id            int          = NULL,  
 @name          nvarchar(50) = NULL,  
 @Degree        nvarchar(50) = NULL,
 @Salary        money        = NULL,  
 @Dept_Id       int          = NULL
 
) 
with encryption
as 
		BEGIN TRY
            UPDATE  Instructor 
            SET
				
				Ins_Name     = case when @name    is NULL  then Ins_Name   else @name end,  
                Ins_Degree   = case when @Degree  is NULL  then Ins_Degree else @Degree end,
                Salary       = case when @Salary  is NULL  then salary     else @salary end
               				
            WHERE  Ins_id = @id 
        END TRY
		BEGIN CATCH
			select 'No department with ID  = ' + convert(varchar(20), @Dept_Id) AS [ERROR]
		END CATCH

--updateInstructor 2,"esraa","master",459,10

create proc deleteInstructor @id int = NULL
with encryption
as
		BEGIN 
            DELETE FROM  Instructor
            WHERE  Ins_Id= @id  
        END

 --deleteInstructor 1000



--select
create proc select_Instrcourse @ID int = NULL
with encryption
as
select * from Instructor where Ins_Id = @ID

select_Instrcourse  5


--insert
create proc insert_Instrcourse
(
 @id           int = NULL,  
 @crs_Id       int = NULL,
 @Evaluation   nvarchar(50) = NULL
) 
with encryption 
as
	   BEGIN TRY
            INSERT INTO Ins_course   
			             (
						 Ins_Id ,
                         Crs_Id,
						 Evaluation
			             )
						 
						 
            VALUES     ( 
						 @id ,
                         @crs_Id,
						 @Evaluation
                        )
        END TRY
		BEGIN CATCH
		IF ERROR_NUMBER() = 2627 --error number for non unique value
			select  'insert a unique instructor ID' AS [ERROR] 
		ELSE
			SELECT ' No course with ID = ' + convert(int, @crs_Id) AS [ERROR]
		END CATCH


	--insert_Instrcourse  14 ,100 ,"good"

	
--update

create proc update_Instrcourse
(
 @id           int = NULL,  
 @crs_Id       int = NULL,
 @Evaluation   nvarchar(50) = NULL
 
) 
with encryption
as 
		BEGIN TRY
            UPDATE  Ins_Course
            SET
				
				  Evaluation= case when @Evaluation   is NULL  then Evaluation  else @Evaluation end  
				
            WHERE  Ins_id = @id 
        END TRY
		BEGIN CATCH
			select 'No course with ID  = ' + convert(varchar(20), @crs_Id) AS [ERROR]
		END CATCH

--	update_Instrcourse	13,100 ,"verygood"


--delete
create proc delete_instrcourse @id int = NULL
with encryption
as
		BEGIN 
            DELETE FROM  Ins_Course
            WHERE  Ins_Id= @id  
        END

--delete_instrcourse 14








--report
--   4-that takes course ID and returns its topics  
CREATE PROC takecourseID @cid int
AS
BEGIN
    SELECT dbo.Topic.Top_Name
	FROM dbo.Topic, dbo.course
	WHERE Crs_Id =@cid and Course.Top_Id=Topic.Top_Id
END

takecourseID  1100




--correction


create proc examCorrection @stdID int, @eID int
with encryption
as
select count(*) as Mark 
from Student_Exam_Answer sa, Question q
where sa.St_Id = @stdID and sa.Exam_Id = @eID and q.Q_Id = sa.[Q-Id]
and sa.St_Answer = q.Model_Answer


examCorrection 1,1

