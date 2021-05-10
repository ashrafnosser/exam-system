create proc createExam 
(
  @eID int = NULL, 
  @eName varchar(20) = NULL,
  @duration varchar(20) = NULL, 
  @cID int = NULL,
  @examQuestionsCount int = NULL
)
with encryption
as
begin
	   if (select count(Crs_Id) from Question
	       where Crs_Id = @cID) >= @examQuestionsCount 
			begin try

				begin transaction
					insert into Exam values (@eID, @eName, @duration, @cID)

					insert into Exam_Question
					select top(@examQuestionsCount) Q_Id, @eID from Question
					where Crs_Id = @cID
					order by newid()
				commit

			end try
				begin catch
				rollback
				select 'There was an ERROR inserting to all tables'
			end catch
		else
			if @cID not in (select Crs_Id from Question)
				select 'no course id = ' + 
				convert(varchar(20),@cID) as ERROR
			else if @eID is null or @eName is null or @cID is null  or @examQuestionsCount is null
				select 'please insert all required parameters' as ERROR
			else
				select 'There was an ERROR' as ERROR

end

--tests

--all will give an error
createExam

createExam 1

createExam 1, 'html'

createExam 1, 'html', '2 hours'

createExam 1, 'html', '2hours', 100
--------------------------------------

--will give null Duration
createExam @eID = 1, @eName = 'asdf', @cID = 100, @examQuestionsCount = 1
go
select * from Exam

--give 2 questions in exam 2
createExam 2, 'html exam', '2 hours', 200, 2
go
select * from Exam_Question eq, Exam e, Question q
where eq.Q_Id = q.Q_Id
and eq.E_Id = e.Ex_Id
and q.Crs_Id =200
and e.Ex_Id = 2

