alter proc questionOfExam @ex int 
with encryption
as
select  Question,Choices
from Question as q, Exam as e, Exam_Question as n
where q.Q_Id=n.Q_Id and e.Ex_Id=n.E_Id and e.Ex_Id=@ex
 questionOfExam 1
--check
execute questionOfExam 3
insert into Question
values(2,'how','a,b','a','hard',3,100)
insert into exam 
values(2,'arabic','30',100)
insert into Exam_Quession
values(2,2)

