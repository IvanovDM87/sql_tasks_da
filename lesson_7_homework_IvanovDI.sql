--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1  (lesson7)
-- sqlite3: Сделать тестовый проект с БД (sqlite3, project name: task1_7). В таблицу table1 записать 1000 строк с случайными значениями (3 колонки, тип int) от 0 до 1000.
-- Далее построить гистаграмму распределения этих трех колонко

--task2  (lesson7)
-- oracle: https://leetcode.com/problems/duplicate-emails/

select email 
from Person 
group by Email 
having count(email) > 1

--task3  (lesson7)
-- oracle: https://leetcode.com/problems/employees-earning-more-than-their-managers/

select e.name
from employee e,
(
select *
from employee
where id in
(
select managerId
from employee
)) a
where e.salary > a.salary
and e.managerId = a.id

--task4  (lesson7)
-- oracle: https://leetcode.com/problems/rank-scores/

select s.Score, dense_rank() over(order by s.Score desc) as Ranking
from Scores s

--task5  (lesson7)
-- oracle: https://leetcode.com/problems/combine-two-tables/

select firstName, lastName, city, state
from Person p
left join Address a
on p.personId = a.personId
