--1
--a Find all courses worth more than 3 credits;
select *
from course
where credits > 3;
--b Find all classrooms situated either in ‘Watson’ or ‘Packard’ buildings;
select *
from classroom
where building = 'Watson'
   or building = 'Packard';
--c Find all courses offered by the Computer Science department;
select *
from course
where dept_name = 'Comp. Sci.';
--d Find all courses offered during fall;
select *
from course
where course_id in (select course_id
                    from section
                    where section.semester = 'Fall');
--e Find all students who have more than 45 credits but less than 90;
select *
from student
where tot_cred > 45
  and tot_cred < 90;
--f Find all students whose names end with vowels;
Select *
from student
where name like '%a'
   or name like '%e'
   or name like '%u'
   or name like '%i'
   or name like '%o';
--g Find all courses which have course ‘CS-101’ as their prerequisite;
select *
from course
where course_id in (select course_id from prereq where prereq_id = 'CS-101');
--2
--a For each department, find the average salary of instructors in that department and list them in ascending order.
-- Assume that every department has at least one instructor;
select dept_name, avg(salary)
from instructor
group by dept_name;
--b Find the building where the biggest number of courses takes place;
select building
from section
group by building
limit 1;
--c Find the department with the lowest number of courses offered;
select dept_name
from course
group by dept_name
order by count(*) asc nulls last
limit 1;
--d Find the ID and name of each student who has taken more than 3 coursesfrom the Computer Science department;
select *
from student
where id = (select id
            from takes
            group by id
            having count(*) > 3)
  and dept_name = 'Comp. Sci.';
--e Find all instructors who work either in Biology, Philosophy, or Musicdepartments;
select *
from instructor
where dept_name = 'Biology'
   or dept_name = 'Philosophy'
   or dept_name = 'Music';
--f Find all instructors who taught in the 2018 year but not in the 2017 year;
select id
from teaches
where year = 2018
  and id not in (select id from teaches where year = 2017);
--3
--a Find all students who have taken Comp. Sci. course and got an excellent grade (i.e., A, or A-) and sort them alphabetically;
select id, name
from student
where id in (select id from takes where course_id like 'CS-%' and (grade = 'A' or grade = 'A-'))
order by name;
--b Find all advisors of students who got grades lower than B on any class;
select *
from takes;
select *
from advisor
where s_id in (select id
               from takes
               where (not takes.grade = 'A' or not takes.grade = 'A-' or not takes.grade = 'B+' or
                      not takes.grade = 'B'));
--c Find all departments whose students have never gotten an F or C grade;
select dept_name
from course
where course_id in (select course_id
                    from takes
                    where (grade != 'F'
                        and grade != 'C'));
--d Find all instructors who have never given an A grade in any of the courses they taught;
select *
from instructor
where dept_name in (select dept_name from course where course_id in (select course_id from takes where grade != 'A'));
--e Find all courses offered in the morning hours (i.e., courses ending before13:00);
select *
from course
where course_id in (select course_id
                    from section
                    where time_slot_id in (select time_slot_id from time_slot where end_hr < 13));
