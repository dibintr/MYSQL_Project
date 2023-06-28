CREATE DATABASE Library;
USE Library;

CREATE TABLE Branch
(
Branch_no INT PRIMARY KEY,
Manager_Id INT,
Branch_address VARCHAR(30),
Contact_no INT
);

INSERT INTO Branch(Branch_no,Manager_Id,Branch_address,Contact_no) VALUES
(1,111,'Irinjalakuda,Thrissur',98126745),
(2,222,'Aluva,Ernakulam',75126765),
(3,333,'Cherthala,Alapuzha',88326744),
(4,444,'Pattambi,Palakad',85123725),
(5,555,'Pala,Kottayam',98126745);

CREATE TABLE  Employee
(
  Emp_Id INT PRIMARY KEY,
  Emp_name VARCHAR(30),
  Position VARCHAR(30),
  salary DECIMAL(10,2)
);

INSERT INTO Employee(Emp_Id,Emp_name,Position,salary)VALUE
(111,'Arjun','Librarian',12000.00),
(222,'Balu','Security',10000.00),
(333,'Deepu','Manager',15000.00),
(444,'Fahad','Librarian',12000.00),
(555,'Rahul','Director',16000.00);

CREATE TABLE Customer
(
Customer_Id INT PRIMARY KEY,
Customer_name VARCHAR(30),
Customer_address VARCHAR(50),
Reg_date DATE
);

INSERT INTO Customer(Customer_Id,Customer_name,Customer_address,Reg_date)VALUES
(1,'Abhi','Thrissur','2022-08-12'),
(2,'Bibi','Ernakulaam','2022-01-20'),
(3,'Christi','Kottayam','2022-12-26'),
(4,'Firoz','Palakad','2023-04-11'),
(5,'Helwin','Alapuzha','2022-03-15');

CREATE TABLE Books
(
 ISBN VARCHAR(50) PRIMARY KEY,
 Book_title VARCHAR(50), 
   Category VARCHAR(50),
   Rental_Price DECIMAL(10,2),
   Status  VARCHAR(10), 
   Author VARCHAR(50), 
   Publisher VARCHAR(50)
);

INSERT INTO Books(ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher) VALUES
  ('ISBNOO1','Harry Potter','Novel',399.00,'Yes','J K Rowling','Bloomsbury'),
  ('ISBNOO2','Wings of Fire','Autobiography',599.00,'Yes','A P J Abdul Kalam','Universities Press'),
  ('ISBNOO3','Atomic Habbits','Motivation',299.00,'No','James Clear','Random House'),
  ('ISBNOO4','Death on the Nile','Mystery',699.00,'No','Agatha Christie','G&G Publisher'),
  ('ISBNOO5','Matilda','Childrensbook',199.00,'Yes','Roald Dahl','A&B Publisher');
  
   CREATE TABLE IssueStatus
 (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(30),
	Issue_date DATE, 
	Isbn_book VARCHAR(30),
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
  );
  
  INSERT INTO IssueStatus (Issue_Id,Issued_cust,Issued_book_name,Issue_date,Isbn_book) VALUES
 (1,1,'Harry Potter','2023-01-12','ISBNOO1'),
 (2,2,'Wings of Fire','2023-02-09','ISBNOO2'),
 (3,3,'Atomic Habbits','2023-02-22','ISBNOO3'),
 (4,4,'Death on the Nile','2023-03-02','ISBNOO4'),
 (5,5,'Matilda','2023-04-18','ISBNOO5');
 
 CREATE TABLE  ReturnStatus 
(
  Return_Id  INT PRIMARY KEY, 
  Return_cust INT,
  Return_book_name VARCHAR(30), 
  Return_date DATE, 
  Isbn_book2 VARCHAR(30),
  FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
  FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);

 INSERT INTO ReturnStatus (Return_Id,Return_cust,Return_book_name,Return_date,Isbn_book2) VALUES
 (1,1,'Harry Potter','2023-01-29','ISBNOO1'),
 (2,2,'Wings of Fire','2023-03-01','ISBNOO2'),
 (3,3,'Atomic Habbits','2023-03-20','ISBNOO3'),
 (4,4,'Death on the Nile','2023-03-28','ISBNOO4'),
 (5,5,'Matilda','2023-05-02','ISBNOO5');
 
  
 SELECT * FROM Branch;
 SELECT * FROM Employee;
 SELECT * FROM Customer;
 SELECT* FROM Books;
 SELECT * FROM IssueStatus;
 SELECT * FROM ReturnStatus;
 
 /*Retrieve the book title, category, and rental price of all available books*/
 
 SELECT Book_title,Category,Rental_Price FROM Books WHERE Status = 'Yes';
 
 /*List the employee names and their respective salaries in descending order of salary*/
 
 SELECT Emp_name ,Salary FROM Employee ORDER BY Salary DESC;
 
 /*Retrieve the book titles and the corresponding customers who have issued those books*/
 
 SELECT IssueStatus.Issued_book_name,Customer.Customer_name FROM IssueStatus INNER JOIN 
Customer ON IssueStatus.Issued_Cust = Customer.Customer_Id;

/*Display the total count of books in each category*/

SELECT Category,COUNT(*) AS Total_count_of_books FROM Books GROUP BY Category;

/*Retrieve the employee names and their positions for the employees whose salaries are above Rs.12,000*/

SELECT Emp_name,Position,Salary From Employee WHERE Salary>12000.00;

/*List the customer names who registered before 2022-01-01 and have not issued any books yet*/

SELECT Customer_name FROM Customer WHERE Reg_date < '2022-01-01'
AND  Customer_Id NOT IN (SELECT Issued_Cust FROM IssueStatus);

/*Display the branch numbers and the total count of employees in each branch*/

SELECT Branch.Branch_no,COUNT(*) AS Total_Employees FROM Branch JOIN
Employee ON Branch.Manager_Id = Employee.Emp_Id GROUP BY Branch.Branch_no;

/*Display the names of customers who have issued books in the month of June 2023*/

SELECT Customer.Customer_name FROM Customer JOIN 
IssueStatus ON Customer.Customer_Id = IssueStatus.Issued_Cust WHERE 
IssueStatus.Issue_date LIKE '2023-02-%';

/*Retrieve book_title from book table containing history*/

SELECT Book_title FROM Books WHERE Category = 'Novel';

/*.Retrieve the branch numbers along with the count of employees for branches having more than 5 employees*/

SELECT Branch.Branch_no,COUNT(*) AS Total_Employees FROM Branch JOIN
Employee ON Branch.Manager_Id = Employee.Emp_Id GROUP BY Branch.Branch_no HAVING COUNT(*) > 5;

  