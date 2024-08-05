-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/

-- Create tables and their relationships
CREATE TABLE "Employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" VARCHAR   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);

SELECT * FROM "Employees";

CREATE TABLE "Dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Dept_emp" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   NOT NULL,
    CONSTRAINT "pk_Dept_manager" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "Salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    CONSTRAINT "pk_Salaries" PRIMARY KEY (
        "emp_no"
     )
);

SELECT * FROM "Salaries";

CREATE TABLE "Departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR(20)   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

SELECT * FROM "Departments";

CREATE TABLE "Titles" (
    "title_id" VARCHAR   NOT NULL,
    "title" VARCHAR(20)   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "title_id"
     )
);

SELECT * FROM "Titles";

ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp__dept_no" FOREIGN KEY("dept_no")
REFERENCES "Dept_manager" ("dept_no");

ALTER TABLE "Dept_manager" ADD CONSTRAINT "fk_Dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

-- Drop the Dept_manager table and dependent objects
DROP TABLE IF EXISTS "Dept_manager" CASCADE;

-- Recreate the Dept_manager table with composite primary key
CREATE TABLE "Dept_manager" (
    "dept_no" VARCHAR NOT NULL,
    "emp_no" INT NOT NULL,
    CONSTRAINT "pk_Dept_manager" PRIMARY KEY ("dept_no", "emp_no")
);

ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp__dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_manager" ADD CONSTRAINT "fk_Dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

SELECT * FROM "Dept_manager";

-- Drop all tables if they exist
DROP TABLE IF EXISTS "Dept_emp" CASCADE;
DROP TABLE IF EXISTS "Dept_manager" CASCADE;
DROP TABLE IF EXISTS "Salaries" CASCADE;
DROP TABLE IF EXISTS "Departments" CASCADE;
DROP TABLE IF EXISTS "Titles" CASCADE;
DROP TABLE IF EXISTS "Employees" CASCADE;

-- Create Employees table
CREATE TABLE "Employees" (
    "emp_no" INT NOT NULL,
    "emp_title_id" VARCHAR NOT NULL,
    "birth_date" DATE NOT NULL,
    "first_name" VARCHAR NOT NULL,
    "last_name" VARCHAR NOT NULL,
    "sex" VARCHAR NOT NULL,
    "hire_date" DATE NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY ("emp_no")
);

-- Create Dept_emp table
CREATE TABLE "Dept_emp" (
    "emp_no" INT NOT NULL,
    "dept_no" VARCHAR NOT NULL,
    CONSTRAINT "pk_Dept_emp" PRIMARY KEY ("emp_no", "dept_no")
);

-- Create Salaries table
CREATE TABLE "Salaries" (
    "emp_no" INT NOT NULL,
    "salary" INT NOT NULL,
    CONSTRAINT "pk_Salaries" PRIMARY KEY ("emp_no")
);

-- Create Departments table
CREATE TABLE "Departments" (
    "dept_no" VARCHAR NOT NULL,
    "dept_name" VARCHAR(20) NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY ("dept_no")
);

-- Create Titles table
CREATE TABLE "Titles" (
    "title_id" VARCHAR NOT NULL,
    "title" VARCHAR(20) NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY ("title_id")
);

-- Create Dept_manager table with composite primary key
CREATE TABLE "Dept_manager" (
    "dept_no" VARCHAR NOT NULL,
    "emp_no" INT NOT NULL,
    CONSTRAINT "pk_Dept_manager" PRIMARY KEY ("dept_no", "emp_no")
);

-- Add foreign key constraints
ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp__dept_no" FOREIGN KEY ("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_manager" ADD CONSTRAINT "fk_Dept_manager_emp_no" FOREIGN KEY ("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Dept_manager" ADD CONSTRAINT "fk_Dept_manager_dept_no" FOREIGN KEY ("dept_no")
REFERENCES "Departments" ("dept_no");

-- select statements to verify table creation
SELECT * FROM "Employees";
SELECT * FROM "Dept_emp";
SELECT * FROM "Dept_manager";
SELECT * FROM "Salaries";
SELECT * FROM "Departments";
SELECT * FROM "Titles";


--List the employee number, last name, first name, sex, and salary of each employee
SELECT "Employees".emp_no, "Employees".last_name, "Employees".first_name, "Employees".sex, "Salaries".salary 
FROM "Employees"
INNER JOIN "Salaries" ON 
"Salaries".emp_no="Employees".emp_no;

--List the first name, last name, and hire date for the employees who were hired in 1986 
SELECT "Employees".first_name, "Employees".last_name, "Employees".hire_date
FROM "Employees"
WHERE "Employees".hire_date >= '1986-01-01'AND "Employees".hire_date < '1987-01-01';


--List the manager of each department along with their department number, department name, employee number, last name, and first name 
SELECT "Dept_manager".emp_no, "Dept_manager".dept_no, "Departments".dept_name, "Employees".first_name, "Employees".last_name 
FROM "Dept_manager"
INNER JOIN "Departments" ON 
"Departments".dept_no="Dept_manager".dept_no
INNER JOIN "Employees" ON
"Employees".emp_no="Dept_manager".emp_no;

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name 
SELECT "Dept_emp".dept_no, "Employees".emp_no, "Employees".last_name, "Employees".first_name, "Departments".dept_name
FROM "Dept_emp"
INNER JOIN "Departments" ON "Departments".dept_no = "Dept_emp".dept_no
INNER JOIN "Employees" ON "Dept_emp".emp_no = "Employees".emp_no;


--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B 
SELECT "Employees".first_name, "Employees".last_name, "Employees".sex
FROM "Employees"
WHERE "Employees".first_name = 'Hercules' AND "Employees".last_name LIKE 'B%';


--List each employee in the Sales department, including their employee number, last name, and first name
SELECT "Departments".dept_name, "Employees".emp_no, "Employees".last_name, "Employees".first_name
FROM "Employees"
INNER JOIN "Dept_emp" ON "Dept_emp".emp_no = "Employees".emp_no
INNER JOIN "Departments" ON "Departments".dept_no = "Dept_emp".dept_no
WHERE "Departments".dept_name = 'Sales';


--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name 
SELECT "Employees".emp_no, "Employees".last_name, "Employees".first_name, "Departments",dept_name
FROM "Employees"
INNER JOIN "Dept_emp" ON "Dept_emp".emp_no = "Employees".emp_no
INNER JOIN "Departments" ON "Departments".dept_no = "Dept_emp".dept_no
WHERE "Departments".dept_name IN ('Sales', 'Development');  


--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name)
SELECT "Employees".last_name, COUNT("Employees".last_name) AS Frequency 
FROM "Employees"
GROUP BY "Employees".last_name
ORDER BY Frequency DESC;











