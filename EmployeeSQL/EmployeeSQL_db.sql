-- Create the 'titles' table
CREATE TABLE titles (
    title_id VARCHAR PRIMARY KEY,
    title VARCHAR(255) NOT NULL
);

-- Create the 'departments' table
CREATE TABLE departments (
    dept_no VARCHAR PRIMARY KEY,
    dept_name VARCHAR(255) NOT NULL
);

-- Create the 'employees' table
SET datestyle = 'ISO, MDY';
CREATE TABLE employees (
    emp_no INTEGER PRIMARY KEY,
    emp_title_id VARCHAR(4) NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    sex CHAR(1) NOT NULL,
    hire_date DATE NOT NULL,
    FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);

-- Create the 'dept_emp' table
CREATE TABLE dept_emp (
    emp_no INTEGER,
    dept_no VARCHAR(4),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

-- Create the 'dept_manager' table
CREATE TABLE dept_manager (
    dept_no VARCHAR(4),
    emp_no INTEGER,
    PRIMARY KEY (dept_no, emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);


-- Create the 'salaries' table
CREATE TABLE salaries (
    emp_no INTEGER PRIMARY KEY,
    salary INTEGER NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);


DROP TABLE departments
SELECT * FROM departments

DROP TABLE titles
SELECT * FROM titles

DROP TABLE employees
SELECT * FROM employees

DROP TABLE dept_emp
SELECT * FROM dept_emp

DROP TABLE dept_manager
SELECT * FROM dept_manager

DROP TABLE salaries
SELECT * FROM salaries

-----------------------------------------------------------------------------------------------------

SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no;

-----------------------------------------------------------------------------------------------------

SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

-----------------------------------------------------------------------------------------------------

SELECT 
	d.dept_no, d.dept_name, dm.emp_no AS manager_emp_no, e.last_name AS manager_last_name, 
	e.first_name AS manager_first_name
FROM departments d
JOIN dept_manager dm ON d.dept_no = dm.dept_no
JOIN employees e ON dm.emp_no = e.emp_no;

-----------------------------------------------------------------------------------------------------

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no;

-----------------------------------------------------------------------------------------------------

SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-----------------------------------------------------------------------------------------------------

SELECT e.emp_no, e.last_name, e.first_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

-----------------------------------------------------------------------------------------------------

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');

-----------------------------------------------------------------------------------------------------

SELECT last_name, COUNT(*) AS last_name_count
FROM employees
GROUP BY last_name
ORDER BY last_name_count DESC;

-----------------------------------------------------------------------------------------------------