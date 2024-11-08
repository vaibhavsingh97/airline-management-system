SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE insert_maintenance_schedule (
   p_main_schedule_id IN INTEGER,
   p_main_type        IN VARCHAR2,
   p_schedule_date    IN VARCHAR2,
   p_created_at       IN VARCHAR2,
   p_updated_at       IN VARCHAR2
) IS
   v_count NUMBER;
BEGIN
   -- Check if a record exists with the provided main_schedule_id
   SELECT COUNT(*)
     INTO v_count
     FROM maintenance_schedule
    WHERE main_schedule_id = p_main_schedule_id;

   -- If a record exists, update it; otherwise, insert a new record
   IF v_count > 0 THEN
      UPDATE maintenance_schedule
      SET main_type = p_main_type,
          schedule_date = TO_DATE(p_schedule_date, 'YYYY-MM-DD HH24:MI:SS'),
          updated_at = TO_DATE(p_updated_at, 'YYYY-MM-DD HH24:MI:SS')
      WHERE main_schedule_id = p_main_schedule_id;

      DBMS_OUTPUT.PUT_LINE('✅ Successfully updated maintenance_schedule with ID: ' || p_main_schedule_id);
      COMMIT;  -- Commit the update
   ELSE
      -- Perform the insertion into the maintenance_schedule table
      INSERT INTO maintenance_schedule (
         main_schedule_id,
         main_type,
         schedule_date,
         created_at,
         updated_at
      ) VALUES (
         p_main_schedule_id,
         p_main_type,
         TO_DATE(p_schedule_date, 'YYYY-MM-DD HH24:MI:SS'),
         TO_DATE(p_created_at, 'YYYY-MM-DD HH24:MI:SS'),
         TO_DATE(p_updated_at, 'YYYY-MM-DD HH24:MI:SS')
      );

      DBMS_OUTPUT.PUT_LINE('✅ Successfully inserted maintenance_schedule with ID: ' || p_main_schedule_id);
      COMMIT;  -- Commit the insertion
   END IF;

EXCEPTION
   WHEN OTHERS THEN
      -- If an error occurs, raise a custom error
      RAISE_APPLICATION_ERROR(
         -20001,
         '❌ Failed to insert or update maintenance schedule with ID: ' || p_main_schedule_id
      );
END insert_maintenance_schedule;
/


begin
    -- Inserting data into maintenance_schedule table using the procedure
   insert_maintenance_schedule(
      301,
      'scheduled',
      '2023-01-18 07:00:00',
      '2023-01-15 07:22:13',
      '2023-01-15 07:22:13'
   );
   insert_maintenance_schedule(
      302,
      'inspection',
      '2023-03-10 14:00:00',
      '2023-03-07 14:35:50',
      '2023-03-07 14:35:50'
   );
   insert_maintenance_schedule(
      303,
      'scheduled',
      '2023-05-27 11:00:00',
      '2023-05-22 11:12:40',
      '2023-05-22 11:12:40'
   );
   insert_maintenance_schedule(
      304,
      'unscheduled',
      '2023-07-14 21:00:00',
      '2023-07-09 20:50:33',
      '2023-07-09 20:50:33'
   );
   insert_maintenance_schedule(
      305,
      'inspection',
      '2023-09-30 04:00:00',
      '2023-09-25 04:17:05',
      '2023-09-25 04:17:05'
   );
   insert_maintenance_schedule(
      306,
      'unscheduled',
      '2023-11-19 09:00:00',
      '2023-11-14 09:28:57',
      '2023-11-14 09:28:57'
   );
   insert_maintenance_schedule(
      307,
      'scheduled',
      '2024-02-06 16:00:00',
      '2024-02-03 16:11:21',
      '2024-02-03 16:11:21'
   );
   insert_maintenance_schedule(
      308,
      'scheduled',
      '2024-04-22 19:00:00',
      '2024-04-17 19:03:02',
      '2024-04-17 19:03:02'
   );
   insert_maintenance_schedule(
      309,
      'scheduled',
      '2024-07-03 22:00:00',
      '2024-06-28 22:09:45',
      '2024-06-28 22:09:45'
   );
   insert_maintenance_schedule(
      310,
      'emergency',
      '2024-08-16 14:00:00',
      '2024-08-12 13:50:38',
      '2024-08-12 13:50:38'
   );
   commit;
end;
/