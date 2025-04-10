SELECT *
FROM Zomato_data zd  ;

-- MAX, MIN & AVG COST BY SERVING
SELECT 
   zd.`listed_in(type)` AS `RESTURANT TYPE`,
   MAX(zd.`approx_cost(for two people)`) AS `MAX COST FOR 2 PEOPLE`,
   MIN(zd.`approx_cost(for two people)`) AS `MIN COST FOR 2 PEOPLE`,
   ROUND(AVG(zd.`approx_cost(for two people)`)) AS `AVG COST FOR 2 PEOPLE`
FROM 
	Zomato_data zd
GROUP BY 
	zd.`listed_in(type)`;

-- TOP 10 HIGH COST RESTURANTS 
SELECT DISTINCT
   zd.name, 
   MAX(zd.`approx_cost(for two people)`) AS `COST FOR 2 PEOPLE`,
   SUM(b.`Weekly Revenue`) AS `WEEKLY REVENUE`
FROM 
	Zomato_data zd
JOIN 
	Book b ON zd.name = b.Name 
GROUP BY 
	zd.name
ORDER BY 
	`COST FOR 2 PEOPLE` DESC
LIMIT 10;

-- TOP 10 LOW COST RESTURANTS 
SELECT DISTINCT
   zd.name, 
   MAX(zd.`approx_cost(for two people)`) AS `COST FOR 2 PEOPLE`,
   SUM(b.`Weekly Revenue`) AS `WEEKLY REVENUE`
FROM 
	Zomato_data zd
JOIN 
	Book b ON zd.name = b.Name 
GROUP BY 
	zd.name
ORDER BY 
	`COST FOR 2 PEOPLE` ASC
LIMIT 10;

-- EFFECT OF COST ON RESTURANT SELECTION
SELECT DISTINCT
	zd.name AS `RESTURANTS`,
	zd.`approx_cost(for two people)` AS `COST FOR 2 PEOPLE`,
	b.`Daily Vistors` AS `DAILY VISITORS`,
	b.`Weekly Revenue` AS `WEEKLY REVENUE`
FROM Zomato_data zd 
JOIN Book b ON zd.name = b.Name
ORDER BY `WEEKLY REVENUE`DESC;

-- EFFECT OF SERVING TYPE ON RESTURANT(NAME WISE) REVENUE
SELECT DISTINCT
	zd.name AS `RESTURANTS`,
	zd.`listed_in(type)` AS `SERVING TYPE`,
	b.`Daily Vistors` AS `DAILY VISITORS`,
	b.`Weekly Revenue` AS `WEEKLY REVENUE`
FROM Zomato_data zd 
JOIN Book b ON zd.name = b.Name
ORDER BY `WEEKLY REVENUE`DESC;

-- EFFECT OF SERVING TYPE ON REVENUES
SELECT 
	zd.`listed_in(type)` AS `SERVING TYPE`,
	COUNT(DISTINCT zd.name) AS `NUMBER OF RESTURANTS`,
	ROUND(AVG(b.`Weekly Revenue`)) AS `AVERAGE WEEKLY REVENUE`
FROM 
	Zomato_data zd 
JOIN
	Book b ON zd.name = b.Name 
GROUP BY 
	zd.`listed_in(type)` ;

-- HOW MUCH ENABLED ONLINE ORDER OPTION EFFECTS RESTURTANT REVENUE
SELECT
    zd.online_order AS `ONLINE ORDER ENABLED`,
    COUNT(DISTINCT zd.name) AS `NUMBER OF RESTAURANTS`,
    ROUND(AVG(b.`Weekly Revenue`)) AS `AVERAGE WEEKLY REVENUE`
FROM
    Zomato_data zd
JOIN
    Book b ON zd.name = b.Name
GROUP BY
    zd.online_order;
   
-- EFFECT OF TABLE BOOKING OPTION ON REVENUE
SELECT 
	zd.book_table AS `TABLE BOOKING OPTION EANABLED`,
	COUNT(DISTINCT zd.name) AS `NUMBER OF RESTURANTS`,
	ROUND(AVG(b.`Weekly Revenue`)) AS `AVERAGE WEEKLY REVENUE`
FROM 
	Zomato_data zd 
JOIN
	Book b ON zd.name = b.Name 
GROUP BY 
	zd.book_table ;

-- MAX, MIN & AVG WEEKLY REVENUE
SELECT 
   MAX(b.`Weekly Revenue`) AS `MAX WEEKLY REVENUE`,
   MIN(b.`Weekly Revenue`) AS `MIN WEEKLY REVENUE`,
   ROUND(AVG(b.`Weekly Revenue`)) AS `AVG WEEKLY REVENUE`,
   ROUND(STDDEV_POP(b.`Weekly Revenue`)) AS `STANDARD DEVIATION`,
   ROUND(MAX(b.`Weekly Revenue`) - MIN(b.`Weekly Revenue`)) AS `RANGE`
FROM 
	Book b 
;
-- DOES RATING REALLY EFFECTS REVENUE
 SELECT 
	zd.rate  AS `RATING`,
	COUNT(zd.name) AS `NUMBER OF RESTURANTS`,
	ROUND(AVG(b.`Weekly Revenue`)) AS `AVERAGE WEEKLY REVENUE`
FROM 
	Zomato_data zd 
JOIN
	Book b ON zd.name = b.Name 
GROUP BY 
	zd.rate 
ORDER BY
	`AVERAGE WEEKLY REVENUE` DESC;
	
-- DIFFERENT SERVING TYPES WITH COST RANK
SELECT
    `listed_in(type)`,
    name AS `RESTAURANT`,
    `approx_cost(for two people)` AS `COST`,
    ROW_NUMBER() OVER (PARTITION BY `listed_in(type)` ORDER BY `approx_cost(for two people)` DESC) AS `COST RANK WITHIN TYPE`
FROM
    Zomato_data;




