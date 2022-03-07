--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1 (lesson5)
-- Компьютерная фирма: Сделать view (pages_all_products), в которой будет постраничная разбивка всех продуктов 
--(не более двух продуктов на одной странице). Вывод: все данные из laptop, номер страницы, список всех страниц

sample:
1 1
2 1
1 2
2 2
1 3
2 3

select *, 
      case when num % 2 = 1 then 1 else 2 end as num_in_page,
      case when num % 2 = 0 then num/2 else num/2 + 1 end as page_num
from (
     select *, row_number() over(order by price desc) as num
      from Laptop
) X

--task2 (lesson5)
-- Компьютерная фирма: Сделать view (distribution_by_type), в рамках которого будет процентное соотношение 
-- всех товаров по типу устройства. Вывод: производитель, тип, процент (%)

with t1 as
(
select maker, type, t2.model
from
(
select model
from pc
union all
select model
from printer
union all
select model
from laptop
) t2
join product p
on p.model = t2.model 
)
select distinct maker, type, 100*(count(*) over (partition by maker, type)::float / count(maker) over())::float as part
from t1
order by maker, type

--task3 (lesson5)
-- Компьютерная фирма: Сделать на базе предыдущенр view график - круговую диаграмму. Пример https://plotly.com/python/histograms/

--Файл во вложении

--task4 (lesson5)
-- Корабли: Сделать копию таблицы ships (ships_two_words), но название корабля должно состоять из двух слов

create table ships_two_words as 
(
select *
from ships
where name like '% %'
)

select *
from ships_two_words

--task5 (lesson5)
-- Корабли: Вывести список кораблей, у которых class отсутствует (IS NULL) и название начинается с буквы "S"

select ship, class
from outcomes o
left join ships s 
on o.ship = s.name
where class is null and ship like 'S%'

--task6 (lesson5)
-- Компьютерная фирма: Вывести все принтеры производителя = 'A' со стоимостью выше средней по принтерам производителя = 'C' 
-- и три самых дорогих (через оконные функции). Вывести model

select p.model, rank (*) over (order by price desc) as top
from printer p
join product p2
on p.model = p2.model
where maker = 'A' and price > 
(
select 
case when avg(price) is null
then 0 
else (select avg(price) from printer p
join product p2
on p.model = p2.model
where maker = 'C')
end avg
from printer p
join product p2
on p.model = p2.model
where maker = 'C'
)