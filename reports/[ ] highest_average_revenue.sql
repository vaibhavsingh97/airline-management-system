-- Based on Revenue_by_route
-- To be run by Flight Operations Manager

SELECT route_id, origin_airport, destination_airport, 
       total_revenue / total_flights AS avg_revenue_per_flight
FROM Revenue_by_route
ORDER BY avg_revenue_per_flight DESC
FETCH FIRST 10 ROWS ONLY;