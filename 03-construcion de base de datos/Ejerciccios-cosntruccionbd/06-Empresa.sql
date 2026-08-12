
CREATE DATABASE empresa_db;
GO


USE empresa_db;
GO


CREATE TABLE department(
	number INT NOT NULL IDENTITY(1,1)
	CONSTRAINT pk_department
	PRIMARY KEY,

	name VARCHAR(100) NOT NULL
	CONSTRAINT uq_department_name
	UNIQUE,

	startdate DATE NOT NULL
	CONSTRAINT df_department_startdate
	DEFAULT GETDATE(),

	manager_ssn CHAR(11) NULL,

	created_at DATETIME2 NOT NULL
	CONSTRAINT df_department_created_at
	DEFAULT SYSDATETIME(),

	updated_at DATETIME2 NOT NULL
	CONSTRAINT df_department_updated_at
	DEFAULT SYSDATETIME()
);
GO


CREATE TABLE employee(
	ssn CHAR(11) NOT NULL
	CONSTRAINT pk_employee
	PRIMARY KEY,

	first_name VARCHAR(50) NOT NULL,

	last_name VARCHAR(50) NOT NULL,

	birthdate DATE NOT NULL,

	address VARCHAR(150) NOT NULL,

	sex CHAR(1) NOT NULL
	CONSTRAINT ck_employee_sex
	CHECK (sex IN ('M','F')),

	salary DECIMAL(10,2) NOT NULL
	CONSTRAINT ck_employee_salary
	CHECK (salary > 0),

	supervisor_ssn CHAR(11) NULL,

	department_number INT NOT NULL,

	created_at DATETIME2 NOT NULL
	CONSTRAINT df_employee_created_at
	DEFAULT SYSDATETIME(),

	updated_at DATETIME2 NOT NULL
	CONSTRAINT df_employee_updated_at
	DEFAULT SYSDATETIME(),

	CONSTRAINT fk_employee_department
	FOREIGN KEY (department_number)
	REFERENCES department(number)
);
GO



ALTER TABLE employee
ADD CONSTRAINT fk_employee_supervisor
FOREIGN KEY (supervisor_ssn)
REFERENCES employee(ssn);
GO

ALTER TABLE department
ADD CONSTRAINT fk_department_manager
FOREIGN KEY (manager_ssn)
REFERENCES employee(ssn);
GO

CREATE TABLE project(
	number INT NOT NULL IDENTITY(1,1)
	CONSTRAINT pk_project
	PRIMARY KEY,

	name VARCHAR(100) NOT NULL
	CONSTRAINT uq_project_name
	UNIQUE,

	location VARCHAR(100) NOT NULL,

	department_number INT NOT NULL,

	created_at DATETIME2 NOT NULL
	CONSTRAINT df_project_created_at
	DEFAULT SYSDATETIME(),

	updated_at DATETIME2 NOT NULL
	CONSTRAINT df_project_updated_at
	DEFAULT SYSDATETIME(),

	CONSTRAINT fk_project_department
	FOREIGN KEY (department_number)
	REFERENCES department(number)
);
GO



CREATE TABLE dependent(
	id_dependent INT NOT NULL IDENTITY(1,1)
	CONSTRAINT pk_dependent
	PRIMARY KEY,

	name VARCHAR(100) NOT NULL,

	sex CHAR(1) NOT NULL
	CONSTRAINT ck_dependent_sex
	CHECK (sex IN ('M','F')),

	birthdate DATE NOT NULL,

	relationship VARCHAR(50) NOT NULL,

	ssn CHAR(11) NOT NULL,

	created_at DATETIME2 NOT NULL
	CONSTRAINT df_dependent_created_at
	DEFAULT SYSDATETIME(),

	updated_at DATETIME2 NOT NULL
	CONSTRAINT df_dependent_updated_at
	DEFAULT SYSDATETIME(),

	CONSTRAINT fk_dependent_employee
	FOREIGN KEY (ssn)
	REFERENCES employee(ssn)
);
GO


CREATE TABLE works_on(
	ssn CHAR(11) NOT NULL,

	number INT NOT NULL,

	hours DECIMAL(5,2) NOT NULL
	CONSTRAINT ck_works_on_hours
	CHECK (hours > 0),

	created_at DATETIME2 NOT NULL
	CONSTRAINT df_works_on_created_at
	DEFAULT SYSDATETIME(),

	updated_at DATETIME2 NOT NULL
	CONSTRAINT df_works_on_updated_at
	DEFAULT SYSDATETIME(),

	CONSTRAINT pk_works_on
	PRIMARY KEY (ssn, number),

	CONSTRAINT fk_works_on_employee
	FOREIGN KEY (ssn)
	REFERENCES employee(ssn),

	CONSTRAINT fk_works_on_project
	FOREIGN KEY (number)
	REFERENCES project(number)
);
GO