--1. BASIC KPI (Dashboard Cards)
SELECT 
    COUNT(*) AS total_restaurants,
    COUNT(DISTINCT city) AS total_cities,
    CAST(AVG(price) AS DECIMAL(10,2)) AS avg_price,
    CAST(AVG(avg_ratings) AS DECIMAL(10,2)) AS avg_rating
FROM swiggy_data;

--2. City-wise Market Analysis
SELECT 
    city,
    COUNT(*) AS total_restaurants,
    CAST(AVG(price) AS DECIMAL(10,2)) AS avg_price,
    CAST(AVG(avg_ratings) AS DECIMAL(10,2)) AS avg_rating
FROM swiggy_data
GROUP BY city
ORDER BY total_restaurants DESC;

--3. Top Restaurants
SELECT TOP 10
    restaurant,
    city,
    (avg_ratings * total_ratings) AS popularity_score
FROM swiggy_data
ORDER BY popularity_score DESC;

--4. Price Segmentation
SELECT 
    CASE 
        WHEN price < 200 THEN 'Low'
        WHEN price BETWEEN 200 AND 500 THEN 'Medium'
        ELSE 'High'
    END AS price_category,
    COUNT(*) AS total_restaurants
FROM swiggy_data
GROUP BY 
    CASE 
        WHEN price < 200 THEN 'Low'
        WHEN price BETWEEN 200 AND 500 THEN 'Medium'
        ELSE 'High'
    END;

 --5. Delivery Performance
SELECT 
    city,
    AVG(delivery_time) AS avg_delivery_time
FROM swiggy_data
GROUP BY city
ORDER BY avg_delivery_time DESC;

--6. Most Popular Cuisines
SELECT 
    f.food_type,
    COUNT(*) AS total
FROM food_data f
GROUP BY f.food_type
ORDER BY total DESC;

--7. Best Rated Cuisines
SELECT 
    f.food_type,
    AVG(s.avg_ratings) AS avg_rating
FROM food_data f
JOIN swiggy_data s ON f.id = s.id
GROUP BY f.food_type
ORDER BY avg_rating DESC;

--8. High Demand Cuisines
SELECT 
    f.food_type,
    COUNT(*) AS popularity,
    AVG(s.avg_ratings) AS avg_rating
FROM food_data f
JOIN swiggy_data s ON f.id = s.id
GROUP BY f.food_type
ORDER BY popularity DESC, avg_rating DESC;
