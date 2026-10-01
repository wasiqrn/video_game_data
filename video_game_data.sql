 CREATE DATABASE e_data;
 
  
 USE e_data;
 
 SELECT * FROM e_data.video_game_data;
 
SELECT ROUND(SUM(Global_Revenue_M),2) AS total_sale
FROM video_game_data;

SELECT ROUND(AVG(User_Score),2) AS avg_score
FROM video_game_data; 

SELECT DISTINCT(Sales_Channel) AS unique_channel
FROM video_game_data;

SELECT DISTINCT( Region) AS unique_region
FROM video_game_data;

SELECT count(*) AS total_count
FROM video_game_data;

SELECT DISTINCT(Platform) AS unique_plateform
FROM video_game_data;


 -- 1 Which platform has the highest total global revenue?
 SELECT Platform,ROUND(SUM(Global_Revenue_M),2) AS total_sale
 FROM video_game_data
 GROUP BY Platform
 ORDER BY total_sale DESC;
 
 
-- 2 Which genre has the highest total units sold?
SELECT genre,ROUND(SUM(Units_Sold_M),2) AS total_unit_sold
FROM video_game_data
GROUP BY genre
ORDER BY total_unit_sold DESC;


-- 3 Which region generates the highest total global revenue?
SELECT region,ROUND(SUM(Global_Revenue_M),2) AS region_revn
FROM video_game_data
GROUP BY region
ORDER BY region_revn DESC;


-- 4 Which sales channel generates the highest total revenue?
SELECT Sales_Channel, ROUND(SUM(Global_Revenue_M),2) AS total_sales_channel
FROM video_game_data
GROUP BY Sales_Channel
ORDER BY total_sales_channel DESC;



-- 5 How does total global revenue change year by year?
SELECT YEAR(Release_Date) AS yearr,ROUND(SUM(Global_Revenue_M),2) AS sales_trend
FROM video_game_data
GROUP BY yearr
ORDER BY yearr DESC;


-- 6 Which 10 games have the highest global revenue?
SELECT Game_Title, ROUND(SUM(Global_Revenue_M),2) AS game_rev
FROM video_game_data
GROUP BY Game_Title
ORDER by game_rev DESC
LIMIT 10;



-- 7 Which 10 games have the highest units sold?

SELECT Game_Title, ROUND(SUM(Units_Sold_M),2) AS total_game_sold
FROM video_game_data
GROUP BY Game_Title
ORDER BY total_game_sold DESC
LIMIT 10;
 
 
-- 8 What is the average user score for each genre?
SELECT Genre,ROUND(AVG(User_Score),2) AS avg_score
FROM video_game_data
GROUP BY Genre
ORDER BY avg_score DESC;


-- 9 Which publisher has the highest total global revenue?
SELECT Publisher, ROUND(SUM(Global_Revenue_M),2) publisher_rev
FROM video_game_data
GROUP BY Publisher
ORDER BY publisher_rev DESC;
 

-- Which games have high user scores but low units sold?
SELECT Game_Title,
ROUND(AVG(User_Score),2) AS avg_score,
ROUND(SUM(Units_Sold_M),2) AS total_sold
FROM video_game_data
GROUP BY Game_Title
ORDER BY avg_score DESC,total_sold ASC;


 


-- Which Platform–Genre combination has the highest total Global Revenue?
SELECT Platform,Genre,ROUND(SUM(Global_Revenue_M),2) AS total_rvn
FROM video_game_data
GROUP BY Platform, Genre
ORDER BY total_rvn DESC;


-- Which games have a User Score above 8 but Units Sold below 2 million?
SELECT Game_Title,AVG(User_Score) AS avg_score, ROUND(SUM(Units_Sold_M),2) AS total_sold
FROM video_game_data
GROUP BY Game_Title
HAVING avg_score>8 AND total_sold<2;


   
-- 3 Rank all games within each Platform based on their Units_Sold_M.
SELECT Game_Title,Platform,Units_Sold_M,
RANK ()
OVER(PARTITION BY Platform ORDER BY Units_Sold_M DESC) AS sale_rank
FROM video_game_data;


 SELECT * FROM e_data.video_game_data;
 
-- Find the top 3 games by Global_Revenue_M within each Genre.
SELECT *
FROM (SELECT Game_Title,Genre,ROUND(SUM(Global_Revenue_M),2) AS total_revenue,
RANK() 
OVER (PARTITION BY Genre ORDER BY SUM(Global_Revenue_M) DESC) AS revenue_rank 
FROM video_game_data
GROUP BY Game_Title, Genre) AS ranked_games
WHERE revenue_rank <= 3;


-- Calculate the running total of Global_Revenue_M for each Release_Year.
SELECT YEAR(Release_Date) AS Release_Year,
ROUND(SUM(Global_Revenue_M),2) AS Year_Revenue,
ROUND(SUM(SUM(Global_Revenue_M))
OVER (ORDER BY YEAR(Release_Date)),2) AS Running_Total
FROM video_game_data
GROUP BY YEAR(Release_Date)
ORDER BY Release_Year;



-- Rank publishers based on their total Global_Revenue_M using a window function.

SELECT Publisher,
SUM(Global_Revenue_M) AS total_revenue,
RANK()
OVER (ORDER BY SUM(Global_Revenue_M) DESC) AS revenue_rank
FROM video_game_data
GROUP BY Publisher;
 
