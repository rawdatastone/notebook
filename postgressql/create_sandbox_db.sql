CREATE DATABASE sandbox;

create table departments
(
  id            SERIAL,
  name          varchar(255),

  primary key(id)
);

insert into departments
  (name)
values
  ('Reporting'),
  ('Engineering'),
  ('Marketing'),
  ('Biz Dev');

create table employees
(
  id            SERIAL,
  first_name    varchar(255),
  last_name     varchar(255),
  salary        int,
  department_id int references departments,

  primary key (id)
);

insert into employees
  (first_name, last_name, salary, department_id)
values
  ('John',   'Smith',     20000, 1),
  ('Cailin', 'Ninson',    30000, 2),
  ('Mike',   'Peterson',  20000, 2),
  ('Ian',    'Peterson',  80000, 2),
  ('John',   'Mills',     50000, 3);

create table projects
(
  id            SERIAL,
  title         varchar(255),
  start_date    date,
  end_date      date,
  budget        int,

  primary key(id)
);

insert into projects
  (title, start_date, end_date, budget)
values
  ('Build a cool site',        '2011-10-28', '2012-01-26', 1000000),
  ('Update TPS Reports',       '2011-07-20', '2011-10-28',  100000),
  ('Design 3 New Silly Walks', '2009-05-11', '2009-08-19',     100);


create table employees_projects
(
  project_id    int references projects,
  employee_id   int references employees
);

insert into employees_projects
  (project_id, employee_id)
values
  (2, 1),
  (3, 2),
  (1, 3),
  (1, 4),
  (1, 5);


create table numbers
(
  id            int ,
  description   char(5)
);

insert into numbers(id, description)
values
  (1, 'one'),
  (2, 'two'),
  (3, 'three'),
  (4, 'four'),
  (5, 'five'),
  (6, 'six'),
  (7, 'seven'),
  (8, 'eight'),
  (9, 'nine'),
  (10,'ten');

SELECT * FROM numbers;

/* Extract from CoderPad to be used as a template for a sandbox db 
CoderPad provides a basic SQL sandbox with the following schema.
You can also use commands like `show tables` and `desc employees`

employees                             projects
+---------------+---------+           +---------------+---------+
| id            | int     |<----+  +->| id            | int     |
| first_name    | varchar |     |  |  | title         | varchar |
| last_name     | varchar |     |  |  | start_date    | date    |
| salary        | int     |     |  |  | end_date      | date    |
| department_id | int     |--+  |  |  | budget        | int     |
+---------------+---------+  |  |  |  +---------------+---------+
                             |  |  |
departments                  |  |  |  employees_projects
+---------------+---------+  |  |  |  +---------------+---------+
| id            | int     |<-+  |  +--| project_id    | int     |
| name          | varchar |     +-----| employee_id   | int     |
+---------------+---------+           +---------------+---------+

employees
 id | first_name | last_name | salary | department_id 
----+------------+-----------+--------+---------------
  1 | John       | Smith     |  20000 |             1
  2 | Ava        | Muffinson |  10000 |             5
  3 | Cailin     | Ninson    |  30000 |             2
  4 | Mike       | Peterson  |  20000 |             2
  5 | Ian        | Peterson  |  80000 |             2
  6 | John       | Mills     |  50000 |             3

projects
 id |          title           | start_date |  end_date  | budget  
----+--------------------------+------------+------------+---------
  1 | Build a cool site        | 2011-10-28 | 2012-01-26 | 1000000
  2 | Update TPS Reports       | 2011-07-20 | 2011-10-28 |  100000
  3 | Design 3 New Silly Walks | 2009-05-11 | 2009-08-19 |     100

departments
 id |    name     
----+-------------
  1 | Reporting
  2 | Engineering
  3 | Marketing
  4 | Biz Dev
  5 | Silly Walks

employee_projects
 project_id | employee_id 
------------+-------------
          2 |           1
          3 |           2
          1 |           3
          1 |           4
          1 |           5


Schema

           Table "public.employees_projects"
   Column    |  Type   | Collation | Nullable | Default
-------------+---------+-----------+----------+---------
 project_id  | integer |           |          |
 employee_id | integer |           |          |
Foreign-key constraints:
    "employees_projects_employee_id_fkey" FOREIGN KEY (employee_id) REFERENCES employees(id)
    "employees_projects_project_id_fkey" FOREIGN KEY (project_id) REFERENCES projects(id)

                                      Table "public.projects"
   Column   |          Type          | Collation | Nullable |               Default
------------+------------------------+-----------+----------+--------------------------------------
 id         | integer                |           | not null | nextval('projects_id_seq'::regclass)
 title      | character varying(255) |           |          |
 start_date | date                   |           |          |
 end_date   | date                   |           |          |
 budget     | integer                |           |          |
Indexes:
    "projects_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "employees_projects" CONSTRAINT "employees_projects_project_id_fkey" FOREIGN KEY (project_id) REFERENCES projects(id)

                                    Table "public.departments"
 Column |          Type          | Collation | Nullable |                 Default
--------+------------------------+-----------+----------+-----------------------------------------
 id     | integer                |           | not null | nextval('departments_id_seq'::regclass)
 name   | character varying(255) |           |          |
Indexes:
    "departments_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "employees" CONSTRAINT "employees_department_id_fkey" FOREIGN KEY (department_id) REFERENCES departments(id)

                                       Table "public.employees"
    Column     |          Type          | Collation | Nullable |                Default
---------------+------------------------+-----------+----------+---------------------------------------
 id            | integer                |           | not null | nextval('employees_id_seq'::regclass)
 first_name    | character varying(255) |           |          |
 last_name     | character varying(255) |           |          |
 salary        | integer                |           |          |
 department_id | integer                |           |          |
Indexes:
    "employees_pkey" PRIMARY KEY, btree (id)
Foreign-key constraints:
    "employees_department_id_fkey" FOREIGN KEY (department_id) REFERENCES departments(id)
Referenced by:
    TABLE "employees_projects" CONSTRAINT "employees_projects_employee_id_fkey" FOREIGN KEY (employee_id) REFERENCES employees(id)

*/


