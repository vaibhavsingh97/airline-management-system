/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/
SET SERVEROUTPUT ON;
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';

CREATE OR REPLACE PROCEDURE insert_flight_schedule (
   p_departure_airport  IN VARCHAR2,
   p_scheduled_dep_time IN VARCHAR2,
   p_actual_dep_time    IN VARCHAR2,
   p_arrival_airport    IN VARCHAR2,
   p_scheduled_arr_time IN VARCHAR2,
   p_actual_arr_time    IN VARCHAR2,
   p_flight_status      IN VARCHAR2,
   p_created_at         IN VARCHAR2,
   p_updated_at         IN VARCHAR2,
   p_aircraft_id        IN INTEGER,
   p_route_id           IN INTEGER
) IS
   v_count NUMBER;
   v_flight_schedule_id INTEGER;
BEGIN
   -- Check if a record exists with the provided departure and arrival details
   SELECT COUNT(*)
   INTO v_count
   FROM flight_schedule
   WHERE departure_airport = p_departure_airport
     AND arrival_airport = p_arrival_airport
     AND scheduled_dep_time = TO_DATE(p_scheduled_dep_time, 'YYYY-MM-DD HH24:MI:SS');

   IF v_count > 0 THEN
      -- Update existing flight schedule record
      UPDATE flight_schedule
      SET actual_dep_time = TO_DATE(p_actual_dep_time, 'YYYY-MM-DD HH24:MI:SS'),
          scheduled_arr_time = TO_DATE(p_scheduled_arr_time, 'YYYY-MM-DD HH24:MI:SS'),
          actual_arr_time = TO_DATE(p_actual_arr_time, 'YYYY-MM-DD HH24:MI:SS'),
          flight_status = p_flight_status,
          updated_at = TO_DATE(p_updated_at, 'YYYY-MM-DD HH24:MI:SS'),
          aircraft_aircraft_id = p_aircraft_id,
          routes_route_id = p_route_id
      WHERE departure_airport = p_departure_airport
        AND arrival_airport = p_arrival_airport
        AND scheduled_dep_time = TO_DATE(p_scheduled_dep_time, 'YYYY-MM-DD HH24:MI:SS')
      RETURNING flight_schedule_id INTO v_flight_schedule_id;
      
      DBMS_OUTPUT.PUT_LINE('✅ Successfully updated flight schedule with ID: ' || v_flight_schedule_id);
   ELSE
      -- Insert new flight schedule record
      INSERT INTO flight_schedule (
         departure_airport,
         scheduled_dep_time,
         actual_dep_time,
         arrival_airport,
         scheduled_arr_time,
         actual_arr_time,
         flight_status,
         created_at,
         updated_at,
         aircraft_aircraft_id,
         routes_route_id
      ) VALUES ( 
         p_departure_airport,
         TO_DATE(p_scheduled_dep_time, 'YYYY-MM-DD HH24:MI:SS'),
         TO_DATE(p_actual_dep_time, 'YYYY-MM-DD HH24:MI:SS'),
         p_arrival_airport,
         TO_DATE(p_scheduled_arr_time, 'YYYY-MM-DD HH24:MI:SS'),
         TO_DATE(p_actual_arr_time, 'YYYY-MM-DD HH24:MI:SS'),
         p_flight_status,
         TO_DATE(p_created_at, 'YYYY-MM-DD HH24:MI:SS'),
         TO_DATE(p_updated_at, 'YYYY-MM-DD HH24:MI:SS'),
         p_aircraft_id,
         p_route_id 
      ) RETURNING flight_schedule_id INTO v_flight_schedule_id;
      
      DBMS_OUTPUT.PUT_LINE('✅ Successfully inserted flight schedule with ID: ' || v_flight_schedule_id);
   END IF;

   COMMIT; -- Commit the transaction
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('❌ Failed to insert or update flight schedule: ' || 
                              p_departure_airport || ' to ' || p_arrival_airport || 
                              ' on ' || p_scheduled_dep_time);
END insert_flight_schedule;
/

begin
    -- Inserting data into flight_schedule table
   insert_flight_schedule(
      'DEN',
      '2024-02-15 20:17:22',
      '2024-02-15 20:17:22',
      'BOS',
      '2024-02-15 22:17:22',
      '2024-02-15 22:17:22',
      'scheduled',
      '2024-10-16 15:19:23',
      '2024-10-16 15:19:23',
      9,
      4
   );
   insert_flight_schedule(
      'DEN',
      '2024-02-15 21:17:22',
      '2024-02-15 21:17:22',
      'BOS',
      '2024-02-15 23:17:22',
      '2024-02-15 23:17:22',
      'scheduled',
      '2024-10-16 15:19:23',
      '2024-10-16 15:19:23',
      6,
      4
   );
   insert_flight_schedule(
      'DEN',
      '2024-02-15 20:27:22',
      '2024-02-15 20:27:22',
      'BOS',
      '2024-02-15 23:17:22',
      '2024-02-15 23:17:22',
      'scheduled',
      '2024-10-16 15:19:23',
      '2024-10-16 15:19:23',
      9,
      4
   );
   insert_flight_schedule(
      'DEN',
      '2024-02-15 20:17:22',
      '2024-02-15 20:17:22',
      'SFO',
      '2024-02-15 22:17:22',
      '2024-02-15 22:17:22',
      'scheduled',
      '2024-10-16 15:19:23',
      '2024-10-16 15:19:23',
      9,
      2
   );
   insert_flight_schedule(
      'MIA',
      '2023-12-21 02:30:21',
      '2023-12-21 02:30:21',
      'ATL',
      '2023-12-21 05:41:31',
      '2023-12-21 05:41:31',
      'ontime',
      '2024-09-01 07:51:24',
      '2024-09-01 07:51:24',
      2,
      9
   );
   insert_flight_schedule(
      'BOS',
      '2024-07-10 19:58:24',
      '2024-07-10 19:58:24',
      'ATL',
      '2024-07-10 21:41:00',
      '2024-07-10 21:41:00',
      'ontime',
      '2024-03-15 22:43:51',
      '2024-03-15 22:43:51',
      8,
      1
   );
   insert_flight_schedule(
      'BOS',
      '2024-11-23 13:37:32',
      '2024-11-23 13:37:32',
      'ATL',
      '2024-11-23 15:56:53',
      '2024-11-23 15:56:53',
      'scheduled',
      '2024-04-04 22:14:15',
      '2024-04-04 22:14:15',
      6,
      1
   );
   insert_flight_schedule(
      'DEN',
      '2024-08-12 13:36:46',
      '2024-08-12 13:36:46',
      'DFW',
      '2024-08-12 15:54:45',
      '2024-08-12 15:54:45',
      'ontime',
      '2024-09-13 08:38:04',
      '2024-09-13 08:38:04',
      7,
      8
   );
   insert_flight_schedule(
      'ATL',
      '2024-10-25 07:28:22',
      '2024-10-25 07:28:22',
      'ORD',
      '2024-10-25 09:49:29',
      '2024-10-25 09:49:29',
      'ontime',
      '2024-01-20 04:42:44',
      '2024-01-20 04:42:44',
      9,
      5
   );
   insert_flight_schedule(
      'ATL',
      '2024-10-30 07:28:08',
      '2024-10-30 07:28:08',
      'ORD',
      '2024-10-30 09:59:25',
      '2024-10-30 09:59:25',
      'scheduled',
      '2024-02-10 04:49:24',
      '2024-02-10 04:49:24',
      10,
      5
   );
   insert_flight_schedule(
      'DEN',
      '2024-04-05 17:43:01',
      '2024-04-05 17:43:01',
      'ATL',
      '2024-04-05 18:42:09',
      '2024-04-05 18:42:09',
      'cancelled',
      '2024-09-09 14:25:08',
      '2024-09-09 14:25:08',
      10,
      3
   );
   insert_flight_schedule(
      'BOS',
      '2024-04-27 12:55:37',
      '2024-04-27 12:55:37',
      'ATL',
      '2024-04-27 13:40:19',
      '2024-04-27 13:40:19',
      'ontime',
      '2024-05-15 14:18:51',
      '2024-05-15 14:18:51',
      5,
      1
   );
   insert_flight_schedule(
      'ATL',
      '2024-09-20 10:11:27',
      '2024-09-20 10:11:27',
      'ORD',
      '2024-09-20 11:44:20',
      '2024-09-20 11:44:20',
      'ontime',
      '2024-07-29 15:36:22',
      '2024-07-29 15:36:22',
      8,
      5
   );
   insert_flight_schedule(
      'BOS',
      '2024-07-15 20:17:22',
      '2024-07-15 20:17:22',
      'SFO',
      '2024-07-15 22:17:22',
      '2024-07-15 22:17:22',
      'scheduled',
      '2024-10-16 15:19:23',
      '2024-10-16 15:19:23',
      9,
      11
   );

   commit;
end;
/
