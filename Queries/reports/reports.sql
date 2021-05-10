--Report that returns the students information according to Department No parameter
create proc getStudentsByDep @dID int
as
select * from Student
where Dept_Id = @dID

getStudentsByDep 10

--Report that takes the student ID and returns the grades of the student in all courses. %
create proc stdGrades @sID int
as
select c.Crs_Id ,c.Crs_Name, sc.Grade from Course c, Stud_Course sc
where sc.Crs_Id = c.Crs_Id
and sc.St_Id = @sID

stdGrades 1