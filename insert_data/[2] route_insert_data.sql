SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE insert_route (
   p_route_id            IN INTEGER,
   p_origin_airport      IN VARCHAR2,
   p_destination_airport IN VARCHAR2,
   p_distance            IN INTEGER,
   p_created_at          IN VARCHAR2,
   p_updated_at          IN VARCHAR2
) IS
   v_count NUMBER;
BEGIN
   -- Check if a record exists with the provided route_id
   SELECT COUNT(*)
     INTO v_count
     FROM route
    WHERE route_id = p_route_id;

   -- If a record exists, update it; otherwise, insert a new record
   IF v_count > 0 THEN
      UPDATE route
      SET origin_airport = p_origin_airport,
          destination_airport = p_destination_airport,
          distance = p_distance,
          updated_at = TO_DATE(p_updated_at, 'YYYY-MM-DD HH24:MI:SS')
      WHERE route_id = p_route_id;

      DBMS_OUTPUT.PUT_LINE('✅ Successfully updated route with ID: ' || p_route_id);
      COMMIT;  -- Commit the update
   ELSE
      -- Perform the insertion into the route table
      INSERT INTO route (
         route_id,
         origin_airport,
         destination_airport,
         distance,
         created_at,
         updated_at
      ) VALUES (
         p_route_id,
         p_origin_airport,
         p_destination_airport,
         p_distance,
         TO_DATE(p_created_at, 'YYYY-MM-DD HH24:MI:SS'),
         TO_DATE(p_updated_at, 'YYYY-MM-DD HH24:MI:SS')
      );

      DBMS_OUTPUT.PUT_LINE('✅ Successfully inserted route with ID: ' || p_route_id);
      COMMIT;  -- Commit the insertion
   END IF;

EXCEPTION
   WHEN OTHERS THEN
      -- If an error occurs, raise a custom error
      RAISE_APPLICATION_ERROR(
         -20001,
         '❌ Failed to insert or update route with ID: ' || p_route_id
      );
END insert_route;
/


begin
    -- Inserting data into route table using the procedure
   insert_route(
      201,
      'BOS',
      'ATL',
      2779,
      '2023-01-05 12:15:33',
      '2023-01-05 12:15:33'
   );
   insert_route(
      202,
      'DEN',
      'SFO',
      2528,
      '2023-02-14 08:45:20',
      '2023-02-14 08:45:20'
   );
   insert_route(
      203,
      'DEN',
      'ATL',
      2818,
      '2023-04-28 21:17:55',
      '2023-04-28 21:17:55'
   );
   insert_route(
      204,
      'DEN',
      'BOS',
      1782,
      '2023-06-13 05:38:09',
      '2023-06-13 05:38:09'
   );
   insert_route(
      205,
      'ATL',
      'ORD',
      1094,
      '2023-08-09 16:24:41',
      '2023-08-09 16:24:41'
   );
   insert_route(
      206,
      'ORD',
      'JFK',
      2618,
      '2023-10-03 10:35:20',
      '2023-10-03 10:35:20'
   );
   insert_route(
      207,
      'DFW',
      'LAX',
      2242,
      '2023-11-17 22:50:11',
      '2023-11-17 22:50:11'
   );
   insert_route(
      208,
      'DEN',
      'DFW',
      1868,
      '2024-02-03 06:44:57',
      '2024-02-03 06:44:57'
   );
   insert_route(
      209,
      'MIA',
      'ATL',
      4254,
      '2024-04-21 13:19:32',
      '2024-04-21 13:19:32'
   );
   insert_route(
      210,
      'DFW',
      'MIA',
      1576,
      '2024-06-12 18:56:45',
      '2024-06-12 18:56:45'
   );
   commit;
end;
/