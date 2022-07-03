-- 46- Affichez Numéro produit, Moyenne des prix vendus groupe par Numéro de  produit
select product_id, avg(price)
from s_item
group by product_id;

-- 47- Affichez pour chaque Numéro produit le nombre des commandes et la quantité vendue 
select product_id,count (ord_id) "nombre des commandes",sum(quantity) "total vendu"
from s_item
group by product_id;

-- 48- Affichez pour chaque Numéro produit le nombre des commandes et la quantité vendue uniquement pour les commandes 100,101,102,103 et 104
select product_id, count(ord_id) as 'Nombre de commandes', sum(quantity) as 'quantité vendue'
from s_item
where ord_id IN(100,101,102,103,104)
group by product_id;

-- Note du prof: Quand la question contient: 'N'affichez que etc....' c'est le cas d'un filtrage de données, après réalisation de l'opération, le système va filtrer les données
-- de facon a obtenir seulement les données qui respectent la condition dans la question, on utilise la commande 'having' 
-- Quand la question contient la phrase: "Pour chaque etc.." on applique la commande group by.
-- La commande 'having' comes after the 'group by' command.

-- 49- Affichez pour chaque commande les totaux. N'affichez que les totaux qui sont supérieurs à 15000.Utilisez la table s_item.
select ord_id, sum(quantity*price)
from s_item
group by ord_id
having sum(quantity*price)>15000;

-- 50- 50- Recherchez pour chaque manager de tout les départements sauf pour les départements 33,35,41,44,50, le nombre des salaries dont ils sont responsables, N'affichez les résultats que pour les managers qui sont responsables de 3 employés et au delà.
select manager_id, count(*)
from s_emp 
where dept_id NOT IN(33,35,41,44,50)
group by manager_id
having count(*)>=3
order by manager_id desc;

-- 51- Affichez pour chaque département le nombre des employés
select dept_id, count(*)
from s_emp
group by dept_id

-- Méthode 2:
select d.name,count(e.id)
from s_emp e,s_dept d
where e.dept_id=d.id
group by d.name;

-- 52- Affichez pour chaque département le nombre des employés, la somme des salaires et la moyenne des salaires arrondie à zéro
select dept_id, count(id) "nbre emp", sum(salary) "total salaire",round(avg(salary),0) "moyenne salaire"
from s_emp
group by dept_id;

-- 53- Affichez pour chaque région et pour chaque département le nombre des employés
select r.name "nom Region",d.name "nom departement",count(e.id)
from s_region r,s_dept d,s_emp e
where d.region_id=r.id and e.dept_id=d.id
group by r.name, d.name
order by r.name

-- 54- Affichez pour chaque région et pour chaque département le nombre des employés, mais ayant un minimum des 2 employés
select r.name "nom Region",d.name "nom departement",count(e.id)
from s_region r,s_dept d,s_emp e
where d.region_id=r.id and e.dept_id=d.id
group by r.name, d.name
having count(e.id)>=2
order by r.name

-- ch6. Traitements des informations de date et Heure:
-- select MONTH(start_date) 
-- select DAY(start_date)
-- YEAR(SYSDATETIME()) - Year(start_date)
-- getdate()

-- 55- Affichez pour chaque employé la date d'entrée au travail et le nombre d'année de travail
select start_date, year(getdate())-year(start_date) as 'Nombre d année d emploi'
from s_emp
group by id;

--Méthode 2:
select last_Name,first_name,start_date,YEAR(SYSDATETIME()) - YEAR(start_date) AS "nombre annee"
from s_emp;

-- 56- Affichez la date d’entree et le nombre d'années de travail du Président.
select start_date, year(getdate())-year(start_date) as 'Nombre d année d emploi'
from s_emp
where title='Président'
group by id;

-- ch.7 Requêtes complexes

-- 57- Affichez nom, prenom et salaire des employes ayant un salaire superieur a la moyenne des salaires
select last_name, first_name, salary
from s_emp e
where salary>(select avg(salary) from s_emp);

-- 58- Affichez les noms des departements dans lesquels il y a des employes
select distinct d.name
from s_emp e, s_dept d
where e.dept_id=d.id

-- 59- Affichez nom,prenom departement et titre des employes dont le titre contient les caracteres VP.
select e.last_name, e.first_name, d.name, e.title
from s_emp e, s_dept d
where e.dept_id=d.id AND e.title like "%VP%";

-- 60- Affichez les noms des employés qui sont au département Sales et dont le salaire est inferieur à la moyenne générale
select e.last_name, d.name, salary
from s_emp e, s_dept d
where e.dept_id=d.id and d.name='Sales' and salary<(select avg(salary) from s_emp);

-- 61- Affichez les noms des employés qui sont au département Sales et dont le salaire est inférieur à la moyenne générale du département Sales.
select first_name,last_name,salary
from s_emp e, s_dept d
where d.name='sales' and salary<(select avg(salary) from s_emp e,s_dept d where d.name='sales' and d.id=e.dept_id ) and 
e.dept_id=d.id;

-----------------------------------------
--------UNION, INTERSECTION, EXCEPT------
-----------------------------------------

-- 62- Affichez le nom de tous les clients de id_region=1 avec les departements qui sont situes dans cet id_region.
select name from s_customer where region_id=1
UNION
select name from s_dept where region_id=1;

-- A noter que dans l'union, l'intersection et la différence doivent contenir des attributs de la meme nature
-- 63- Affichez l’ID des représentants qui ont été affectés à un client.
select distinct sales_rep_id
from s_customer;

-- 64- Certains représentant, encore en formation, n’ont pas encore été affectes a des clients. Affichez les noms de ces représentants
select id 
from s_emp
where title='sales representative'
EXCEPT
select sales_rep_id from s_customer;

--M2:
select ID, last_name, first_name 
from s_emp 
where ID IN(select ID from s_emp EXCEPT select sales_rep_ID from s_customer);

--M3:
select ID, last_name, first_name 
from s_emp 
where ID NOT IN(select sales_rep_ID from s_customer where sales_rep_id Is not null);

-- 65- Ecrivez une requête pour afficher les clients et les représentants qui sont situés ou affectes au Venezuela. Faites appel à l’opérateur UNION
select last_name 
from s_emp e, s_customer c
where c.sales_rep_id=e.id and country='Venezuela'
UNION
select name from s_customer where country='Venezuela';

-- 66- Affichez l’ID des representants pour le Venesuela et la Russie. Faites appel a l’operateur UNION
select sales_rep_id from S_customer
where country='Venezuela'
UNION
select sales_rep_id from s_customer
where country='Russia';

-- Insérer des valeurs dans une table à l’aide de sous-requêtes.

-- Insérer dans la table S_salaire tous les employés de la table s_emp qui travaillent dans dept_id=10. 
-- To move data from one table to another we do the following:
insert into s_salaire
select * from s_emp
where dept_id=45;