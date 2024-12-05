/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/
SET SERVEROUTPUT ON;
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';

CREATE OR REPLACE PROCEDURE insert_route (
   p_origin_airport      IN VARCHAR2,
   p_destination_airport IN VARCHAR2,
   p_distance            IN INTEGER,
   p_created_at          IN VARCHAR2,
   p_updated_at          IN VARCHAR2
) IS
   v_count NUMBER;
   v_route_id NUMBER;
BEGIN
   -- Check if a record exists with the provided origin and destination airports
   SELECT COUNT(*)
     INTO v_count
     FROM route
    WHERE origin_airport = p_origin_airport
      AND destination_airport = p_destination_airport;

   -- If a record exists, update it; otherwise, insert a new record
   IF v_count > 0 THEN
      UPDATE route
      SET distance = p_distance,
          updated_at = TO_DATE(p_updated_at, 'YYYY-MM-DD HH24:MI:SS')
      WHERE origin_airport = p_origin_airport
        AND destination_airport = p_destination_airport
      RETURNING route_id INTO v_route_id;

      DBMS_OUTPUT.PUT_LINE('✅ Successfully updated route with ID: ' || v_route_id);
   ELSE
      -- Perform the insertion into the route table
      INSERT INTO route (
         origin_airport,
         destination_airport,
         distance,
         created_at,
         updated_at
      ) VALUES (
         p_origin_airport,
         p_destination_airport,
         p_distance,
         TO_DATE(p_created_at, 'YYYY-MM-DD HH24:MI:SS'),
         TO_DATE(p_updated_at, 'YYYY-MM-DD HH24:MI:SS')
      ) RETURNING route_id INTO v_route_id;

      DBMS_OUTPUT.PUT_LINE('✅ Successfully inserted route with ID: ' || v_route_id);
   END IF;

   COMMIT;  -- Commit the insertion or update

EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(
         '❌ Failed to insert or update route: ' || p_origin_airport || ' to ' || p_destination_airport
      );
END insert_route;
/

BEGIN
   -- Inserting data into route table using the modified procedure
   insert_route(
      'BOS',
      'ATL',
      2779,
      '2023-01-05 12:15:33',
      '2023-01-05 12:15:33'
   );
   insert_route(
      'DEN',
      'SFO',
      2528,
      '2023-02-14 08:45:20',
      '2023-02-14 08:45:20'
   );
   insert_route(
      'DEN',
      'ATL',
      2818,
      '2023-04-28 21:17:55',
      '2023-04-28 21:17:55'
   );
   insert_route(
      'DEN',
      'BOS',
      1782,
      '2023-06-13 05:38:09',
      '2023-06-13 05:38:09'
   );
   insert_route(
      'ATL',
      'ORD',
      1094,
      '2023-08-09 16:24:41',
      '2023-08-09 16:24:41'
   );
   insert_route(
      'ORD',
      'JFK',
      2618,
      '2023-10-03 10:35:20',
      '2023-10-03 10:35:20'
   );
   insert_route(
      'DFW',
      'LAX',
      2242,
      '2023-11-17 22:50:11',
      '2023-11-17 22:50:11'
   );
   insert_route(
      'DEN',
      'DFW',
      1868,
      '2024-02-03 06:44:57',
      '2024-02-03 06:44:57'
   );
   insert_route(
      'MIA',
      'ATL',
      4254,
      '2024-04-21 13:19:32',
      '2024-04-21 13:19:32'
   );
   insert_route(
      'DFW',
      'MIA',
      1576,
      '2024-06-12 18:56:45',
      '2024-06-12 18:56:45'
   );
   insert_route(
      'BOS',
      'SFO',
      3000,
      '2024-06-12 18:56:45',
      '2024-06-12 18:56:45'
   );
END;
/
