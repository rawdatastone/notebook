-- TODO: below code is from ranking

SELECT
    *
FROM sandbox.public.employees
ORDER BY first_name ASC;


-- total salary of a department
SELECT
    id, first_name, salary, department_id,
    SUM(salary) OVER(PARTITION BY department_id) AS Cummulative_Sum
FROM sandbox.public.employees
ORDER BY id ASC;

-- cummulative salary by fname from employees
SELECT
    id, first_name, salary,
    SUM(salary) OVER(ORDER BY id) AS Cummulative_Sum
FROM sandbox.public.employees
ORDER BY id ASC;

-- cummulative salary by department and fname from employees
SELECT
    id, department_id, first_name, salary,
    SUM(salary) OVER(PARTITION BY department_id ORDER BY id) AS Cummulative_sum
FROM sandbox.public.employees
ORDER BY id ASC;
-- rank emplyee by salary from employees
SELECT
    id, first_name, salary,
    rank() OVER(ORDER BY salary) AS ranknig
FROM sandbox.public.employees
ORDER BY ranknig ASC;

-- rank emplyee by highest salary by department from employees
SELECT
    id, department_id, first_name, salary,
    rank() OVER(PARTITION BY department_id ORDER BY salary desc) AS ranknig
FROM sandbox.public.employees
ORDER BY ranknig ASC;

-- rank departments by total salary from employees

SELECT
    e.department_id, dsum.dep_salary, 
    rank() OVER(order by dsum.dep_salary)
FROM  sandbox.public.employees as e
    INNER JOIN (
        SELECT
            department_id, 
            SUM(salary) AS Dep_salary
        FROM sandbox.public.employees
        GROUP BY department_id
        ) AS dsum ON dsum.department_id = e.department_id
;
