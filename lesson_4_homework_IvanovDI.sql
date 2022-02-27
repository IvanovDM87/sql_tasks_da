--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task13 (lesson3)
--������������ �����: ������� ������ ���� ��������� � ������������� � ��������� ���� �������� (pc, printer, laptop). 
--�������: model, maker, type

select model, maker, type  
from product

--task14 (lesson3)
--������������ �����: ��� ������ ���� �������� �� ������� printer ������������� ������� ��� ���, 
--� ���� ���� ����� ������� PC - "1", � ��������� - "0"

select *, 
case
when pr.price > (select avg(p.price) from pc p)
then 1
else 0
end price_avg_pc
from printer pr

--task15 (lesson3)
--�������: ������� ������ ��������, � ������� class ����������� (IS NULL)

select ships.name, classes.class 
from ships
join classes
on ships.class = classes.class 
where classes.class is null

--task16 (lesson3)
--�������: ������� ��������, ������� ��������� � ����, �� ����������� �� � ����� �� ����� ������ �������� �� ����.

select distinct b.name, b.date
from battles b
where year(b.date) not in 
(
	select s.launched
	From ships s
	Where s.launched is not null
)

--task17 (lesson3)
--�������: ������� ��������, � ������� ����������� ������� ������ Kongo �� ������� Ships.

select distinct a.name, a.ship, s.class
from 
(
select *
from battles b
join outcomes o 
on o.battle = b.name
) as a
join ships s 
on a.ship = s.name
where s.class = 'Kongo'

--task1  (lesson4)
-- ������������ �����: ������� view (�������� all_products_flag_300) ��� ���� ������� (pc, printer, laptop) 
-- � ������, ���� ��������� ������ > 300. �� view ��� �������: model, price, flag

create view all_products_flag_300 as
select model, price, 
case 
when t1.price > 300
then 1
else 0
end flag
from 
(
select model, price
from pc
union all

select model, price
from printer
union all

select model, price
from laptop
) as t1

select *
from all_products_flag_300

--task2  (lesson4)
-- ������������ �����: ������� view (�������� all_products_flag_avg_price) ��� ���� ������� (pc, printer, laptop) 
-- � ������, ���� ��������� ������ c������ . �� view ��� �������: model, price, flag

create view all_products_flag_avg_price as
select t1.model, t1.price, 
case 
when t1.price > (select avg(t2.price) from (
select model, price
from pc
union all

select model, price
from printer
union all

select model, price
from laptop
) as t2)
then 1
else 0
end flag
from 
(
select model, price
from pc
union all

select model, price
from printer
union all

select model, price
from laptop
) t1

select *
from all_products_flag_avg_price

--task3  (lesson4)
-- ������������ �����: ������� ��� �������� ������������� = 'A' �� ���������� ���� ������� �� ��������� ������������� = 'D' � 'C'. 
-- ������� model

select prd.model
from printer pr
join product prd
on pr.model = prd.model
where maker = 'A' and price > 
(
select avg(price)
from printer pr
join product prd
on pr.model = prd.model
where maker = 'D' or maker = 'C')

--task4 (lesson4)
-- ������������ �����: ������� ��� ������ ������������� = 'A' �� ���������� ���� ������� �� ��������� ������������� = 'D' � 'C'. 
-- ������� model

select prd.model, price
from printer pr
join product prd
on pr.model = prd.model
where maker = 'A' and price > 
(
select avg(price)
from printer pr
join product prd
on pr.model = prd.model
where maker = 'D' or maker = 'C')
union all

select pc.model, price
from pc
join product prd
on pc.model = prd.model
where maker = 'A' and price > 
(
select avg(price)
from printer pr
join product prd
on pr.model = prd.model
where maker = 'D' or maker = 'C')
union all 

select lt.model, price
from laptop lt
join product prd
on lt.model = prd.model
where maker = 'A' and price > 
(
select avg(price)
from printer pr
join product prd
on pr.model = prd.model
where maker = 'D' or maker = 'C')

--task5 (lesson4)
-- ������������ �����: ����� ������� ���� ����� ���������� ��������� ������������� = 'A' (printer & laptop & pc)

with t1 as 
			(
select distinct *
from pc
join product p
on pc.model = p.model
where maker = 'A'
), 
t2 as 
(
select distinct * 
from printer p2 
join product p
on p2.model = p.model
where maker = 'A'
),
t3 as 
(
select distinct * 
from laptop l  
join product p
on l.model = p.model
where maker = 'A'
)

select avg(t4.price)
from 
(
select price from t1
union all
select price from t2
union all 
select price from t3
) as t4

--task6 (lesson4)
-- ������������ �����: ������� view � ����������� ������� (�������� count_products_by_makers) �� ������� �������������. 
-- �� view: maker, count

create view count_products_by_makers as
(
select t1.maker as mkr, sum(t1.cnt) as cn
from (
select maker, count(code) cnt
from printer pr
join product prd 
on pr.model = prd.model
group by prd.maker
union all

select maker, count(code) cnt
from pc
join product prd 
on pc.model = prd.model
group by prd.maker
union all

select maker, count(code) cnt
from laptop ltp
join product prd 
on ltp.model = prd.model
group by prd.maker
) as t1
group by t1.maker
order by t1.count
)

select *
from count_products_by_makers

--task7 (lesson4)
-- �� ����������� view (count_products_by_makers) ������� ������ � colab (X: maker, y: count)

--���� T7_lesson4.ipynb


--task8 (lesson4)
-- ������������ �����: ������� ����� ������� printer (�������� printer_updated) � ������� �� ��� ��� �������� ������������� 'D'

create table printer_updated as table printer

delete from printer_updated pru
where pru.model in (select pr.model
from printer pr
join product p
on pr.model = p.model
where maker = 'D')

select *
from printer_updated pru

--task9 (lesson4)
-- ������������ �����: ������� �� ���� ������� (printer_updated) view � �������������� �������� ������������� 
-- (�������� printer_updated_with_makers)

create view printer_updated_with_makers as 

(
select pru.*, maker
from printer_updated pru
join product p
on pru.model = p.model
)

select *
from printer_updated_with_makers

--task10 (lesson4)
-- �������: ������� view c ����������� ����������� �������� � ������� ������� (�������� sunk_ships_by_classes). 
-- �� view: count, class (���� �������� ������ ���/IS NULL, �� �������� �� 0)

create view sunk_ships_by_classes as 

select t1.class as cl , count(t1.result) as cnt
from 
(
select class, result 
from classes c
left join outcomes o
on o.ship = c.class
where result = 'sunk'
union all 

select class, result
from outcomes o
left join ships s
on o.ship = s.name
where result = 'sunk'
) as t1
group by t1.class

update sunk_ships_by_classes
set class = '0'
where class is null

--task11 (lesson4)
-- �������: �� ����������� view (sunk_ships_by_classes) ������� ������ � colab (X: class, Y: count)

-- ���� �� �������� T11_lesson4.ipynb

--task12 (lesson4)
-- �������: ������� ����� ������� classes (�������� classes_with_flag) � �������� � ��� flag: 
-- ���� ���������� ������ ������ ��� ����� 9 - �� 1, ����� 0

create table classes_with_flag as table classes

select cwf.*, case 
when numguns >= '9'
then 1
else 0
end flag
from classes_with_flag as cwf

--task13 (lesson4)
-- �������: ������� ������ � colab �� ������� classes � ����������� ������� �� ������� (X: country, Y: count)

select country ctr, count(class) cnt
from classes
group by country 
order by cnt

--task14 (lesson4)
-- �������: ������� ���������� ��������, � ������� �������� ���������� � ����� "O" ��� "M".

select count(*)
from 
(
select name
from ships
union
select ship
from outcomes
) as t1
where t1.name like 'O%' or name like 'M%'

--task15 (lesson4)
-- �������: ������� ���������� ��������, � ������� �������� ������� �� ���� ����.

select count(*)
from 
(
select name
from ships
union
select ship
from outcomes
) as t1
where t1.name like '% %'

--task16 (lesson4)
-- �������: ��������� ������ � ����������� ���������� �� ���� �������� � ����� ������� (X: year, Y: count)

select launched ln, count(class) cnt
from ships
group by launched 
order by launched 


