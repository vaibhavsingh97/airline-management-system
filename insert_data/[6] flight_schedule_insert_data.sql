/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/
SET SERVEROUTPUT ON;

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
   v_flight_schedule_id INTEGER;
BEGIN
   -- Generate a new flight_schedule_id
   SELECT NVL(MAX(flight_schedule_id), 0) + 1 INTO v_flight_schedule_id FROM flight_schedule;

   -- Perform the insertion into the flight_schedule table
   INSERT INTO flight_schedule (
      flight_schedule_id,
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
      v_flight_schedule_id,
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
   );

   DBMS_OUTPUT.PUT_LINE('✅ Successfully inserted flight schedule with ID: ' || v_flight_schedule_id);
   COMMIT; -- Commit the insertion

EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error Code: ' || SQLCODE);
      DBMS_OUTPUT.PUT_LINE('Error Message: ' || SQLERRM);
      RAISE_APPLICATION_ERROR(
         -20002,
         '❌ Failed to process flight schedule: ' || SQLERRM
      );
END insert_flight_schedule;
/

begin
    -- Inserting data into flight_schedule table
   insert_flight_schedule(
      1001,
      'DEN',
      '2024-02-15 23:17:22',
      '2024-02-15 23:17:22',
      'BOS',
      '2024-08-02 07:40:52',
      '2024-08-02 07:40:52',
      'scheduled',
      '2024-10-16 15:19:23',
      '2024-10-16 15:19:23',
      109,
      204
   );
   insert_flight_schedule(
      1002,
      'MIA',
      '2023-12-21 02:30:21',
      '2023-12-21 02:30:21',
      'ATL',
      '2024-06-23 05:41:31',
      '2024-06-23 05:41:31',
      'ontime',
      '2024-09-01 07:51:24',
      '2024-09-01 07:51:24',
      102,
      209
   );
   insert_flight_schedule(
      1003,
      'BOS',
      '2024-07-10 19:58:24',
      '2024-07-10 19:58:24',
      'ATL',
      '2024-02-22 06:41:00',
      '2024-02-22 06:41:00',
      'ontime',
      '2024-03-15 22:43:51',
      '2024-03-15 22:43:51',
      108,
      201
   );
   insert_flight_schedule(
      1004,
      'BOS',
      '2024-11-23 13:37:32',
      '2024-11-23 13:37:32',
      'ATL',
      '2024-11-30 06:56:53',
      '2024-11-30 06:56:53',
      'scheduled',
      '2024-04-04 22:14:15',
      '2024-04-04 22:14:15',
      106,
      201
   );
   insert_flight_schedule(
      1005,
      'DEN',
      '2024-08-12 13:36:46',
      '2024-08-12 13:36:46',
      'DFW',
      '2024-08-25 00:54:45',
      '2024-08-25 00:54:45',
      'ontime',
      '2024-09-13 08:38:04',
      '2024-09-13 08:38:04',
      107,
      208
   );
   insert_flight_schedule(
      1006,
      'ATL',
      '2024-10-25 07:28:22',
      '2024-10-25 07:28:22',
      'ORD',
      '2024-04-01 06:49:29',
      '2024-04-01 06:49:29',
      'ontime',
      '2024-01-20 04:42:44',
      '2024-01-20 04:42:44',
      109,
      205
   );
   insert_flight_schedule(
      1007,
      'ATL',
      '2024-10-30 07:28:08',
      '2024-10-30 07:28:08',
      'ORD',
      '2024-07-27 14:59:25',
      '2024-07-27 14:59:25',
      'scheduled',
      '2024-02-10 04:49:24',
      '2024-02-10 04:49:24',
      110,
      205
   );
   insert_flight_schedule(
      1008,
      'DEN',
      '2024-04-05 17:43:01',
      '2024-04-05 17:43:01',
      'ATL',
      '2024-05-31 23:42:09',
      '2024-05-31 23:42:09',
      'cancelled',
      '2024-09-09 14:25:08',
      '2024-09-09 14:25:08',
      110,
      203
   );
   insert_flight_schedule(
      1009,
      'BOS',
      '2024-04-27 12:55:37',
      '2024-04-27 12:55:37',
      'ATL',
      '2024-05-15 01:40:19',
      '2024-05-15 01:40:19',
      'ontime',
      '2024-05-15 14:18:51',
      '2024-05-15 14:18:51',
      105,
      201
   );
   insert_flight_schedule(
      1010,
      'ATL',
      '2024-09-20 10:11:27',
      '2024-09-20 10:11:27',
      'ORD',
      '2024-12-10 21:44:20',
      '2024-12-10 21:44:20',
      'ontime',
      '2024-07-29 15:36:22',
      '2024-07-29 15:36:22',
      108,
      205
   );

   commit;
end;
/