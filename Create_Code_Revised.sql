DROP TABLE ORDER_T
DROP TABLE RECIPE_INGREDIENT
DROP TABLE REWARD
DROP TABLE EMPLOYEE
DROP TABLE CUSTOMER
DROP TABLE SUPPLIER
DROP TABLE INGREDIENT
DROP TABLE INGREDIENT_SUPPLIER
DROP TABLE PRODUCT
DROP TABLE RECIPE
DROP TABLE ORDER_PRODUCT


CREATE TABLE EMPLOYEE
	(Employee_ID  	NUMERIC(10, 0)		NOT NULL,
	First_Name   	VARCHAR(30),
	Last_Name    	VARCHAR(30),
	Phone_Number 	NUMERIC(10, 0),
	Salary          DECIMAL(7, 2)
CONSTRAINT EMPLOYEE_PK PRIMARY KEY(Employee_ID))

CREATE TABLE CUSTOMER
	(Customer_ID		NUMERIC(10, 0)	NOT NULL,
	First_Name			VARCHAR(30),
	Last_Name			VARCHAR(30),
	Customer_Address    VARCHAR(50),
	Email				VARCHAR(50),
	Account_Password	VARCHAR(20),
	Phone_Number        NUMERIC(10, 0),
CONSTRAINT CUSTOMER_PK PRIMARY KEY(Customer_ID))

CREATE TABLE SUPPLIER
	(Supplier_ID     NUMERIC(18, 0)   NOT NULL, 
	Supplier_Name    VARCHAR(30),
CONSTRAINT SUPPLIER_PK PRIMARY KEY(Supplier_ID))

CREATE TABLE INGREDIENT
	(Ingredient_ID      Numeric(18,0) NOT NULL,
	Ingredient_Name     VARCHAR(30),
	Ingredient_Quantity NUMERIC(6, 0),
	Cost                DECIMAL(3, 2),
CONSTRAINT INGREDIENT_PK PRIMARY KEY(Ingredient_ID))

CREATE TABLE PRODUCT
	(Product_ID   NUMERIC(3, 0) NOT NULL,
	Product_Name  VARCHAR(30),
	Price         DECIMAL (4,2),
CONSTRAINT PRODUCT_PK PRIMARY KEY (Product_ID))

CREATE TABLE ORDER_T
	(Order_ID		NUMERIC(6, 0)		NOT NULL,
	Employee_ID		NUMERIC(10, 0)		NOT NULL,
	Customer_ID		NUMERIC(10, 0) 	    NOT NULL,
	Specific_Date   DATE
CONSTRAINT ORDER_T_PK PRIMARY KEY (Order_ID),
CONSTRAINT ORDER_T_FK1 FOREIGN KEY (Employee_ID) REFERENCES EMPLOYEE(Employee_ID) 
ON UPDATE CASCADE
ON DELETE CASCADE,
CONSTRAINT ORDER_T_FK2 FOREIGN KEY (Customer_ID) REFERENCES CUSTOMER(Customer_ID)
ON UPDATE CASCADE
ON DELETE CASCADE)

CREATE TABLE RECIPE
	(Recipe_ID 	NUMERIC (3, 0)  NOT NULL,
	Product_ID 	NUMERIC (3, 0)  NOT NULL,
	Recipe_Name	VARCHAR(30),
CONSTRAINT RECIPE_PK PRIMARY KEY (Recipe_ID),
CONSTRAINT RECIPE_FK1 FOREIGN KEY (Product_ID) REFERENCES PRODUCT(Product_ID)
ON UPDATE CASCADE
ON DELETE CASCADE)

CREATE TABLE REWARD
	(Reward_ID		NUMERIC(10,0)	NOT NULL,
	Customer_ID		NUMERIC(10,0)	NOT NULL,
	Order_ID		NUMERIC(6,0)	NOT NULL,
	Points_Amt		NUMERIC(3,0),
CONSTRAINT REWARD_PK PRIMARY KEY(Reward_ID),
CONSTRAINT REWARD_FK1 FOREIGN KEY (Customer_ID) REFERENCES CUSTOMER(Customer_ID)
ON UPDATE CASCADE
ON DELETE CASCADE,
CONSTRAINT REWARD_FK2 FOREIGN KEY (Order_ID) REFERENCES ORDER_T(Order_ID)
ON UPDATE NO ACTION
ON DELETE NO ACTION);

CREATE TABLE RECIPE_INGREDIENT
	(Recipe_ID		NUMERIC(3, 0)	     NOT NULL,
	Ingredient_ID  	NUMERIC(18, 0)       NOT NULL,
	Amount_Grams  	NUMERIC(2, 0),
CONSTRAINT RECIPE_INGREDIENT_PK PRIMARY KEY (Recipe_ID, Ingredient_ID),
CONSTRAINT RECIPE_INGREDIENT_FK1 FOREIGN KEY (Recipe_ID) REFERENCES RECIPE(Recipe_ID)
ON UPDATE CASCADE
ON DELETE CASCADE,
CONSTRAINT RECIPE_INGREDIENT_FK2 FOREIGN KEY (Ingredient_ID) REFERENCES INGREDIENT(Ingredient_ID)
ON UPDATE CASCADE
ON DELETE CASCADE)

CREATE TABLE ORDER_PRODUCT
	(Order_ID		NUMERIC(6, 0)  NOT NULL,
	Product_ID		NUMERIC(3, 0)  NOT NULL,
	Amount_Ordered  NUMERIC(2,0)
CONSTRAINT ORDER_PRODUCT_PK PRIMARY KEY (Order_ID, Product_ID),
CONSTRAINT ORDER_PRODUCT_FK1 FOREIGN KEY (Order_ID) REFERENCES ORDER_T(Order_ID)
ON UPDATE CASCADE
ON DELETE CASCADE,
CONSTRAINT ORDER_PRODUCT_FK2 FOREIGN KEY (Product_ID) REFERENCES PRODUCT(Product_ID)
ON UPDATE CASCADE
ON DELETE CASCADE)


CREATE TABLE INGREDIENT_SUPPLIER
	(Ingredient_ID    	NUMERIC(18, 0)     NOT NULL,
	Supplier_ID      	NUMERIC(18, 0)     NOT NULL,
	Amount_Supplied 	NUMERIC(6, 0),
	Date_Supplied   	DATE,
CONSTRAINT INGREDIENT_SUPPLIER_PK PRIMARY KEY (Ingredient_ID, Supplier_ID), 
CONSTRAINT INGREDIENT_SUPPLIER_FK1 FOREIGN KEY (Ingredient_ID) REFERENCES INGREDIENT(Ingredient_ID)
ON UPDATE CASCADE
ON DELETE CASCADE,
CONSTRAINT INGREDIENT_SUPPLIER_FK2 FOREIGN KEY (Supplier_ID) REFERENCES SUPPLIER(Supplier_ID)
ON UPDATE CASCADE
ON DELETE CASCADE) 


insert into SUPPLIER (Supplier_ID, Supplier_Name)
values
(111, 'Supplier 1'),
(112, 'Supplier 2'),
(113, 'Supplier 3'),
(114, 'Supplier 4');

insert into INGREDIENT (Ingredient_ID, Ingredient_Name, Ingredient_Quantity, Cost)
values
(211, 'Coffee Beans', 100, 20),
(221, 'Bagel', 50, 10),
(231, 'Cookie', 50, 5),
(241, 'Espresso Powder', 100, 15),
(251, 'Matcha Tea', 75, 50),
(261, 'Chai', 60, 60); 

insert into PRODUCT (Product_ID, Product_Name, Price)
values
(311, 'Black Coffee', 15),
(321, 'Espresso Shot', 10),
(331, 'Warm Cookie', 5),
(341, 'Toasted Bagel', 5),
(351, 'Caramel Frappe', 15),
(361, 'Choclate Muffin', 5);

insert into RECIPE (Recipe_ID, Product_ID, Recipe_Name)
values
(411, 311, 'Plain Coffee'),
(421, 321, 'Single Espresso Shot'),
(431, 331, 'Warmed Cookie'),
(441, 341, 'Bagel'); 


insert into ORDER_T (Order_ID, Employee_ID, Customer_ID, Specific_Date) 
values
(123456, 2468135790, 1234567890, '2022-04-09'),
(123457, 9753186420, 3210987654, '2022-12-25'),
(134567, 8642097531, 1234567890, '2022-01-01'),
(142526, 1357924680, 8901234567, '2023-02-16'),
(162728, 1357924680, 1098765432, '2021-04-08')

insert into REWARD (Reward_ID, Customer_ID, Order_ID, Points_Amt)
values
(2342103645, 3210987654, 123457, 10),
(3656589071, 1098765432, 162728, 5),
(5651221598, 1234567890, 123456, 10),
(6225823859, 5891263473, 134567, 5),
(8954232658, 8901234567, 142526, 10)

insert into EMPLOYEE (Employee_ID, First_Name, Last_Name, Phone_Number, Salary)
values
(1357924680, 'Alice', 'Wonder', 5555555555, 30000),
(2468135790, 'Peter', 'Panning', 5555556666, 36000),
(3698521470, 'Heracles', 'Strong', 5559990000, 42000),
(8642097531, 'Ella', 'Cinders', 5553334444, 53000),
(9753186420, 'Pinnochio', 'Truthful', 5557778888, 48000)

insert into CUSTOMER (Customer_ID, First_Name, Last_Name, Customer_Address, Email, Account_Password, Phone_Number)
values
(1098765432, 'Meryl', 'Streep', '888 Elm Rd', 'Meryl.Streep@email.com', 'Legendary#17', 5558765432),
(1234567890, 'Tobey', 'Maguire', '123 S Ave', 'Tobey_Maguire@gmail.com', 'SpiderMan*02', 5558765432),
(2109876543, 'Johnny',  'Depp',  '777 Oak Ave', 'Johnny.D@email.com', 'CaptainJack*16',	5559876543),
(2345678901, 'Scarlett', 'Johansson', '456 Elm Rd', 'Scarlett.Johansson@email.com', 'SecurePass#1', 5551234567),
(3210987654, 'Kristen', 'Stewart', '666 Manin St', 'Kris.S@email.com', 'TwilightStar#15',5550987654),
(3456789012, 'Chris', 'Hemsworth', '789 Oak Ave', 'Chris.Hemsworth@email.com', 'Celeb#Password2', 5552345678),
(4321098765, 'Will', 'Smith', '555 Elm Rd', 'Will.Smith@email.com', 'BoxOffice#14Pass', 5552109876),
(4567890123, 'Jennifer', 'Lawrence', '321 Pine Ln', 'Jennifer.Lawrence@email.com', 'StarSecure#3', 5555678901),
(5432109876, 'Charlize', 'Theron', '444 Willow Dr', 'Charlize.TheRon@email.com', 'Hollywoodstar*13', 5553210987),
(5678901234, 'Ryan', 'Reynolds', '567 Cedar St','Ryan.Reynolds@email.com', 'A-List#Pass4', 5556789012),
(5891263473, 'Keanu', 'Reeves', '999 Willow Dr', 'Keanu.Reeves@email.com', 'MatrixStar*18', 5557654321),
(6543210987, 'Leonardo', 'DiCaprio', '333 Birch Rd', 'Leo.DiCap@email.com', 'AwardWinner#12',5554321098),
(6789012345, 'Emma', 'Watson', '234 Birch Rd', 'Emma.Watson@email.com', 'Famous&Secure5', 5557890123),
(7654321098, 'Angelina', 'Jolie', '222 Cedar Ave', 'Angelina.Jolie@email.com', 'Brad;)<3',	5555432109),
(7890123456, 'Tom', 'Hanks', '890 Willow Dr', 'Tom.Hanks@email.com','Blockbuster#6',5558901234),
(8765432109, 'Brad', 'Pitt', '111 Oak St.', 'Brad.Pitt@email.com', 'Superstar*10Pass', 5556543210),
(8901234567, 'Margot', 'Robbie', '654 Maple Ave', 'Margot.Robbie@email.com','Hollywood*7Pass', 5559876543),
(8942321473, 'Angela', 'Bassett', '123 Pine Ln','Angela.Bassett@email.com', 'OscarWinner#19', 5559246530),
(9012345678, 'Robert', 'Downey Jr.', '432 Fir Ln','Robert.DJ@email.com', 'IronMan#8Pass', 5558765432),
(9876543210, 'Gal', 'Gadot', '876 Pine Rd', 'Gal.Gadot@email.com', 'WonderWoman#9', 5557654321)

insert into ORDER_PRODUCT (Order_ID, Product_ID, Amount_Ordered)
values
(123456, 311, 3),
(123457, 321, 4),
(134567, 311, 1),
(142526, 341, 2),
(162728, 311, 1)

insert into INGREDIENT_SUPPLIER (Ingredient_ID, Supplier_ID, Amount_Supplied, Date_Supplied)
values
(211, 111, 50, '2023-11-01'),
(221, 112, 30, '2023-11-02'),
(231, 113, 25, '2023-11-03'),
(241, 111, 75, '2023-11-01'),
(251, 114, 50, '2023-11-05'),
(261, 114, 30, '2023-11-05');

insert into RECIPE_INGREDIENT (Recipe_ID, Ingredient_ID, Amount_Grams)
values
(411, 211, 12),
(421, 241, 15),
(431, 231, 20),
(441, 221, 13); 