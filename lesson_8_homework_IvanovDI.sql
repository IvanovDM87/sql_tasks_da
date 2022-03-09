--task1  (lesson8)
-- oracle: https://leetcode.com/problems/department-top-three-salaries/

select d.name, e.name, e.salary
from employee e 
inner join department d
on e.departmentid = d.id
where 
(
select count(distinct b.Salary) 
from employee e1
where e1.DepartmentId = e.DepartmentId 
and e1.Salary > e.Salary) < 3
 
--task2  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/17
 
select f.member_name, f.status, sum(p.amount*p.unit_price) as costs
from FamilyMembers f
join Payments p 
on p.family_member = f.member_id
where year(p.date) = 2005
group by f.member_id, f.member_name, f.status
 
--task3  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/13
 
select name
from Passenger
group by name
having count(name) > 1 
 
--task4  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38
 
select count(first_name) as count
from student
where first_name = 'Anna'
 
--task5  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/35
 
select count(Classroom) as count 
from Schedule
where date = '2019-09-02'
 
--task6  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38
 
select count(first_name) as count
from Student
where first_name = 'Anna'
 
--task7  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/32
 
select floor(avg(year(current_date) - year(birthday))) as age
from FamilyMembers
 
--task8  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/27
 
select good_type_name, sum(amount*unit_price) as costs
from GoodTypes gt
join Goods g
on gt.good_type_id = g.type
join Payments p
on g.good_id=p.good
where year(p.date)=2005
group by good_type_name
 
--task9  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/37
 
select min(floor(year(current_date) - year(birthday))) as year
from Student
 
--task10  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/44
 
select max(floor(year(current_date) - year(birthday))) as max_year
from Student s
join Student_in_class sc
on s.id=sc.student
join Class c
on sc.class=c.id
WHERE c.name LIKE '10%'
 
--task11 (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/20
 
select fm.status, fm.member_name, sum(p.amount*p.unit_price) as costs
from FamilyMembers fm
join Payments p
on fm.member_id=p.family_member
join Goods g
on p.good=g.good_id
join GoodTypes gt
on g.type=gt.good_type_id
where good_type_name = 'entertainment'
group by fm.status, fm.member_name
 
--task12  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/55

delete from Company
where Company.id IN 
(
select company 
from Trip
group by company
having count(id) = 
(
select min(count) 
from 
(
select count(id) as count 
from Trip 
group by company) as min_count))
 
--task13  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/45

 
--task14  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/43
 
select last_name
from Teacher t
join Schedule s
on t.id=s.teacher
join Subject sj
on s.subject=sj.id
where sj.name = 'Physical Culture'
order by t.last_name
 
--task15  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/63
