CREATE DATABASE shop;

USE shop;

CREATE TABLE SELLERS(
       SELL_ID    INTEGER, 
       SNAME   VARCHAR(20), 
       CITY    VARCHAR(20), 
       COMM    NUMERIC(2, 2),
             BOSS_ID  INTEGER
);
                                            
CREATE TABLE CUSTOMERS(
       CUST_ID    INTEGER, 
       CNAME   VARCHAR(20), 
       CITY    VARCHAR(20), 
       RATING  INTEGER
);

CREATE TABLE ORDERS(
       ORDER_ID  INTEGER, 
       AMT     NUMERIC(7,2), 
       ODATE   DATE, 
       CUST_ID    INTEGER,
       SELL_ID    INTEGER 
);

INSERT INTO SELLERS VALUES(201,'Олег','Москва',0.12,202);
INSERT INTO SELLERS VALUES(202,'Лев','Сочи',0.13,204);
INSERT INTO SELLERS VALUES(203,'Арсений','Владимир',0.10,204);
INSERT INTO SELLERS VALUES(204,'Екатерина','Москва',0.11,205);
INSERT INTO SELLERS VALUES(205,'Леонид ','Казань',0.15,NULL);


INSERT INTO CUSTOMERS VALUES(301,'Андрей','Москва',100);
INSERT INTO CUSTOMERS VALUES(302,'Михаил','Тула',200);
INSERT INTO CUSTOMERS VALUES(303,'Иван','Сочи',200);
INSERT INTO CUSTOMERS VALUES(304,'Дмитрий','Ярославль',300);
INSERT INTO CUSTOMERS VALUES(305,'Руслан','Москва',100);
INSERT INTO CUSTOMERS VALUES(306,'Артём','Тула',100);
INSERT INTO CUSTOMERS VALUES(307,'Юлия','Сочи',300);


INSERT INTO ORDERS VALUES(101,18.69,'2022-03-10',308,207);
INSERT INTO ORDERS VALUES(102,5900.1,'2022-03-10',307,204);
INSERT INTO ORDERS VALUES(103,767.19,'2022-03-10',301,201);
INSERT INTO ORDERS VALUES(104,5160.45,'2022-03-10',303,202);
INSERT INTO ORDERS VALUES(105,1098.16,'2022-03-10',308,207);
INSERT INTO ORDERS VALUES(106,75.75,'2022-04-10',304,202); 
INSERT INTO ORDERS VALUES(107,4723,'2022-05-10',306,201);
INSERT INTO ORDERS VALUES(108,1713.23,'2022-04-10',302,203);
INSERT INTO ORDERS VALUES(109,1309.95,'2022-06-10',304,203);
INSERT INTO ORDERS VALUES(110,9891.88,'2022-06-10',306,201);

-- **************************** hw-3 Tasks****************************************

select * from SELLERS;
select * from CUSTOMERS;
select * from ORDERS;

-- Вывести имя продавца и сумму его заказов.

SELECT t1.SNAME , SUM(t2.AMT) AS Summ_ORDERS
FROM SELLERS t1
INNER JOIN ORDERS t2
ON t1.SELL_ID = t2.SELL_ID
GROUP BY t1.SNAME;

-- Вывести имя клиента и сумму его заказов.

SELECT t1.CNAME , SUM(t2.AMT) AS Summ_Customer_ORDERS
FROM CUSTOMERS t1
INNER JOIN ORDERS t2
ON t1.CUST_ID = t2.CUST_ID
GROUP BY t1.CNAME;

-- Вывести всех продавцов, включая тех, у кого нет заказов.

SELECT t1.SNAME, SUM(t2.AMT) AS Summ_ORDERS
FROM SELLERS t1
LEFT JOIN ORDERS t2
ON t1.SELL_ID = t2.SELL_ID
GROUP BY t1.SNAME;

-- Вывести все заказы, включая информацию о продавцах, даже если не все продавцы сделали заказы.

SELECT t1.ORDER_ID, t1.AMT, t1.ODATE, t2.SNAME AS SELLER_Name , t2.CITY AS SELLER_CITY
FROM ORDERS t1
RIGHT JOIN SELLERS t2
ON t1.SELL_ID = t2.SELL_ID;

-- Вывести продавцов и их начальников

SELECT t1.SNAME AS SELLER_NAME, t2.SNAME AS BOSS_NAME
FROM SELLERS t1
LEFT JOIN SELLERS t2 
ON t1.BOSS_ID = t2.SELL_ID;

-- Найти всех клиентов из города "Москва" и суммы их заказов

SELECT t1.CNAME, t1.CITY, sum(t2.AMT) AS Summ_Orders
FROM CUSTOMERS t1
INNER JOIN ORDERS t2
ON t1.CUST_ID = t2.CUST_ID
WHERE t1.CITY = 'Москва'
GROUP BY t1.CNAME;

-- Найти всех продавцов из города "Сочи" и их заказы, если таковые имеются.

SELECT t1.SNAME, t1.CITY, t2.ORDER_ID, t2.AMT, t2.ODATE
FROM SELLERS t1
LEFT JOIN ORDERS t2
ON t1.SELL_ID = t2.SELL_ID
WHERE t1.CITY = 'Сочи';

-- Найти всех клиентов с заказами выше 5000 и информацию о продавцах, которые их обслуживали.

SELECT t1.CNAME ,t2.AMT, t3.SNAME AS SELLER_NAME, t3.CITY AS SELLER_CITY
FROM CUSTOMERS t1
INNER JOIN ORDERS t2
ON t1.CUST_ID = t2.CUST_ID
INNER JOIN SELLERS t3
ON t2.SELL_ID = t3.SELL_ID
WHERE t2.AMT > 5000;

-- Найти всех продавцов, у которых есть начальники.

SELECT t1.SNAME,t2.SNAME AS BOSS_NAME
FROM SELLERS t1
INNER JOIN SELLERS t2 ON t1.BOSS_ID = t2.SELL_ID;

-- Вывести пары покупателей и обслуживших их продавцов из одного города.

SELECT t1.CNAME AS CUSTOMER_NAME, t3.SNAME AS SELLER_NAME, t1.CITY
FROM CUSTOMERS t1
INNER JOIN ORDERS t2
ON t1.CUST_ID = t2.CUST_ID
INNER JOIN SELLERS t3
ON t2.SELL_ID = t3.SELL_ID
WHERE t1.CITY = t3.CITY;
















