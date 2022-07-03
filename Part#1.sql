--1. Modifier le n de Tel et le nom de la ville du client BJ Athletics. 
--Les nouvelles modifications: tel=407-345-1265 et city=Melbourne.
Update S_customer
set phone="407-345-1265" , city="Melbourne"
where Name='BJ Athletics'

--Note that we place a ',' between changes in the update operation instead of the 
--operator 'AND'.

-- 2- Augmenter tous les salaires de 1000
update S_emp
set salary=salary+1000;

-- 3- Affichez les titres des employés
select distinct title
from s_emp;

-- 4- Supprimer table X
delete ....;

-- 5- Recherchez les employés du département 41
select *
from s_emp
where dept_id=41;

-- 6- Recherchez les employés du département 41. les ordonner par ordre croissant 
-- de leur nom de familles
select * 
from s_emp
where dept_id=41
order by last_name Asc;

-- To note that Order by is Asc by default.

-- 7- Recherchez tous les employés qui ont commence le 3/3/1990
select * 
from s_emp
where start_date='1990-03-03';

-- 8- Recherchez tous les employés qui ont commence après 3/3/1990
select *
from s_emp
where start_date>'1990-03-03';

-- 9- Recherchez lastName comme nom Famille, firstName comme prénom qui ont 
-- commence après 3/3/1990.
select last_name as "Nom de Famille", first_name as "Prénom"
from s_emp
where start_date > '1990-03-03';

--Note that it's better to place double quotes instead of one since it's a string value
-- Even tho single quotes work lol!

-- 10- Affichez toute la table
select *
from s_emp;

-- 11- Affichez nom et prénom et nom département de tous les employés
select e.last_name, e.first_name, d.name
from s_emp e, s_dept d
where e.dept_id=d.id;

-- A noter que c'est une simple jointure au niveau de l'attribut dept_id, afin de
-- retourner le nom du departement avec le nom et prénom de l'employer. La notation
-- e.last_name signifie l'attribut last_name de la table s_emp de l'employe e.

-- 12- Affichez Id, total et date des commandes du client 204.
select id, total, date_ordered
from s_ord
where customer_id=204;

-- 13- Affichez nom et prénom, titre et salaire de tous les "Managers"
select last_name as "Nom" , first_name as "Prénom", title, salary
from s_emp 
where id IN(select distinct manager_id from s_emp);

--On ajoute avant tout le code suivant, afin de compléter la table:
update s_emp
set manager_id=1
where id IN(1,10,11,12,13,14);

update s_emp
set manager_id=2
where id IN(15,16,17,18,19);

update s_emp
set manager_id=3
where id IN(2,3,4,5,6,7,8,9);

-- 14- Affichez nom et prénom, titre et salaire et commissions de tous les "Représentant"
select last_name, first_name, salary, title, commission_pct
from s_emp
where title='Sales Representative';

-- 15- Affichez les noms des départements dans chaque région. Ordonnez les résultats 
-- par région. C'est le cas d'une simple jointure entre 2 table s_dept et s_region

select r.name as "Region Name", d.name as "Department name"
from s_dept d, s_region r
where d.region_id=r.id

--Before executing the code in quesion 15 please add the following:
create table s_region(
  id int NOT NULL PRIMARY KEY,
  name varchar(50) NOT NULL
);

insert into s_region values(3,'Africa/Middle East');
insert into s_region values(4,'Asia');
insert into s_region values(6,'Central America/Carribean');
insert into s_region values(5,'Europe');
insert into s_region values(1,'North America');
insert into s_region values(2,'South America');

-- Chapitre 3: Operateurs booléens
-- 16- Affichez les noms des clients de la ville Lancaster qui sont crédités "EXCELLENT"
select name 
from s_customer
where city='Lancaster' AND credit_rating='EXCELLENT';

-- 17- Affichez les clients qui sont crédités "Excellents" et dont le ID du representant_client est 12
select *
from s_customer
where credit_rating="EXCELLENT" and sales_rep_id=12;

-- 18- Affichez les clients qui sont crédités "Excellents" OU 'GOOD'
select *
from s_customer
where credit_rating='EXCELLENT'or credit_rating='GOOD';

select *
from s_customer
where credit_rating IN('GOOD','EXCELLENT');

-- 19- Affichez les clients qui ne sont pas sur un code ville 22808
select *
from s_customer
where zip_code<>22808;

--Methode 2:
select *
from s_customer
where zip_code!=22808;

-- 20- Affichez nom du client comme "NOM CLIENT" dont son représentant est 14 et son code postale a 22808
select name as "NOM CIENT"
from s_customer
where sales_rep_id=14 and zip_code='22808';

-- 21- Affichez nom du client comme "NOM CLIENT"  ayant un code postale=22808 et de taux crédité est "Good" ou bien qui a le représentant 14
select name as "NOM CLIENT"
from s_customer
where zip_code="22808" and (Credit_rating="GOOD" or sales_rep_id=14);

-- 22- Affichez nom du client dont le nom commence par 'Athl'
select name 
from s_customer
where name like "Athl%";

-- 23- Affichez ID, nom et phone dont les IDs des clients sont entre 303 et 306 utilisez L'OPERATEUR BETWEEN
select id, name, phone
from s_customer
where id BETWEEN 303 AND 306

-- 24- Affichez ID, noms et phones du client ou les noms finissent par e. 
select id, name, phone
from s_customer
where name like '%e';

-- 25- Affichez les ID, nom et phone des clients  dont les id sont soit 303 soit 305, soit 403 soit 406

select name, id
from s_customer
where id IN(303,305,403,406);

-- 26- Affichez les ID, nom et phone des clients dont les id sont différents de 303 ou de 305 ou de 403 ou de 406
select id, name, phone
from s_customer
where id<>303 and id<>305 and id<>403 and id<>406;

-- M2:
select id, name, phone
from s_customer
where id NOT IN(303,305,403,406);

-- 27- Affichez les ID, les noms de famille ainsi que les salaires des employés du département ID 41 et dont les salaires dépassent le 1000$
select id, last_name, first_name, salary
from s_emp
where dept_id=41 and salary>1000;

-- 28- Affichez titre, nom de famille, et prénom des employés qui n'ont pas de manager ou ayant le manager id =1 ou 2. Ordonner les résultats par titre.
select title, last_name, first_name
from s_emp
where manager_id IS NULL or Manager_id=1 or Manager_id=2
order by title;

-- 29- Affichez les titres et les noms des familles, les prénoms ainsi que les manager ID des employés dont les prénoms finissent par 'e'.
select title, last_name, first_name, manager_id
from s_emp
where first_name like '%e';

-- 30- Affichez les noms des clients et les noms de leurs représentants et dont les noms des représentants commencent par H
select c.name, e.last_name, e.first_name
from s_emp e, s_customer c
where e.id=c.sales_rep_id and last_name like 'H%';

-- 31- Affichez les noms des clients, leurs régions et leurs noms de représentants des clients de solvabilité faible
select c.name, region_id, e.last_name, e.first_name, r.name
from s_customer c, s_emp e, s_region r
where c.region_id=r.id and c.sales_rep_id=e.id AND credit_rating='POOR';

-- Note that on a réaliser une jointure entre 3 tables car on veut le nom du représentant et celui de la région aussi, or on a seulement l'ID dans la table customer.

--ch.4 opération Arithmétiques et fonctions intégrées

-- 32- Affichez les iDs la quantité en stock et la quantité en stock augmenté de 100 à l'entrepôt 101.
select product_id, amount_in_stock, amount_in_stock+100
from s_inventory
where warehouse_id=101;

-- 33- Affichez les ID et le résultat de la différence entre le max en stock et la quantité en stock de l'entrepôt 101
select product_id, (max_in_stock)-(amount_in_stock)
from s_inventory
where warehouse_id=101;

-- 34- Affichez ID des produits, la quantité en stock, et la différence entre point de commande et la quantité en stock
select product_id, amount_in_stock, (reorder_point-amount_in_stock)
from s_inventory

-- Fonction Integrees(ABS(m),MOD(m,n), POWER (m,n), ROUND(m,[n]), Trunc(m [,n]) avec imbrication

-- 35- Affichez les id des produits,la quantite en stock, le point de restockage et le resultat absolu de la difference entre le point de restockage et la 
-- quantite en stock des stores id 201 et des produits 20106 ou de produit 201108
select product_id, amount_in_stock, reorder_point, abs(reorder_point-amount_in_stock)
from s_inventory
where warehouse_id=201 and (product_id=20106 or product_id=201108);

-- 36- Affichez les id des produits, la quantité en stock, le point de restockage et le résultat arrondi à Zéro de la différence entre 
-- le point de restockage et la quantité en stock des stores id 201 et des produits 20106 ou de produit 201108 
select product_id, amount_in_stock, reorder_point, round(reorder_point-amount_in_stock,0)
from s_inventory
where warehouse_id='201' and (product_id='20106' or product_id='201108');

-- 37- Affichez sous deux colonnes Nom, Nom, mais dans le deuxieme colonne remplacer 'ATHL' avec 'ASC'
select name, replace(name,'Athl','ASC') As "Nom de remplacement"
from s_customer; 

--ch.5 Fonctions de groupes: AVG([DISTINCT/ALL]), COUNT(ALL), COUNT(DISTINCT), MAX(DISTINCT/ALL),MIN(DISTINCT/ALL),SUM(DISTINCT/ALL), 
-- COUNT, MAX, MIN, SUM et AVG ignores NULL values

-- 38- Affichez la somme, la moyenne des prix de la table item
select sum(price) "total price",avg(price) "average price"
from s_item;

-- 39- Affichez la somme, la moyenne des prix de la table item  de l'ordre id 100
select sum(price) "total price",avg(price) "average price"
from s_item
where ord_id=100;

-- 40- Affichez la somme et la moyenne des salaires des employes
select sum(salary), avg(salary)
from s_emp;

-- 41- Affichez le maximum et le minimum des employes
select max(salary), min(salary)
from s_emp;

-- 42- Affichez le maximum et le minmum des prix de la table item
select max(price),min(price)
from s_item;

-- 43- Affichez le nombre des items commandes de la commande 100
select count(*)
from s_item
where ord_id=100;

-- 44- Affichez le nombre des items commandes et les.....
select count(*), count(distinct(product_id))
from s_item;

--GROUP BY and HAVING--
-- 45- Affichez Numéro commande, Nombre de produits demande et Total vendu par commande
select ord_id,count(product_id) "nombre prod commande", sum(quantity*price) "Total Facture"
from s_item
group by ord_id;

-- 46- Affichez Numéro produit, Moyenne des prix vendus groupe par Numéro de  produit
select product_id,avg(price) "average price"
from s_item
group by product_id;
