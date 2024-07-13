--1
select job_title,max_salary-min_salary salary_diff from hr.jobs
where max_salary between 12000 and 18000;
--2
select * from hr.employees
where commission_pct is null and
salary between 7000 and 12000
and department_id in (50,30,80);
--3
select first_name||' '||last_name,hire_date,commission_pct,email||'-'||phone_number,salary
from hr.employees
where salary>11000
order by 1 desc;
--4
select first_name,last_name,salary,hire_date from hr.employees
where first_name like '%m' and hire_date<'05-june-2010';
--5
select first_name||'-'||last_name as full_name,hire_date,email||'-'||phone_number contact_details,salary
from hr.employees
where salary not between 9000 and 17000
and commission_pct is not null;
--6
select * from departments
where department_id=20;
--7
select * from hr.job_history
order by employee_id desc, start_date asc;
--8
select job_id, salary from hr.employees
where (phone_number like '515%'
or phone_number like '590%')
and hire_date>'31-dec-2003'
order by hire_date asc, salary asc;
--9
select * from hr.employees
where hire_date like '%01';
--10
select * from hr.employees where hire_date not like '%06' and hire_date not like '%07';
--11
select * from hr.employees
where hire_date like '%07' or hire_date like '%-JAN-%';
--12
select * from hr.employees
where hire_date>'31-DEC-07' or salary<10000;
