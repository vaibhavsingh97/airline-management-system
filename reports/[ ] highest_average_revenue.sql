/*================================================
‼️ THIS FILE SHOULD BE RUN BY FLIGHT OPERATIONS MANAGER ONLY ‼️
================================================*/

SELECT route_id, origin_airport, destination_airport, 
       total_revenue / total_flights AS avg_revenue_per_flight
FROM Revenue_by_route
ORDER BY avg_revenue_per_flight DESC
FETCH FIRST 10 ROWS ONLY;