REM   Script: cs_week_2
REM   casestudy

Select  min(salary),max(salary),avg(salary),job_id from  hr.employees 
where (extract(year from  sysdate) - extract(year from  hire_date))>=15 
group by job_id order by 1;

Select  count(*),department_id from  hr.employees  
where extract(year from  hire_date)>2005 
group by department_id ;

Select  department_id ,max(salary),min(salary) from  hr.employees  
group  by  department_id having  (max(salary)-min(salary))>5000;

Select  min(salary),max(salary),avg(salary),job_id from  hr.employees 
where (extract(year from  sysdate) - extract(year from  hire_date))>=15 
group by job_id order by 1;

Select  min(salary),max(salary),avg(salary),job_id from  hr.employees 
where (extract(year from  sysdate) - extract(year from  hire_date))>=15 
group by job_id order by 1;

Select   
sum( 
case  
when  commission_pct is null then  salary 
else 0 
end  
),department_id from  hr.employees group by department_id;

select avg(salary),job_id from hr.employees 
group by job_id 
having avg(salary) between 3000 and 7000;

select count(first_name), first_name from hr.employees 
group by first_name having count(first_name)>1;

select count(first_name), first_name from hr.employees 
group by first_name having count(first_name)>1;

select count(first_name), first_name from hr.employees 
group by first_name having count(first_name)>1;

select count(first_name), first_name from hr.employees 
group by first_name having count(first_name)>1;

select count(first_name), first_name from hr.employees 
group by first_name having count(first_name)>1;

Select  substr(phone_number,1,3),count(*) from  hr.employees  
where department_id in (50,90)  
group by substr(phone_number,1,3) 
having count(*)>1 ;

Select  min(salary),max(salary),avg(salary),job_id from  hr.employees 
where (extract(year from  sysdate) - extract(year from  hire_date))>=15 
group by job_id order by 1;

Select  count(*) num_employees,department_id from  hr.employees  
where extract(year from  hire_date)>2005 
group by department_id ;

Select  department_id ,max(salary),min(salary) from  hr.employees  
group  by  department_id having  (max(salary)-min(salary))>5000;

Select   
sum( 
case  
when  commission_pct is null then  salary 
else 0 
end  
),department_id from  hr.employees group by department_id;

select avg(salary),job_id from hr.employees 
group by job_id 
having avg(salary) between 3000 and 7000;

select count(first_name), first_name from hr.employees 
group by first_name having count(first_name)>1;

Select  substr(phone_number,1,3),count(*) from  hr.employees  
where department_id in (50,90)  
group by substr(phone_number,1,3);

Select  substr(phone_number,1,3),count(*) from  hr.employees  
where department_id in (50,90)  
group by substr(phone_number,1,3);

Select  substr(phone_number,1,3),count(*) from  hr.employees  
where department_id in (50,90)  
group by substr(phone_number,1,3);

Select  substr(phone_number,1,3),count(*) from  hr.employees  
where department_id in (50,90)  
group by substr(phone_number,1,3);

Select  substr(phone_number,1,3),count(*) from  hr.employees  
where department_id in (50,90)  
group by substr(phone_number,1,3);

Select  substr(phone_number,1,3),count(*) from  hr.employees  
where department_id in (50,90)  
group by substr(phone_number,1,3) 
having count(*)>1;

select substr(phone_number,1,3) from hr.employees;

Select  substr(phone_number,1,3),count(*) from  hr.employees  
where department_id in (50,90)  
group by substr(phone_number,1,3) 
having count(*)>1;

select substr(phone_number,1,3) from hr.employees;

select substr(phone_number,1,3) from hr.employees 
where department_id in (50,90);

Select  first_name ,  
case 
when  extract(month  from  hire_date) in (1,2,12) then  'Qis' 
when  extract(month  from  hire_date) in (3,4,5) then  'Yaz' 
when  extract(month  from  hire_date) in (6,7,8) then  'Yay' 
else 'Payiz'  end fesiller   
from  hr.employees  ;

Select  count(*),department_id from  hr.employees  
where extract(month  from  hire_date) in (3,4,5.9,10,11) 
group by department_id 
having  count(*)>5 ;

select count(*),department_id from hr.employees 
group by department_id having max(salary)>5000;

Select  first_name, 
substr(first_name,1,1) || 
substr(first_name,-1,1)|| 
substr(first_name,3,length(first_name)-3)|| 
substr(first_name,2,1) 
from  hr.employees ;

Select  first_name, 
substr(first_name,1,1) || 
substr(first_name,-1,1)|| 
substr(first_name,3,length(first_name)-3)|| 
substr(first_name,2,1) 
from  hr.employees ;

Select  count(*),department_id from  hr.employees  
where extract(month  from  hire_date) in (3,4,5.9,10,11) 
group by department_id 
having  count(*)>5;

