create database airtraffic;

create table traffic(
active_period int not null,
Operating_Airline  text not null,
Operating_Airline_IATA_Code text not null,
Published_Airline text not null,
Published_Airline_IATA_Code text not null,
GEO_Summary text not null,
GEO_Region text not null,
Landing_Aircraft_Type text not null,
Aircraft_Body_Type text not null,
Aircraft_Manufacturer text not null,
Aircraft_Model text not null,
Aircraft_Version text not null,
Landing_Count int not null,
Total_Landed_Weight int not null
);

SELECT * FROM airtraffic.traffic WHERE Operating_Airline = 'Airline A';


SELECT 
    Operating_Airline,
    SUM(Landing_Count) AS Total_Landings,
    SUM(Total_Landed_Weight) AS Total_Weight
FROM
    airtraffic.traffic
GROUP BY Operating_Airline;

SELECT 
    Aircraft_Model,
    AVG(Landing_Count) AS Avg_Landings,
    AVG(Total_Landed_Weight) AS Avg_Weight
FROM
    traffic
GROUP BY Aircraft_Model;


SELECT DISTINCT
    Aircraft_Model
FROM
    airtraffic.traffic
WHERE
    GEO_Region = 'Europe';
    
    
    
SELECT 
    Operating_Airline, SUM(Landing_Count) AS Total_Landings
FROM
    traffic
GROUP BY Operating_Airline
ORDER BY Total_Landings DESC
LIMIT 1;

  
  
SELECT 
    *
FROM
    airtraffic.traffic
WHERE
    Total_Landed_Weight = (SELECT 
            MAX(Total_Landed_Weight)
        FROM
            traffic);

    
SELECT 
    GEO_Region,
    SUM(Landing_Count) AS Total_Landings,
    SUM(Total_Landed_Weight) AS Total_Weight
FROM
    traffic
GROUP BY GEO_Region;


SELECT 
    *
FROM
    traffic
WHERE
    Operating_Airline LIKE '%Air%';


SELECT 
    Operating_Airline, LENGTH(Operating_Airline) AS Name_Length
FROM
    traffic;


SELECT 
    Operating_Airline, Aircraft_Model, COUNT(*) AS Frequency
FROM
    airtraffic.traffic
GROUP BY Operating_Airline , Aircraft_Model
HAVING COUNT(*) = (SELECT 
        MAX(Model_Frequency)
    FROM
        (SELECT 
            COUNT(*) AS Model_Frequency
        FROM
            airtraffic.traffic
        GROUP BY Operating_Airline , Aircraft_Model) AS Subquery);



SELECT Operating_Airline,
    CASE
        WHEN SUM(Landing_Count) > 1000 THEN 'High Traffic'
        WHEN SUM(Landing_Count) BETWEEN 500 AND 1000 THEN 'Medium Traffic'
        ELSE 'Low Traffic'
    END AS Traffic_Category
FROM airtraffic.traffic
GROUP BY Operating_Airline;


WITH RECURSIVE Period_Sequence AS (
    SELECT 202401 AS activeperiod
    UNION ALL
    SELECT activeperiod + 1
    FROM Period_Sequence
    WHERE activeperiod < 202412
)
SELECT * FROM Period_Sequence;





