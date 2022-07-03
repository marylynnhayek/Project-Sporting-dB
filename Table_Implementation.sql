-- Creation de tables

-- Table 1
create table Student(
	student_number int not null,
	student_name varchar(20) not null,
	class char(1),
	major varchar(3),
	primary key(student_number)
);

-- Table 2: Select desired code to execute alone, or place previously executed code
create table Course(
	course_name varchar(20) not null,
	course_number varchar(50) not null,
	credits_hours int not null,
	department varchar(50) not null,
	primary key (course_number)
);

-- Table 3
create table Section(
	section_id int not null,
	course_number varchar(50) not null,
	Semester varchar(10) not null,
	SYear int not null,
	Instructor varchar(50),
	Primary key (section_id),
	constraint FK_Section_Course foreign key(course_number) references course(course_Number)
);

-- Table 4
create Table Grade_Report(
	student_number int not null,
	section_id int not null,
	Grade char(1),
	primary key(student_number, section_id),
	constraint FK_Grade_Student foreign key(student_number) references student(student_number),
	constraint FK_Grade_Section foreign key(section_id) references Section(section_id)
);


-- Creation du diagram


-- Database diagram: shows relationships between tables (1_to_many or many_to_many).

-- Insertion des données

-- Query pour l'insertion de données
-- Always start with tables that don't contain foreign keys.

-- Student Table
insert into Student values(17,'Smith','1','CS');
insert into Student values(8,'Brown','2','CS');

-- Course Table
insert into Course values('CS1310','intro to CS',4,'CS');
insert into Course values('CS3320','Data Structures',4,'CS');
insert into Course values('MATH2410','Discrete Maths',3,'Math');
insert into Course values('CS3380','Database',3,'CS');

-- Section Table
-- Etc…
