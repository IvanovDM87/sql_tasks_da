--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing

--task1
--Корабли: Для каждого класса определите число кораблей этого класса, потопленных в сражениях. 
--Вывести: класс и число потопленных кораблей.

select c.class, count(s.ship)
from classes c
left join
(
  select o.ship, sh.class
  from outcomes o
  left join ships sh on sh.name = o.ship
  where o.result = 'sunk'
) 
	as s on s.class = c.class or s.ship = c.class
group by c.class


--task2
--Корабли: Для каждого класса определите год, когда был спущен на воду первый корабль этого класса. Если год спуска на воду головного корабля неизвестен, определите минимальный год спуска на воду кораблей этого класса. Вывести: класс, год.

select class, min(launched)
from ships 
group by class 


--task3
--Корабли: Для классов, имеющих потери в виде потопленных кораблей и не менее 3 кораблей в базе данных, 
--вывести имя класса и число потопленных кораблей.

with w1 as 
(
select c.class, count(s.ship) as sunk
from classes c
join
(
  select o.ship, sh.class
  from outcomes o
  join ships sh on sh.name = o.ship
  where o.result = 'sunk'
) 
	as s on s.class = c.class or s.ship = c.class
group by c.class
)

select w1.class, w1.sunk, cname
from w1
join 
(
	select class, count(name) as cname
	from ships
	group by class
) as t1
on w1.class = t1.class
where w1.sunk > 0 and cname > 3

--task4
--Корабли: Найдите названия кораблей, имеющих наибольшее число орудий среди всех кораблей такого же водоизмещения 
--(учесть корабли из таблицы Outcomes).


with dsShips as
(
select name, class
from ships s
union
select o.ship, s.class
from outcomes o
join ships s on o.ship = s.name
)
select s.name
from dsShips s, classes c
where s.class = c.class 
and
c.numGuns >= all
(
select c1.numGuns
from Classes c1
where c1.class in 
(
select dsShips.class 
from dsShips
) 
and
c.displacement = c1.displacement
)

--task5
--Компьютерная фирма: Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM 
--и с самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker

select t1.maker
from product t1 
join pc t2
on t1.model = t2.model 
join
(
select distinct maker
from product
where type = 'Printer'
) t3
on t1.maker = t3.maker
where ram = (select min(ram) from pc)
and speed = 
(
select max(speed)
from pc
where ram = (select min(ram) from pc)
)

