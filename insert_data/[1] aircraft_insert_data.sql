SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE insert_aircraft (
   p_aircraft_id      IN NUMBER,
   p_aircraft_name    IN VARCHAR2,
   p_aircraft_model   IN VARCHAR2,
   p_seating_capacity IN NUMBER,
   p_fuel_capacity    IN NUMBER,
   p_created_at       IN VARCHAR2,
   p_updated_at       IN VARCHAR2
) IS
   v_count NUMBER;
BEGIN
   -- Check if a record exists with the provided aircraft_id
   SELECT COUNT(*)
     INTO v_count
     FROM aircraft
    WHERE aircraft_id = p_aircraft_id;

   -- If a record exists, update it; otherwise, insert a new record
   IF v_count > 0 THEN
      UPDATE aircraft
      SET aircraft_name = p_aircraft_name,
          aircraft_model = p_aircraft_model,
          seating_capacity = p_seating_capacity,
          fuel_capacity = p_fuel_capacity,
          updated_at = TO_DATE(p_updated_at, 'YYYY-MM-DD HH24:MI:SS')
      WHERE aircraft_id = p_aircraft_id;

      DBMS_OUTPUT.PUT_LINE('✅ Successfully updated aircraft with ID: ' || p_aircraft_id);
      COMMIT;  -- Commit the update
   ELSE
      -- Perform the insertion into the aircraft table
      INSERT INTO aircraft (
         aircraft_id,
         aircraft_name,
         aircraft_model,
         seating_capacity,
         fuel_capacity,
         created_at,
         updated_at
      ) VALUES (
         p_aircraft_id,
         p_aircraft_name,
         p_aircraft_model,
         p_seating_capacity,
         p_fuel_capacity,
         TO_DATE(p_created_at, 'YYYY-MM-DD HH24:MI:SS'),
         TO_DATE(p_updated_at, 'YYYY-MM-DD HH24:MI:SS')
      );

      DBMS_OUTPUT.PUT_LINE('✅ Successfully inserted aircraft with ID: ' || p_aircraft_id);
      COMMIT;  -- Commit the insertion
   END IF;

EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error Code: ' || SQLCODE);
      DBMS_OUTPUT.PUT_LINE('Error Message: ' || SQLERRM);
      -- If an error occurs, raise a custom error
      RAISE_APPLICATION_ERROR(
         -20004,
         '❌ Failed to insert or update aircraft with ID: ' || p_aircraft_id
      );
END insert_aircraft;
/



begin
    -- Inserting data into aircraft table using the procedure
   insert_aircraft(
      101,
      'Boeing 747',
      '747',
      114,
      24429,
      '2023-09-18 10:23:45',
      '2023-09-18 10:23:45'
   );
   insert_aircraft(
      102,
      'Airbus A380',
      'A380',
      180,
      17833,
      '2023-09-24 15:45:12',
      '2023-09-24 15:45:12'
   );
   insert_aircraft(
      103,
      'Boeing 737',
      '737',
      173,
      47631,
      '2023-10-03 09:12:01',
      '2023-10-03 09:12:01'
   );
   insert_aircraft(
      104,
      'Airbus A320',
      'A320',
      311,
      1690,
      '2023-10-11 22:08:30',
      '2023-10-11 22:08:30'
   );
   insert_aircraft(
      105,
      'Boeing 787 Dreamliner',
      '787',
      25,
      25656,
      '2023-10-19 14:37:50',
      '2023-10-19 14:37:50'
   );
   insert_aircraft(
      106,
      'Airbus A350',
      'A350',
      200,
      41818,
      '2023-10-27 08:56:10',
      '2023-10-27 08:56:10'
   );
   insert_aircraft(
      107,
      'Embraer E190',
      'E190',
      397,
      38087,
      '2023-11-06 12:20:55',
      '2023-11-06 12:20:55'
   );
   insert_aircraft(
      108,
      'Bombardier CRJ900',
      'CRJ900',
      40,
      22015,
      '2024-01-15 20:31:15',
      '2024-01-15 20:31:15'
   );
   insert_aircraft(
      109,
      'Boeing 777',
      '777',
      351,
      25374,
      '2024-03-22 18:19:45',
      '2024-03-22 18:19:45'
   );
   insert_aircraft(
      110,
      'Airbus A330',
      'A330',
      273,
      22488,
      '2024-05-30 04:45:35',
      '2024-05-30 04:45:35'
   );
   commit;
end;
/