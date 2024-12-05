/*================================================
‼️ THIS FILE SHOULD BE RUN BY FLIGHT OPERATIONS MANAGER ONLY ‼️
================================================*/

WITH yearly_travel AS (
    SELECT q.year, 
           q.origin_airport, 
           q.destination_airport, 
           SUM(q.travel_count) AS total_travel_count
    FROM Quarterly_Most_Travelled_Route q
    GROUP BY q.year, q.origin_airport, q.destination_airport
)
SELECT curr.year AS current_year,
       curr.origin_airport,
       curr.destination_airport,
       curr.total_travel_count AS current_year_count,
       COALESCE(prev.total_travel_count, 0) AS previous_year_count,
       (curr.total_travel_count - COALESCE(prev.total_travel_count, 0)) AS growth
FROM yearly_travel curr
LEFT JOIN yearly_travel prev ON curr.origin_airport = prev.origin_airport 
                                  AND curr.destination_airport = prev.destination_airport 
                                  AND curr.year = prev.year + 1
ORDER BY curr.year, growth DESC;