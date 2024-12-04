/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/
SET SERVEROUTPUT ON;
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';

CREATE OR REPLACE PROCEDURE insert_maintenance_record (
   p_main_record_date IN VARCHAR2,
   p_main_record_type IN VARCHAR2,
   p_description      IN VARCHAR2,
   p_created_at       IN VARCHAR2,
   p_updated_at       IN VARCHAR2,
   p_employee_id      IN NUMBER,
   p_inventory_id     IN NUMBER,
   p_main_schedule_id IN NUMBER
) IS
   v_count NUMBER;
   v_main_record_id NUMBER;
BEGIN
   -- Check if a record exists with the provided details
   SELECT COUNT(*)
     INTO v_count
     FROM maintenance_record
    WHERE main_record_date = TO_DATE(p_main_record_date, 'YYYY-MM-DD HH24:MI:SS')
      AND employee_employee_id = p_employee_id
      AND ms_main_schedule_id = p_main_schedule_id;

   -- If a record doesn't exist, perform the insertion
   IF v_count = 0 THEN
      BEGIN
         INSERT INTO maintenance_record (
            main_record_date,
            main_record_type,
            main_record_description,
            created_at,
            updated_at,
            employee_employee_id,
            inventory_inventory_id,
            ms_main_schedule_id
         ) VALUES ( 
            TO_DATE(p_main_record_date, 'YYYY-MM-DD HH24:MI:SS'),
            p_main_record_type,
            p_description,
            TO_DATE(p_created_at, 'YYYY-MM-DD HH24:MI:SS'),
            TO_DATE(p_updated_at, 'YYYY-MM-DD HH24:MI:SS'),
            p_employee_id,
            p_inventory_id,
            p_main_schedule_id 
         ) RETURNING main_record_id INTO v_main_record_id;
         
         DBMS_OUTPUT.PUT_LINE('✅ Successfully inserted maintenance record with ID: ' || v_main_record_id);
         COMMIT; -- Commit the insertion
      EXCEPTION
         WHEN OTHERS THEN
            -- If an error occurs during insertion, raise a custom error
            DBMS_OUTPUT.PUT_LINE(
               '❌ Failed to insert maintenance record for ID: ' || v_main_record_id
            );
      END;
   END IF;
EXCEPTION
   WHEN OTHERS THEN
      -- If an error occurs during the procedure execution, raise a custom error
      DBMS_OUTPUT.PUT_LINE(
         '❌ Failed to process maintenance record for ID: ' || v_main_record_id
      );
END insert_maintenance_record;
/

begin
   -- Inserting data into maintenance_record table
   insert_maintenance_record(
      '2024-07-09 22:05:00',
      'routine',
      'Refueling aircraft',
      '2024-07-09 22:05:00',
      '2024-07-09 22:05:00',
      2,
      6,
      1
   );

   insert_maintenance_record(
      '2024-07-11 22:05:00',
      'routine',
      'Plugs Issue',
      '2024-07-11 22:05:00',
      '2024-07-11 22:05:00',
      3,
      2,
      1
   );

   insert_maintenance_record(
      '2023-09-30 04:36:00',
      'inspection',
      'Brake systems',
      '2023-09-30 04:36:00',
      '2023-09-30 04:36:00',
      2,
      7,
      2
   );

   insert_maintenance_record(
      '2023-11-19 10:17:00',
      'inspection',
      'Inspecting brakes',
      '2023-11-19 10:17:00',
      '2023-11-19 10:17:00',
      3,
      7,
      3
   );

   insert_maintenance_record(
      '2023-11-20 10:17:00',
      'cleaning',
      'Oil Filter issues',
      '2023-11-20 10:17:00',
      '2023-11-20 10:17:00',
      5,
      1,
      3
   );

   insert_maintenance_record(
      '2024-02-06 17:27:00',
      'routine',
      'Replacing air filters',
      '2024-02-06 17:27:00',
      '2024-02-06 17:27:00',
      8,
      5,
      4
   );

   insert_maintenance_record(
      '2024-04-22 23:31:00',
      'repairs',
      'Battery issues',
      '2024-04-22 23:31:00',
      '2024-04-22 23:31:00',
      5,
      8,
      5
   );

   commit;
end;
/
