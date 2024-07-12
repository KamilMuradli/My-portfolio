/*Display last name, job title of employees who have commission percentage and belongs to
department 30.*/

select last_name, job_title from hr.employees e
left join hr.jobs j on j.job_id=e.job_id
where commission_pct is not null and department_id=30;

/*Display department name, manager name, and salary of the manager for all managers whose
experience is more than 5 years.*/

SELECT 
    dep.department_name,
    m.first_name || ' ' || m.last_name AS manager_name,
    m.salary AS manager_salary
FROM 
    hr.employees e
JOIN 
    hr.employees m ON e.manager_id = m.employee_id
JOIN
    hr.departments dep on m.department_id=dep.department_id
WHERE 
    ROUND((SYSDATE - m.hire_date) / 365) > 5;

/*Display employee name if the employee joined before his manager.
*/
SELECT 
    e.first_name || ' ' || e.last_name AS employee_name
FROM 
    hr.employees e
JOIN 
    hr.employees m ON e.manager_id = m.employee_id
WHERE
     e.hire_date<m.hire_date;

/*Display employee name, job title for the jobs, employee did in the past where the job was
done less than six months.*/

select first_name, job_title
from hr.employees emp
join hr.job_history jh on jh.employee_id=emp.employee_id
join hr.jobs j on jh.job_id=j.job_id
WHERE months_between(jh.end_date,jh.start_date)>6;

/*Display department name, average salary and number of employees with commission within
the department.*/

select dp.department_name,round(avg(salary),0),count(*)
from hr.departments dp
join hr.employees e on dp.department_id=e.department_id
where commission_pct is not null
group by dp.department_name;

/*Display employee name and country in which he is working.*/

select first_name,country_name
from hr.employees e
join hr.departments dp
on dp.department_id=e.department_id
join hr.locations lc
on dp.location_id=lc.location_id
join hr.countries c
on lc.country_id=c.country_id;