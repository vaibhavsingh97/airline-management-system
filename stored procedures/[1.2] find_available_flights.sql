/*================================================
‼️ THIS FILE SHOULD BE RUN BY PASSENGER ONLY ‼️
================================================*/

alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
CREATE OR REPLACE PROCEDURE find_available_flights (
   p_origin IN VARCHAR2,
   p_destination IN VARCHAR2,
   p_travel_date IN VARCHAR2
) IS
   v_flight_count NUMBER := 0;
BEGIN
   DBMS_OUTPUT.PUT_LINE('********************************');
   FOR rec IN (
      SELECT fs.flight_schedule_id, fs.departure_airport, fs.arrival_airport, 
             fs.scheduled_dep_time, fs.scheduled_arr_time, fs.flight_status
      FROM developer.flight_schedule fs
      JOIN developer.route r ON fs.routes_route_id = r.route_id
      WHERE r.origin_airport = p_origin
        AND r.destination_airport = p_destination
        AND TRUNC(fs.scheduled_dep_time) = TO_DATE(p_travel_date, 'YYYY-MM-DD')
        AND fs.flight_status = 'scheduled'
   ) LOOP
      v_flight_count := v_flight_count + 1;
      DBMS_OUTPUT.PUT_LINE('Flight ID: ' || rec.flight_schedule_id || 
                          ', Departure: ' || rec.scheduled_dep_time || 
                          ', Arrival: ' || rec.scheduled_arr_time);
   END LOOP;

   IF v_flight_count = 0 THEN
      DBMS_OUTPUT.PUT_LINE('❌ No flights available from ' || p_origin || 
                          ' to ' || p_destination || 
                          ' on ' || p_travel_date);
   END IF;
END;
/

-- Test Procedure
BEGIN
   -- find_available_flights('BOS', 'ATL', '2024-11-23');
   -- find_available_flights('DEN', 'BOS', '2024-02-15');
   -- find_available_flights('ATL', 'ORD', '2024-10-30');
   find_available_flights('BOS', 'SFO', '2024-07-15');
   --find_available_flights('BOS', 'ATL', '2024-11-23');
   -- find_available_flights('DEN', 'BOS', '2024-02-15');
   find_available_flights('ATL', 'ORD', '2024-10-30'); -- Case 2.1
   --find_available_flights('BOS', 'SFO', '2024-07-15'); -- Case 1.2
END;
/
