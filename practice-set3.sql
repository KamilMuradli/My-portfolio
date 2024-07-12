--1
select * from hr.employees  
where hire_date like '%MAY%';
--2
SELECT * 
FROM employees 
WHERE EXTRACT(YEAR FROM hire_date) = EXTRACT(YEAR FROM SYSDATE);
--3
SELECT ROUND(SYSDATE - TO_DATE('2011-01-01', 'YYYY-MM-DD'),2) AS DaysDifference FROM dual;

SELECT * 
FROM hr.employees 
ORDER BY hire_date DESC 
FETCH FIRST 1 ROW ONLY;
--4
select max(salary) maximum_salary from hr.employees;
--5
select DEPARTMENT_NAME,DEPARTMENT_ID, count(EMPLOYEE_ID) from hr.employees EMP  
LEFT JOIN HR.DEPARTMENTS DEP DEP.DEPARTMENT_ID=EMP.DEPARTMENT_ID 
group by DEPARTMENT_NAME,DEPARTMENT_ID;
--6
SELECT COUNT(*) AS NumberOfEmployees  
FROM hr.employees  
WHERE EXTRACT(DAY FROM hire_date) > 15;
--7
select department_id,avg(salary) from hr.employees 
group by department_id 
having commission_pct is not null;
--8
select job_id from hr.employees  
group by job_id  
HAVING AVG(salary)>10000;
--9
select job_id, count(employee_id),sum(salary),max(salary)-min(salary) from hr.employees  
group by job_id;
--10
select MANAGER_ID,count(employee_id) from hr.employees  
group by manager_id;

