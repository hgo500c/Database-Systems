--====================================================Q1
select top 10 i.Name as InstructorName, c.Name as CourseName
FROM Instructors as i 
    Join CourseInstructors as ci
	on i.InstructorID=ci.InstructorID
	Join Courses as c
	on ci.CourseID= c.CourseID
	order by InstructorName
	
--====================================================Q2
select *
from Instructors as i
where i.InstructorID not in (select c.InstructorID
                               from CourseInstructors as c)
--====================================================Q3
select i.InstructorID,i.Name,i.Address,i.City,i.State,i.Zip,i.Phone,i.Salary
from Instructors as i
 left join CourseInstructors as c
on c.InstructorID=i.InstructorID
where c.InstructorID  is null
--====================================================Q4
select i.name,ex.ExamID,sum(eq.Points)as TotalPoint,[status] = 'Over'
from Instructors as i
join Exams as ex
on ex.InstructorID=i.InstructorID
join ExamsQuestions as eq
on eq.ExamID=ex.ExamID
where ex.ExamDate between '1/1/2018' and '12/31/2018'
group by i.Name,ex.ExamID
having sum(eq.Points)>100
union
select i.name,ex.ExamID,sum(eq.Points)as TotalPoint,[status] = 'Under'
from Instructors as i
join Exams as ex
on ex.InstructorID=i.InstructorID
join ExamsQuestions as eq
on eq.ExamID=ex.ExamID
where ex.ExamDate between '1/1/2018' and '12/31/2018'
group by i.Name,ex.ExamID
having sum(eq.Points)<100

--====================================================Q5
select  i.Name, ex.ExamID, [TotalPoints] = sum(eq.Points), 
		[status] = case when sum(eq.Points) < 100 then 'Under'
						when sum(eq.Points) > 100 then 'Over'
					end
from Instructors as	i
		join Exams	as ex
			on ex.InstructorID = i.InstructorID
		join ExamsQuestions	as	eq
			on eq.ExamID = ex.ExamID
where (ex.ExamDate between '1/1/2018' and '12/31/2018')
group by i.Name,ex.ExamID
having sum(eq.Points) != 100
order by i.Name
--====================================================Q6
select ca.TAID,ta.Name
from dbo.CourseTAs ca,dbo.TAs as ta
group by ca.TAID,ta.Name,ta.TAID having count(ca.CourseID)>2 and ca.TAID=ta.TAID
order by ta.Name
--====================================================Q7

SELECT i.State, [ExamCount] = COUNT(DISTINCT e.ExamID), [AvgPoints] = CAST(SUM(eq.Points) AS FLOAT) / COUNT(DISTINCT e.ExamID)
FROM Instructors as i 
join Exams as e
on i.InstructorID = e.InstructorID 
join ExamsQuestions as eq
on e.ExamID = eq.ExamID
GROUP BY i.State
ORDER BY i.State
--====================================================Q8
SELECT * 
FROM Instructors
ORDER BY State, Name
	OFFSET 40 ROWS
		FETCH NEXT 20 ROWS ONLY
--====================================================Q9
SELECT distinct ex.ExamID,ta.Name,it.Rate,ex.TARate
from Instructors as i
join Exams as ex
on i.InstructorID=ex.InstructorID
join InstructorTAPayRate as it
on i.InstructorID= it.InstructorID
join TAs as ta
on ta.TAID=ex.TAID
where it.Rate!=ex.TARate and ta.TAID=it.TAID
order by ta.Name
--====================================================Q10
select [InstructorName]= i.Name, [TAName] = isnull(t.Name, 'TA NEEDED') 
from Instructors	as	i
		join CourseInstructors	as	ci
			on ci.InstructorID = i.InstructorID
		left join CourseTAs	as	ct
			on ct.CourseID = ci.CourseID
		left join TAs	as		t
			on t.TAID = ct.TAID
--====================================================Q11
select [InstructorsName]=i.Name, [TAName]=ta.Name, e.ExamID
FROM Instructors i
join Exams as e
on e.InstructorID=i.InstructorID
join TAs as ta
on e.TAID=ta.TAID
where ta.TAID NOT IN(
select ct.TAID
FROM CourseTAs ct
join
CourseInstructors ci
on ci.CourseID=ct.CourseID
where ci.InstructorID=i.InstructorID
)
order by ta.Name