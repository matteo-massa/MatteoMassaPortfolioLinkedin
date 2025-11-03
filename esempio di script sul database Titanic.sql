
SELECT * FROM Titanic.titanic;
SELECT COUNT(*) AS TotalePasseggeri FROM titanic;
SHOW COLUMNS FROM titanic;
SELECT COUNT(*) AS PasseggeriValidi
FROM titanic
WHERE Survived IS NOT NULL;
SELECT Pclass, Survived, COUNT(*) AS Conteggio
FROM titanic
WHERE Survived IS NOT NULL
GROUP BY Pclass, Survived
ORDER BY Pclass, Survived;
SELECT Pclass, Survived, COUNT(*) AS Conteggio
FROM titanic
WHERE Survived IS NOT NULL
GROUP BY Pclass, Survived
ORDER BY Pclass, Survived;
SELECT *
FROM titanic
WHERE PassengerId <= 891;
SELECT COUNT(*) AS TotaleValidi
FROM titanic
WHERE PassengerId <= 891;
SELECT Survived, COUNT(*) AS Conteggio
FROM titanic
WHERE PassengerId <= 891
GROUP BY Survived;
SELECT Sex, COUNT(*) AS Conteggio
FROM titanic
WHERE PassengerId <= 891
GROUP BY Sex;
SELECT Sex, Survived, COUNT(*) AS Conteggio
FROM titanic
WHERE PassengerId <= 891
GROUP BY Sex, Survived
ORDER BY Sex, Survived;
SELECT Sex, Pclass, Survived, COUNT(*) AS Conteggio
FROM titanic
WHERE PassengerId <= 891
GROUP BY Sex, Pclass, Survived
ORDER BY Sex, Pclass, Survived;
SELECT (SibSp + Parch) AS DimensioneFamiglia, COUNT(*) AS Conteggio
FROM titanic
WHERE PassengerId <= 891
GROUP BY DimensioneFamiglia
ORDER BY DimensioneFamiglia;
SELECT COUNT(*) AS TotalePasseggeri
FROM titanic
WHERE PassengerId <= 891;
SELECT Survived, COUNT(*) AS Conteggio
FROM titanic
WHERE PassengerId <= 891
GROUP BY Survived;SELECT Sex, Survived, COUNT(*) AS Conteggio
FROM titanic
WHERE PassengerId <= 891
GROUP BY Sex, Survived
ORDER BY Sex, Survived;
SELECT Pclass, Survived, COUNT(*) AS Conteggio
FROM titanic
WHERE PassengerId <= 891
GROUP BY Pclass, Survived
ORDER BY Pclass, Survived;
SELECT Pclass,
       COUNT(*) AS TotalePasseggeri,
       SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END) AS Sopravvissuti,
       ROUND(SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS PercentualeSopravvivenza
FROM titanic
WHERE PassengerId <= 891
GROUP BY Pclass
ORDER BY Pclass;
SELECT
  CASE WHEN Cabin IS NOT NULL THEN 'Cabina Assegnata' ELSE 'Senza Cabina' END AS TipoCabina,
  COUNT(*) AS TotalePasseggeri,
  SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END) AS Sopravvissuti,
  ROUND(SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS PercentualeSopravvivenza
FROM titanic
WHERE PassengerId <= 891
GROUP BY TipoCabina;
SELECT COUNT(*) AS CabineVuote
FROM titanic
WHERE PassengerId <= 891 AND (Cabin IS NULL OR Cabin = '');
SELECT
  CASE WHEN Cabin IS NOT NULL AND Cabin <> '' THEN 'Cabina Assegnata' ELSE 'Senza Cabina' END AS TipoCabina,
  COUNT(*) AS TotalePasseggeri,
  SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END) AS Sopravvissuti,
  ROUND(SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS PercentualeSopravvivenza
FROM titanic
WHERE PassengerId <= 891
GROUP BY TipoCabina;
SELECT
  CASE WHEN Cabin IS NOT NULL AND Cabin <> '' THEN 'Cabina Assegnata' ELSE 'Senza Cabina' END AS TipoCabina,
  COUNT(*) AS TotalePasseggeri,
  SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END) AS Sopravvissuti,
  ROUND(SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS PercentualeSopravvivenza
FROM titanic
WHERE PassengerId <= 891
GROUP BY TipoCabina;
SELECT
  CASE WHEN Cabin IS NOT NULL AND Cabin <> '' THEN 'Cabina Assegnata' ELSE 'Senza Cabina' END AS TipoCabina,
  Sex,
  COUNT(*) AS TotalePasseggeri,
  SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END) AS Sopravvissuti,
  ROUND(SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS PercentualeSopravvivenza
FROM titanic
WHERE PassengerId <= 891
GROUP BY TipoCabina, Sex
ORDER BY TipoCabina, Sex;

SELECT
  CASE WHEN Cabin IS NOT NULL AND Cabin <> '' THEN 'Cabina Assegnata' ELSE 'Senza Cabina' END AS TipoCabina,
  COUNT(*) AS TotalePasseggeri,
  SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END) AS Sopravvissuti,
  ROUND(SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS PercentualeSopravvivenza
FROM titanic
WHERE PassengerId <= 891
GROUP BY TipoCabina;
SELECT
  Pclass AS Classe,
  COUNT(*) AS TotalePasseggeri,
  SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END) AS Sopravvissuti,
  ROUND(SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS PercentualeSopravvivenza
FROM titanic
WHERE PassengerId <= 891
GROUP BY Pclass
ORDER BY Pclass;
SELECT
  CASE WHEN Cabin IS NOT NULL AND Cabin <> '' THEN 'Cabina Assegnata' ELSE 'Senza Cabina' END AS TipoCabina,
  COUNT(*) AS TotalePasseggeri,
  SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END) AS Sopravvissuti,
  ROUND(SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS PercentualeSopravvivenza,
  ROUND(COUNT(*) / (SELECT COUNT(*) FROM titanic WHERE PassengerId <= 891) * 100, 2) AS PercentualeIncidenzaSulTotale
FROM titanic
WHERE PassengerId <= 891
GROUP BY TipoCabina;
SELECT
  Sex,
  CASE WHEN Cabin IS NOT NULL AND Cabin <> '' THEN 'Cabina Assegnata' ELSE 'Senza Cabina' END AS TipoCabina,
  COUNT(*) AS TotalePasseggeri,
  SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END) AS Sopravvissuti,
  ROUND(SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS PercentualeSopravvivenza
FROM titanic
WHERE PassengerId <= 891
GROUP BY Sex, TipoCabina
ORDER BY Sex, TipoCabina;











SELECT
  Pclass AS Classe,
  COUNT(*) AS TotalePasseggeri,
  SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END) AS Sopravvissuti,
  ROUND(SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS PercentualeSopravvivenza
FROM titanic
WHERE PassengerId <= 891
GROUP BY Pclass
ORDER BY Pclass;