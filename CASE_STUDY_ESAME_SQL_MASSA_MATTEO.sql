/* TASK_2 Descrivi la struttura delle tabelle che reputi utili e sufficienti a modellare lo scenario proposto tramite la sintassi DDL. 
Implementa fisicamente le tabelle utilizzando il DBMS SQL Server(o altro).*/ 

Create Database GourmetShopDB ;      /* CREO DATABASE */

use GourmetShopDB;                   /* AVVIO L'UTILIZZO DEL DATABASE */

/* CREO LE TABELLE E LE COLONNE CON NOME E TIPOLOGIA DEL CONTENUTO */


CREATE TABLE Category (
Category_ID INT PRIMARY KEY,                                        
Category_Name VARCHAR(50)); 

SELECT * FROM Category;

CREATE TABLE Product (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(50),
    Description VARCHAR(100),
    Category_ID INT,
    FOREIGN KEY (Category_ID) REFERENCES Category(Category_ID)
);

SELECT * FROM Product;

CREATE TABLE Region (
    Region_ID INT PRIMARY KEY,
    Region_Name VARCHAR(50)
);

SELECT * FROM Region;

CREATE TABLE Country (
    Country_ID INT PRIMARY KEY,
    Country_Name VARCHAR(50),
    Region_ID INT,
    FOREIGN KEY (Region_ID) REFERENCES Region(Region_ID)
);


SELECT * FROM Country;

CREATE TABLE Sales (
    Sales_ID INT PRIMARY KEY,
    Sale_Date DATE,
    Price DECIMAL(10,2),
    Quantity INT,
    Product_ID INT,
    Country_ID INT,
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
    FOREIGN KEY (Country_ID) REFERENCES Country(Country_ID)
);

SELECT * FROM Sales;

/* Task 3: Popola le tabelle utilizzando dati a tua discrezione 
(sono sufficienti pochi record per tabella */

/* popolamento delle tabelle in ordine di inserimento*/

INSERT INTO Category (Category_ID, Category_Name) VALUES
(1, 'Pentole'),
(2, 'Utensili'),
(3, 'Elettrodomestici');

SELECT * FROM category;

INSERT INTO Product  VALUES
(1, 'Padella', 'Padella antiaderente in alluminio', 1),
(2, 'Coltello da chef', 'Acciaio inox con manico ergonomico', 2),
(3, 'Frullatore', 'Frullatore da cucina 1000W', 3);

INSERT INTO Product  VALUES
(4, 'Tagliere', 'Tagliere in bambù naturale', 2); -- prodotto invenduto

SELECT * FROM Product;

INSERT INTO Region (Region_ID, Region_Name) VALUES
(1, 'Europa'),
(2, 'Asia'),
(3, 'America');

SELECT * FROM Region;
 
INSERT INTO Country (Country_ID, Country_Name, Region_ID) VALUES
(1, 'Italia', 1),
(2, 'Giappone', 2),
(3, 'Stati Uniti', 3);

SELECT * FROM Country;

INSERT INTO Sales  VALUES
(1, '2025-01-22', 39.90, 2, 1, 1),
(2, '2024-03-07', 15.50, 4, 2, 2),
(3, '2025-10-13', 89.00, 1, 3, 3);

SELECT * FROM Sales;

/* TASK_4 1) Verificare che i campi definiti come PK siano univoci. In altre parole, 
scrivi una query per determinare l’univocità dei valori di ciascuna PK 
(una query per tabella implementata).*/

              
SELECT Category_ID, COUNT(*) AS Occorrenze
FROM Category
GROUP BY Category_ID
HAVING COUNT(*) > 1;

SELECT Product_ID, COUNT(*) AS Occorrenze
FROM Product
GROUP BY Product_ID
HAVING COUNT(*) > 1;

SELECT Region_ID, COUNT(*) AS Occorrenze
FROM Region
GROUP BY Region_ID
HAVING COUNT(*) > 1;

SELECT Country_ID, COUNT(*) AS Occorrenze
FROM Country
GROUP BY Country_ID
HAVING COUNT(*) > 1;

SELECT Sales_ID, COUNT(*) AS Occorrenze
FROM Sales
GROUP BY Sales_ID
HAVING COUNT(*) > 1; 

/* TASK_4 2) Esporre l’elenco delle transazioni indicando nel result set il codice documento, la data, il nome del prodotto, 
la categoria del prodotto, il nome dello stato, 
il nome della regione di vendita e un campo booleano valorizzato in base alla condizione 
che siano passati più di 180 giorni dalla data vendita o meno (>180 -> True, <= 180 -> False).*/


              
SELECT
S.Sales_ID AS Sale_Code,
S.Sale_Date AS Sale_Date,
P.Product_Name AS Product_Name,
C.Category_Name AS Product_Category,
CO.Country_Name AS Country,
R.Region_Name AS Sales_Region,
IF(DATEDIFF(CURDATE(), S.Sale_Date) > 180, 'True', 'False') AS Over180Days
FROM Sales AS S
JOIN Product AS P ON S.Product_ID = P.Product_ID
JOIN Category AS C ON P.Category_ID = C.Category_ID
JOIN Country AS CO ON S.Country_ID = CO.Country_ID
JOIN Region AS R ON CO.Region_ID = R.Region_ID;

/* TASK_4 3) Esporre l’elenco dei prodotti che hanno venduto, in totale, 
una quantità maggiore della media delle vendite realizzate nell’ultimo anno censito. 
(ogni valore della condizione deve risultare da una query e non deve essere inserito a mano). 
Nel result set devono comparire solo il codice prodotto e il totale venduto. */                                     

              
SELECT 
S.Product_ID,
SUM(S.Price * S.Quantity) AS Totale_Venduto
FROM Sales AS S
WHERE YEAR(S.Sale_Date) = (SELECT MAX(YEAR(Sale_Date)) FROM Sales)
GROUP BY S.Product_ID
HAVING SUM(S.Quantity) >= (
SELECT AVG(Quantity)
FROM Sales
WHERE YEAR(Sale_Date) = (SELECT MAX(YEAR(Sale_Date)) FROM Sales)
);

/* TASK_4 4) Esporre l’elenco dei soli prodotti venduti e per ognuno di questi il fatturato totale per anno. */

SELECT 
P.Product_ID,
P.Product_Name,   
YEAR(S.Sale_Date) AS Anno,
SUM(S.Price * S.Quantity) AS Totale_Fatturato
FROM Product AS P
JOIN Sales AS S ON P.Product_ID = S.Product_ID
GROUP BY P.Product_ID, P.Product_Name, YEAR(S.Sale_Date);

/* TASK_4 5) Esporre il fatturato totale per stato per anno. Ordina il risultato per data e per fatturato decrescente.*/

SELECT 
CO.Country_Name,
YEAR(S.Sale_Date) AS Anno,
SUM(S.Price * S.Quantity) AS Totale_Fatturato
FROM Sales AS S
JOIN Country AS CO ON S.Country_ID = CO.Country_ID
GROUP BY CO.Country_Name, YEAR(S.Sale_Date)
ORDER BY Anno, Totale_Fatturato DESC;

/* TASK_4 6) Rispondere alla seguente domanda: qual è la categoria di articoli maggiormente richiesta dal mercato?.*/

SELECT 
C.Category_Name,
SUM(S.Quantity) AS Totale_Venduto
FROM Sales AS S
JOIN Product AS P ON S.Product_ID = P.Product_ID
JOIN Category AS C ON P.Category_ID = C.Category_ID
GROUP BY C.Category_Name
ORDER BY Totale_Venduto DESC;

/*TASK_4 7)	Rispondere alla seguente domanda: quali sono i prodotti invenduti? Proponi due approcci risolutivi differenti.*/

SELECT 
P.Product_ID,
P.Product_Name
FROM Product AS P
LEFT JOIN Sales AS S ON P.Product_ID = S.Product_ID
WHERE S.Product_ID IS NULL;

/*TASK_4 8) Creare una vista sui prodotti in modo tale da esporre una “versione denormalizzata” delle informazioni utili 
(codice prodotto, nome prodotto, nome categoria) */

CREATE VIEW Product_View AS
SELECT 
P.Product_ID AS Codice_Prodotto,
P.Product_Name AS Nome_Prodotto,
C.Category_Name AS Nome_Categoria
FROM Product AS P
JOIN Category AS C ON P.Category_ID = C.Category_ID;

/* TASK_4 9) Creare una vista per le informazioni geografiche */

CREATE VIEW Geographic_Info AS
SELECT 
R.Region_ID,
R.Region_Name,
CO.Country_Name
FROM Region AS R
JOIN Country AS CO ON R.Region_ID = CO.Region_ID;

SELECT * FROM geographic_info
