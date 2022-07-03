--Requetes diverses:

-- 68- Affichez le nom, la ville et le pays de tous les clients dont le
-- représentant est Andres Damerons.
select name, city, country 
from s_customer c, s_emp e
where c.sales_rep_id=e.id AND e.last_name='Dameron' and e.first_name='Andre';

-- 69- Trouver les employes percevant les plus bas salaires.
select last_name, first_name
from s_emp
where salary=(select min(salary) from s_emp);

-- 70- Affichez le nom de tous les départements qui ont au moins un employé.
select d.name
from s_dept d, s_emp e
where d.id=e.dept_id;

-- 71- Affichez le nom et le prénom de tous les employés qui n'ont pas de clients
select last_name, first_name
from s_emp e, s_customer c
where e.id NOT IN(select distinct sales_rep_id from s_customer);

-- 72- Y a-t-il un pays pour lequel il n'y a pas de représentant? si c'est
-- le cas, affichez le nom du pays.
select country 
from s_customer 
where sales_rep_id IS NULL;
