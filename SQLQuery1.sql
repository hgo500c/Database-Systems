DROP TABLE IF EXISTS StudentCourses
DROP TABLE IF EXISTS Students
DROP PROCEDURE IF EXISTS [put the name of your stored procedure here when you have it]

create Table Students(
StudentId      int     primary key     IDENTITY,  
StudentName    nvarchar(30)            not null,
StudentYear   int            not null,
)
create Table StudentCourses(

StudentId  int FOREIGN KEY REFERENCES dbo.Students(StudentId),
CourseId int FOREIGN KEY REFERENCES dbo.Courses(CourseId)
)

/*bulk insert dbo.StudentCourses
from 'c:\temp\StudentCourses.txt'
with(
FIELDTERMINATOR ='\t',
ROWTERMINATOR ='\n',
FIRSTROW =2,
keepIdentity 
)
bulk insert dbo.Students
from 'c:\temp\Students.txt'
with(
FIELDTERMINATOR ='\t',
ROWTERMINATOR ='\n',
FIRSTROW =2,
keepIdentity 
)
*/
DECLARE @xml AS XML = '<Process>
	<addStudent name="Cindy Boo" year="2019" />
	<addStudent name="Sammy Sam" year="2018" />

	<addStudentCourse studentId="3" courseId="45" />
	<addStudentCourse studentId="3" courseId="30" />
	<addStudentCourse studentId="3" courseId="96" />

	<dropStudent studentId="411" courseId="119" />
<dropStudent studentId="696" courseId="33" />

	<updateStudent studentId="5" newName="Tim Tim" year="2017" />
</Process>'
--=================================================================insert inofrmation 

insert into dbo.StudentCourses(StudentId,CourseId)
select sc.value ('@studentsId', 'INT'),
        sc.value('@courseId','INT')
		FROM @xml.nodes('/Process/addStudentCourse') foo(sc)
		
		
insert into Students(StudentName,StudentYear)
select student.value ('@studentName', 'varchar(50)'),
        student.value('@year','INT')
		FROM @xml.nodes('/Process/addStudent') foo(student)

delete from StudentCourses where studentID In (
select studentcourses.value('@studentId','int')
from @xml.nodes('/process/dropStudents') foo(studentCourses)
)and
courseId in (
select StudentCourse.value('courseId','int')
from @xml.nodes('/process/dropStudents')  foo(studentCourses)
)

update 

--===========================question 4
select top(3)
i.Name,
i.City,



		









