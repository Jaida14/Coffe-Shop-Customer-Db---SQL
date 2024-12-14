--1. Multiple Table Join
--Retrieve the names of customers who have placed orders and the employee who took the order.
SELECT C.First_Name, C.Last_Name, E.First_Name AS Employee_FirstName, E.Last_Name AS Employee_LastName
FROM CUSTOMER C
JOIN ORDER_T O ON C.Customer_ID = O.Customer_ID
JOIN EMPLOYEE E ON O.Employee_ID = E.Employee_ID;

--2. Subquery
--Find the number of orders that contained a sepecific product (i.e., 311 or Black Coffee).
SELECT COUNT(Order_ID) as Number_Ordered from ORDER_T
WHERE Order_ID IN (SELECT Order_ID FROM ORDER_PRODUCT WHERE Product_ID = 311)

--3. Correlated Subquery
--Retrieve suppliers who we spent above a certain threshold (i.e., 300) for ingredients

SELECT DISTINCT Supplier_ID, Supplier_Name
FROM SUPPLIER s
WHERE EXISTS (
    SELECT 1
    FROM INGREDIENT_SUPPLIER isup
    JOIN INGREDIENT i ON isup.Ingredient_ID = i.Ingredient_ID
    WHERE isup.Supplier_ID = s.Supplier_ID
    AND i.Cost * isup.Amount_Supplied > 300)

--4. GROUP BY
--Count the number of orders placed by each customer.

SELECT Customer_ID, COUNT(Order_ID) AS Order_Count
FROM ORDER_T
GROUP BY Customer_ID

--5. GROUP BY with HAVING
--Retrieve suppliers who have supplied ingredients with a total quantity greater than a specified threshold.
SELECT s.Supplier_ID, s.Supplier_Name, SUM(isup.Amount_Supplied) AS TotalSupply
FROM SUPPLIER s
JOIN INGREDIENT_SUPPLIER isup ON s.Supplier_ID = isup.Supplier_ID
GROUP BY s.Supplier_ID, s.Supplier_Name
HAVING SUM(isup.Amount_Supplied) >= 50

--6. ORDER BY
--Retrieve a list of employees ordered by their last name in ascending order.
SELECT Employee_ID, First_Name, Last_Name
FROM EMPLOYEE
ORDER BY Last_Name ASC;

--7. IN or NOT IN
--Find products that are not included in any order.
SELECT Product_Name
FROM PRODUCT
WHERE Product_ID NOT IN (
    SELECT Product_ID FROM ORDER_PRODUCT
);

--8. Built-in Function (e.g., AVG)
--Calculate the average salary of employees.
SELECT CAST(AVG(Salary) AS NUMERIC(7,2)) AS Average_Salary
FROM EMPLOYEE

--9. EXISTS or NOT EXISTS

-- Example: Find customers who have received rewards
SELECT First_Name, Last_Name, Phone_Number
FROM CUSTOMER c
WHERE EXISTS (
    SELECT 1
    FROM REWARD r
    WHERE r.Customer_ID = c.Customer_ID
)

--10. Other Advanced SQL
-- Retrieve a list of ingredients used in either Recipe 411 (Plain Coffee) or Recipe 431 (Warmed Cookie)
SELECT
    ri.Ingredient_ID,
    i.Ingredient_Name
FROM
    RECIPE_INGREDIENT ri
JOIN
    INGREDIENT i ON ri.Ingredient_ID = i.Ingredient_ID
WHERE
    ri.Recipe_ID = 411 

UNION

SELECT
    ri.Ingredient_ID,
    i.Ingredient_Name
FROM
    RECIPE_INGREDIENT ri
JOIN
    INGREDIENT i ON ri.Ingredient_ID = i.Ingredient_ID
WHERE
    ri.Recipe_ID = 431