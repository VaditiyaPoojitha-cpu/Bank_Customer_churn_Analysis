CREATE DATABASE Bank_Churn
SELECT * FROM Customer_info
SELECT * FROM Account_info

ALTER TABLE Account_info
DROP Column Column10

--1.Overall Churn Rate
SELECT COUNT(CustomerId) AS Total_Customer,
	SUM(CAST(Exited AS INT)) AS Total_Churned,
	ROUND(SUM(CAST(Exited AS INT)) * 100 / COUNT(CustomerId),2) AS Churn_Rate
FROM Account_info

--2.Churn Rate by Geography and Gender
SELECT c.Geography,c.Gender,
	COUNT(c.CustomerId) AS Total_Customer,
	SUM(CAST(a.Exited AS INT)) AS Total_Churned,
	ROUND(SUM(CAST(a.Exited AS INT)) * 100 / COUNT(c.CustomerId),2) AS Churn_Rate
FROM Customer_info AS c
JOIN Account_info AS a
ON a.CustomerId = c.CustomerId
GROUP BY c.Geography,c.Gender
ORDER BY Churn_Rate DESC

--3.High Value At-risk Customer
SELECT c.CustomerId,c.Surname,c.Geography,a.Balance,a.Exited
FROM Customer_info AS c
JOIN Account_info AS a
ON a.CustomerId = c.CustomerId
WHERE a.Exited = 1 AND a.Balance > 100000
ORDER BY a.Balance DESC
