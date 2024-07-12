/*Display the first promotion year for each employee.*/

select first_name,min(jh.end_date) 
from hr.employees e
join hr.job_history jh
on jh.employee_id=e.employee_id
group by e.first_name;

/*Display location, city and department name of employees who have been promoted more than
once.*/

Select emp.first_name,dep.department_name,loc.city from  hr.employees  emp  
left join hr.departments  dep  on emp.department_id=dep.department_id
left join  hr.locatıons loc  on loc.location_id =dep.location_id
where emp.employee_id in (Select jh.EMPLOYEE_ID fpr_date from  hr.job_hıstory jh
group by jh.EMPLOYEE_ID
having count(*)>1);

/*Display minimum and maximum “hire_date” of employees work in IT and HR departments.*/

select min(hire_date),max(hire_date),dp.department_name from hr.employees e
LEFT join hr.departments dp
on dp.department_id=e.department_id
where dp.department_id in (40,60)
group by dp.department_name,dp.department_id;

/*Find difference between current date and hire dates of employees after sorting them by hire
date, then show difference in days, months and years.*/

Select  
round(sysdate-hire_date,2) day_diff ,
round(months_between(sysdate,hire_date),2)  month_diff ,
extract(year from  sysdate) -extract(year from  hire_date) year_diff 
from hr.employees order by hire_date ;

/*Find which departments used to hire earliest/latest.*/

select department_name, hire_date
from hr.departments dp
join hr.employees e
on dp.department_id=e.department_id
where hire_date=(select min(hire_date) from hr.employees)

UNION
    
select department_name, hire_date
from hr.departments dp
join hr.employees e
on dp.department_id=e.department_id
where hire_date=(select max(hire_date) from hr.employees);
/*Find the number of departments with no employee for each city.*/

Select loc.city,count(*)
from  hr.employees  emp  
right join hr.departments  dep  on emp.department_id=dep.department_id
left join  hr.locatıons loc on loc.location_id = dep.location_id
where emp.employee_id is null
group by loc.city;

/*Create a category called “seasons” and find in which season most employees were hired.*/

SELECT
    CASE 
        WHEN EXTRACT(MONTH FROM hire_date) BETWEEN 3 AND 5 THEN 'Spring'
        WHEN EXTRACT(MONTH FROM hire_date) BETWEEN 6 AND 8 THEN 'Summer'
        WHEN EXTRACT(MONTH FROM hire_date) BETWEEN 9 AND 11 THEN 'Fall'
        ELSE 'Winter'
    END AS season,
    COUNT(*) AS hires_count
FROM
    hr.employees
GROUP BY
    CASE 
        WHEN EXTRACT(MONTH FROM hire_date) BETWEEN 3 AND 5 THEN 'Spring'
        WHEN EXTRACT(MONTH FROM hire_date) BETWEEN 6 AND 8 THEN 'Summer'
        WHEN EXTRACT(MONTH FROM hire_date) BETWEEN 9 AND 11 THEN 'Fall'
        ELSE 'Winter'
    END
ORDER BY
    hires_count DESC
FETCH FIRST 1 ROW ONLY;

/*Find the cities of employees with average salary more than 5000.
*/
select city, avg(salary)
from hr.locations lc
join hr.departments dp
on lc.location_id=dp.location_id
join hr.employees emp
on dp.department_id=emp.department_id
group by city
having avg(salary)>5000;