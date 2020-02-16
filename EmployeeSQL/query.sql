CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);


CREATE TABLE "department_employees" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    "from_date" VARCHAR   NOT NULL,
    "to_date" VARCHAR   NOT NULL,
    CONSTRAINT "pk_department_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "deptartment_managers" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   NOT NULL,
    "from_date" VARCHAR   NOT NULL,
    "to_date" VARCHAR   NOT NULL,
    CONSTRAINT "pk_deptartment_managers" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "birth_date" VARCHAR   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "gender" VARCHAR   NOT NULL,
    "hire_date" VARCHAR   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    "from_date" VARCHAR   NOT NULL,
    "to_date" VARCHAR   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "titles" (
    "emp_no" INT   NOT NULL,
    "title" VARCHAR   NOT NULL,
    "from_date" VARCHAR   NOT NULL,
    "to_date" VARCHAR   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "emp_no"
     )
);

ALTER TABLE "departments" ADD CONSTRAINT "fk_departments_dept_no" FOREIGN KEY("dept_no")
REFERENCES "deptartment_managers" ("dept_no");

ALTER TABLE "department_employees" ADD CONSTRAINT "fk_department_employees_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "department_employees" ADD CONSTRAINT "fk_department_employees_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_no" FOREIGN KEY("emp_no")
REFERENCES "titles" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "deptartment_managers" ("emp_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "salaries" ("emp_no");




--1) List the following details of each employee: employee number, last name, first name, gender, and salary.
select * from employees;
select * from salaries;

select employees.emp_no,
	employees.last_name,
	employees.first_name,
	employees.gender,
	salaries.salary
from employees
left join salaries on employees.emp_no = salaries.emp_no;
	
	
	

--2) List employees who were hired in 1986.
select * from employees;

select * from employees
where
	hire_date >= '1986-01-01'
	and hire_date <= '1986-12-31';




--3) List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
select * from departments;
select * from deptartment_managers;
select * from employees;

select departments.dept_no,
	departments.dept_name,
	deptartment_managers.emp_no,
	employees.last_name,
	employees.first_name,
	deptartment_managers.from_date,
	deptartment_managers.to_date
from deptartment_managers
left join departments on departments.dept_no = deptartment_managers.dept_no
left join employees on employees.emp_no = deptartment_managers.emp_no
	



--4) List the department of each employee with the following information: employee number, last name, first name, and department name.
select * from departments;
select * from department_employees;
select * from employees;

select department_employees.emp_no,
	employees.last_name,
	employees.first_name,
	departments.dept_name
from department_employees
left join employees on department_employees.emp_no = employees.emp_no
left join departments on departments.dept_no = department_employees.dept_no




--5) List all employees whose first name is "Hercules" and last names begin with "B."
select * from employees;

select * from employees
where
	first_name = 'Hercules'
	and left (last_name, 1) = 'B';



--6) List all employees in the Sales department, including their employee number, last name, first name, and department name.
select * from departments;
select * from department_employees;
select * from employees;

select department_employees.emp_no,
	employees.last_name,
	employees.first_name,
	departments.dept_name
from department_employees
left join employees on department_employees.emp_no = employees.emp_no
left join departments on departments.dept_no = department_employees.dept_no
where
	dept_name = 'Sales';



--7) List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
select * from departments;
select * from department_employees;
select * from employees;

select department_employees.emp_no,
	employees.last_name,
	employees.first_name,
	departments.dept_name
from department_employees
left join employees on department_employees.emp_no = employees.emp_no
left join departments on departments.dept_no = department_employees.dept_no
where
	dept_name = 'Sales'
	or dept_name = 'Development';



--8) In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
select * from employees;

select last_name, count(emp_no) as "no_of_emp"
from employees
group by last_name
order by "no_of_emp" desc;



















