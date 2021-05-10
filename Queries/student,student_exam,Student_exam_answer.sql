--Sp for table student...................................
--insert student sp
create proc insertStudent 
(
 @sid            INTEGER      =  NULL,  
 @sFname         nVARCHAR(50) =  NULL,  
 @sLname         nchar(10)    =  NULL,
 @Adress         nVARCHAR(100)=  NULL,  
 @sAge           int          =  NULL,  
 @dId            int          =  NULL,
 @sSuper         int          =  NULL
) 
with encryption
as
	   BEGIN TRY
            INSERT INTO Student  
                        (St_Id ,
                         St_Fname,  
                         St_Lname,  
                         St_Address,  
                         St_Age,  
                         Dept_Id,
				          St_super)  
            VALUES     ( @sid ,
                         @sFname,  
                         @sLname ,  
                         @Adress,  
                         @sAge,  
                         @dId,
				         @sSuper )
        END TRY
		BEGIN CATCH
			IF ERROR_NUMBER() = 2627 --error number for non unique value
			select  'insert a unique question ID' AS [ERROR] 
		ELSE if ERROR_NUMBER() = 547
			select 'No department id with ID  = ' + convert(varchar(20), @dId) AS [ERROR]
		ELSE 
			select 'there was an ERROR'

		END CATCH
--check
execute insertStudent @sid=9,@sAge=10
select*from Student
	--select * student sp
	create proc selectStudent @SID int = NULL
with encryption
as
select * from Student where St_Id = @SID
--check
execute selectStudent 1
--update Student sp
create proc updateStudent 
(
 @sid            INTEGER      =  NULL,  
 @sFname         nVARCHAR(50) =  NULL,  
 @sLname         nchar(10)    =  NULL,
 @Adress         nVARCHAR(100)=  NULL,  
 @sAge           int          =  NULL,  
 @dId            int          =  NULL,
 @sSuper         int          =  NULL
) 
with encryption
as 
		BEGIN TRY
            UPDATE  Student  
            SET
				
				St_Id = case when @sid is NULL then St_Id else @sid end,  
                St_Fname = case when @sFname is NULL then St_Fname else @sFname end,
                St_Lname = case when @sLname is NULL then St_Lname else @sLname end, 
                St_Address = case when @Adress is NULL then St_Address else @Adress end,
                St_Age = case when @sAge is NULL then St_Age else @sAge end,
				St_super = case when @sSuper is NULL then St_super else @sSuper end
				
            WHERE  St_Id = @sid 
        END TRY
		BEGIN CATCH
	IF ERROR_NUMBER() = 2627 --error number for non unique value
			select  'The Id must be unique' AS [ERROR] 
		ELSE if ERROR_NUMBER() = 547
			select 'No department id with ID  = ' + convert(varchar(20), @dId) AS [ERROR]
		ELSE 
			select 'there was an ERROR'
		END CATCH
		--check
		updateStudent 1,'ahmed','abdallah',1,26,1
		select*from Student
		
--delete sp student
create proc deleteStudent @id int = NULL
with encryption
as
		BEGIN 
            DELETE FROM  Student
            WHERE  st_id= @id  
        END
		--check
	execute deleteStudent 15

--Table Student exam..................................

----insert student exam sp
create proc insertStudentExam 
(
 @sid            int      =  NULL,  
 @EID            int      =  NULL,  
 @eMmarks        int      =  NULL,
 @EDate          date     =  NULL
) 
with encryption
as
	   BEGIN TRY
            INSERT INTO Student_Exam  
                        (Std_Id ,
                         Exam_Id,  
                         Marks,  
                        [date]  )

            VALUES     ( @sid ,
                         @EID,  
                         @eMmarks ,  
                         @EDate )
        END TRY
		BEGIN CATCH
		IF ERROR_NUMBER() = 2627 --error number for non unique value
			select  'insert a unique student ID or Exam id' AS [ERROR] 

		ELSE
			SELECT ' there is an error ' 
		END CATCH
--check
		execute insertStudentExam 1,2,4
		select* from Student_Exam
--select student exam sp
create proc selectStudentExam @SID int = NULL ,@EID int = NULL 
with encryption
as
select * from Student_Exam where Std_Id = @SID and Exam_Id=@EID
--check
execute selectStudentExam 1,2
--update student exam sp
create proc updatestudentexam 
(
  @sid            int      =  NULL,  
  @EID            int      =  NULL,  
  @eMmarks        int      =  NULL,
  @EDate          date     =  NULL
) 
with encryption
as 
		BEGIN TRY
            UPDATE [dbo].[Student_Exam]
            SET
				
				Std_Id = case when @sid is NULL then Std_Id else @sid end,  
                Exam_Id = case when @EID is NULL then Exam_Id else @EID end,
                Marks = case when @eMmarks is NULL then Marks else @eMmarks end, 
                [Date] = case when @EDate is NULL then [Date] else @EDate end
               
				
            WHERE  Std_Id =  @sid and Exam_Id=@EID
        END TRY
		BEGIN CATCH
			select 'check the Std_id or Exam Id'
		END CATCH
--check
execute updatestudentexam 9,2,490
select*from Student_Exam
--delete student exam sp
create proc deletestudentexam @Sid int = NULL, @Eid int=NULL
with encryption
as
		BEGIN 
            DELETE FROM  Student_Exam
            WHERE  Std_Id= @Sid  and Exam_Id=@Eid
        END
		--check
execute deletestudentexam 1,2
select*from Student_Exam
--Table student exam answer...........................................................
--select student exam answer sp
create proc selectStudentExamAnswer @SID  int = NULL ,@EID int =null
with encryption
as
select * from Student_Exam_Answer where st_Id = @SID and Exam_Id=@EID
--check
execute selectStudentExamAnswer 1,1

--insert student exam answer sp
create proc insertStudentExamAnswer 
(
 @sAnswer            varchar(20) = NULL,  
 @sID                int = NULL,  
 @EID                int = NULL,
 @QID                int = NULL
) 
with encryption
as
	   BEGIN TRY
            INSERT INTO Student_Exam_Answer  
                        (St_Answer ,
                         St_Id,  
                         Exam_Id ,  
                         [Q-Id]  
                         )  
            VALUES     ( @sAnswer ,
                         @sID,  
                         @EID ,  
                         @QID )

        END TRY
		BEGIN CATCH
		IF ERROR_NUMBER() = 2627 --error number for non unique value
			select  'insert a unique St_id or Exam_id or Question_id'  
		ELSE
			SELECT ' Error happen ' 
		END CATCH
--check
execute insertStudentExamAnswer 'yes',1,8,9
select*from Student_Exam_Answer
--update student exam answer sp
create proc updateStudentExamAnsewer
(
 @sAnswer            varchar(20) = NULL,  
 @sID                int = NULL,  
 @EID                int = NULL,
 @QID                int = NULL
) 
with encryption
as 
		BEGIN TRY
            UPDATE  Student_Exam_Answer  
            SET
				
				St_Answer = case when @sAnswer is NULL then St_Answer else @sAnswer end,  
                St_Id = case when @sID is NULL then St_Id else @sID end,
                Exam_Id = case when @EID is NULL then Exam_Id else @EID end, 
                [Q-Id] = case when @QID is NULL then [Q-Id] else @QID end
             
				
            WHERE  St_Id = @sID and  Exam_Id=@EID and [Q-Id]=@QID
        END TRY
		BEGIN CATCH
			select 'an error happen   '
		END CATCH
        --check
		execute updateStudentExamAnsewer 'b', 1,2,1
		select *from Student_Exam_Answer

--delete student exam answer sp		
create proc deletestudentexamanswer @SId int = NULL,@EId int = NULL,@QId int = NULL
with encryption
as
		BEGIN 
            DELETE FROM  Student_Exam_Answer
            WHERE  St_Id= @SId and Exam_Id=@EId and [Q-Id]=@QId
        END
		select*from Student_Exam_Answer
		--check
		execute deletestudentexamanswer 1,1,3
		select*from Student_Exam_Answer