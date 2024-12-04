/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/
SET SERVEROUTPUT ON;
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';

CREATE OR REPLACE PROCEDURE insert_aircraft (
   p_aircraft_name    IN VARCHAR2,
   p_aircraft_model   IN VARCHAR2,
   p_seating_capacity IN NUMBER,
   p_fuel_capacity    IN NUMBER,
   p_created_at       IN VARCHAR2,
   p_updated_at       IN VARCHAR2
) IS
   v_count NUMBER;
   v_aircraft_id NUMBER;
BEGIN
   -- Check if a record exists with the provided aircraft_name and aircraft_model
   SELECT COUNT(*)
     INTO v_count
     FROM aircraft
    WHERE aircraft_name = p_aircraft_name
      AND aircraft_model = p_aircraft_model;

   -- If a record exists, update it; otherwise, insert a new record
   IF v_count > 0 THEN
      UPDATE aircraft
      SET seating_capacity = p_seating_capacity,
          fuel_capacity = p_fuel_capacity,
          updated_at = TO_DATE(p_updated_at, 'YYYY-MM-DD HH24:MI:SS')
      WHERE aircraft_name = p_aircraft_name
        AND aircraft_model = p_aircraft_model
      RETURNING aircraft_id INTO v_aircraft_id;

      DBMS_OUTPUT.PUT_LINE('✅ Successfully updated aircraft with ID: ' || v_aircraft_id);
   ELSE
      -- Perform the insertion into the aircraft table
      INSERT INTO aircraft (
         aircraft_name,
         aircraft_model,
         seating_capacity,
         fuel_capacity,
         created_at,
         updated_at
      ) VALUES (
         p_aircraft_name,
         p_aircraft_model,
         p_seating_capacity,
         p_fuel_capacity,
         TO_DATE(p_created_at, 'YYYY-MM-DD HH24:MI:SS'),
         TO_DATE(p_updated_at, 'YYYY-MM-DD HH24:MI:SS')
      ) RETURNING aircraft_id INTO v_aircraft_id;

      DBMS_OUTPUT.PUT_LINE('✅ Successfully inserted aircraft with ID: ' || v_aircraft_id);
   END IF;

   COMMIT;  -- Commit the insertion or update

EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('❌ Failed to insert or update aircraft: ' || p_aircraft_name || ' ' || p_aircraft_model);
END insert_aircraft;
/


BEGIN
   -- Inserting data into aircraft table using the procedure
   insert_aircraft(
      'Boeing 747',
      '747',
      4,
      24429,
      '2023-09-18 10:23:45',
      '2023-09-18 10:23:45'
   );
   insert_aircraft(
      'Airbus A380',
      'A380',
      8,
      17833,
      '2023-09-24 15:45:12',
      '2023-09-24 15:45:12'
   );
   insert_aircraft(
      'Boeing 737',
      '737',
      7,
      47631,
      '2023-10-03 09:12:01',
      '2023-10-03 09:12:01'
   );
   insert_aircraft(
      'Airbus A320',
      'A320',
      6,
      1690,
      '2023-10-11 22:08:30',
      '2023-10-11 22:08:30'
   );
   insert_aircraft(
      'Boeing 787 Dreamliner', 
      '787',
      5,
      25656,
      '2023-10-19 14:37:50',
      '2023-10-19 14:37:50'
   );
   insert_aircraft(
      'Airbus A350',
      'A350',
      7,
      41818,
      '2023-10-27 08:56:10',
      '2023-10-27 08:56:10'
   );
   insert_aircraft(
      'Embraer E190',
      'E190',
      5,
      38087,
      '2023-11-06 12:20:55',
      '2023-11-06 12:20:55'
   );
   insert_aircraft(
      'Bombardier CRJ900',
      'CRJ900',
      4,
      22015,
      '2024-01-15 20:31:15',
      '2024-01-15 20:31:15'
   );
   insert_aircraft(
      'Boeing 777',
      '777',
      5,
      25374,
      '2024-03-22 18:19:45',
      '2024-03-22 18:19:45'
   );
   insert_aircraft(
      'Airbus A330',
      'A330',
      7,
      22488,
      '2024-05-30 04:45:35',
      '2024-05-30 04:45:35'
   );
   COMMIT;
END;
/ 
