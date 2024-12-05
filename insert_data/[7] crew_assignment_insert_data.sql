/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/
SET SERVEROUTPUT ON;
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';

CREATE OR REPLACE PROCEDURE insert_crew_assignment (
   p_assignment_date    IN VARCHAR2,
   p_assignment_role    IN VARCHAR2,
   p_created_at         IN VARCHAR2,
   p_updated_at         IN VARCHAR2,
   p_flight_schedule_id IN NUMBER,
   p_employee_id        IN NUMBER
) IS
   v_count NUMBER;
   v_assignment_id NUMBER;
BEGIN
   -- Check if a record exists with the provided flight schedule, employee, and date
   SELECT COUNT(*)
   INTO v_count
   FROM crew_assignment
   WHERE fs_flight_schedule_id = p_flight_schedule_id
     AND employee_employee_id = p_employee_id
     AND assignment_date = TO_DATE(p_assignment_date, 'YYYY-MM-DD HH24:MI:SS');

   IF v_count > 0 THEN
      -- Update existing crew assignment record
      UPDATE crew_assignment
      SET assignment_role = p_assignment_role,
          updated_at = TO_DATE(p_updated_at, 'YYYY-MM-DD HH24:MI:SS')
      WHERE fs_flight_schedule_id = p_flight_schedule_id
        AND employee_employee_id = p_employee_id
        AND assignment_date = TO_DATE(p_assignment_date, 'YYYY-MM-DD HH24:MI:SS')
      RETURNING assignment_id INTO v_assignment_id;
      
      DBMS_OUTPUT.PUT_LINE('✅ Successfully updated crew assignment with ID: ' || v_assignment_id);
   ELSE
      -- Insert new crew assignment record
      INSERT INTO crew_assignment (
         assignment_date,
         assignment_role,
         created_at,
         updated_at,
         fs_flight_schedule_id,
         employee_employee_id
      ) VALUES (
         TO_DATE(p_assignment_date, 'YYYY-MM-DD HH24:MI:SS'),
         p_assignment_role,
         TO_DATE(p_created_at, 'YYYY-MM-DD HH24:MI:SS'),
         TO_DATE(p_updated_at, 'YYYY-MM-DD HH24:MI:SS'),
         p_flight_schedule_id,
         p_employee_id
      ) RETURNING assignment_id INTO v_assignment_id;
      
      DBMS_OUTPUT.PUT_LINE('✅ Successfully inserted crew assignment with ID: ' || v_assignment_id);
   END IF;

   COMMIT; -- Commit the transaction
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('❌ Failed to insert or update crew assignment for employee ' || 
                              p_employee_id || ' on flight schedule ' || p_flight_schedule_id);
END insert_crew_assignment;
/

begin
    -- Inserting data into crew_assignment table
   insert_crew_assignment('2024-08-30 00:45:24', 'crew', '2024-01-19 12:22:24', '2024-01-19 12:22:24', 1, 4);
   insert_crew_assignment('2024-08-30 00:45:24', 'crew', '2024-01-19 12:22:24', '2024-01-19 12:22:24', 1, 9);
   insert_crew_assignment('2024-08-30 00:45:24', 'pilot', '2024-01-19 12:22:24', '2024-01-19 12:22:24', 1, 6);

   -- This data will trigger validation error: ground staff cannot be assigned to crew assignment
   -- insert_crew_assignment('2024-08-30 00:45:24', 'ground_staff', '2024-01-19 12:22:24', '2024-01-19 12:22:24', 1, 2);
   -- insert_crew_assignment('2024-08-30 00:45:24', 'ground_staff', '2024-01-19 12:22:24', '2024-01-19 12:22:24', 1, 3);

   -- This data insert will trigger validation: 10 hour min rest period of time between two flights
   -- insert_crew_assignment('2024-08-30 00:45:24', 'crew', '2024-01-19 12:22:24', '2024-01-19 12:22:24', 2, 4);
   -- insert_crew_assignment('2024-08-30 00:45:24', 'crew', '2024-01-19 12:22:24', '2024-01-19 12:22:24', 2, 9);
   -- insert_crew_assignment('2024-08-30 00:45:24', 'pilot', '2024-01-19 12:22:24', '2024-01-19 12:22:24', 2, 6);

   insert_crew_assignment('2023-05-27 03:16:35', 'crew', '2024-10-13 07:32:47', '2024-10-13 07:32:47', 5, 11);
   insert_crew_assignment('2023-08-21 16:16:39', 'crew', '2024-02-10 15:40:01', '2024-02-10 15:40:01', 5, 12);
   insert_crew_assignment('2023-08-21 16:16:39', 'pilot', '2024-02-10 15:40:01', '2024-02-10 15:40:01', 5, 7);

   insert_crew_assignment('2024-03-30 18:14:44', 'crew', '2024-02-01 11:31:34', '2024-02-01 11:31:34', 6, 4);
   insert_crew_assignment('2024-05-27 05:02:12', 'crew', '2024-04-09 19:10:23', '2024-04-09 19:10:23', 6, 9);
   insert_crew_assignment('2024-05-11 21:52:31', 'pilot', '2024-03-05 00:20:59', '2024-03-05 00:20:59', 6, 6);

   insert_crew_assignment('2023-05-27 03:16:35', 'crew', '2024-10-13 07:32:47', '2024-10-13 07:32:47', 9, 11);
   insert_crew_assignment('2023-08-21 16:16:39', 'crew', '2024-02-10 15:40:01', '2024-02-10 15:40:01', 9, 12);
   insert_crew_assignment('2023-08-21 16:16:39', 'pilot', '2024-02-10 15:40:01', '2024-02-10 15:40:01', 9, 7);
   commit;
end;
/
