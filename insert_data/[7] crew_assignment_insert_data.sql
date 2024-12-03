/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/
SET SERVEROUTPUT ON;

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
   insert_crew_assignment(1201, '2024-08-30 00:45:24', 'crew', '2024-01-19 12:22:24', '2024-01-19 12:22:24', 1009, 609);
   insert_crew_assignment(1202, '2023-05-27 03:16:35', 'crew', '2024-10-13 07:32:47', '2024-10-13 07:32:47', 1010, 610);
   insert_crew_assignment(1203, '2023-08-21 16:16:39', 'crew', '2024-02-10 15:40:01', '2024-02-10 15:40:01', 1007, 604);
   insert_crew_assignment(1204, '2024-02-22 19:27:08', 'ground staff', '2024-01-23 00:32:10', '2024-01-23 00:32:10', 1008, 606);
   insert_crew_assignment(1205, '2024-05-28 16:53:09', 'ground staff', '2024-09-16 03:25:00', '2024-09-16 03:25:00', 1006, 603);
   insert_crew_assignment(1206, '2024-04-23 23:18:33', 'ground staff', '2024-09-27 03:00:39', '2024-09-27 03:00:39', 1006, 604);
   insert_crew_assignment(1207, '2024-03-30 18:14:44', 'crew', '2024-02-01 11:31:34', '2024-02-01 11:31:34', 1003, 609);
   insert_crew_assignment(1208, '2024-05-27 05:02:12', 'crew', '2024-04-09 19:10:23', '2024-04-09 19:10:23', 1010, 609);
   insert_crew_assignment(1209, '2024-05-11 21:52:31', 'crew', '2024-03-05 00:20:59', '2024-03-05 00:20:59', 1003, 609);
   insert_crew_assignment(1210, '2024-02-16 22:46:38', 'crew', '2024-10-05 20:25:42', '2024-10-05 20:25:42', 1009, 602);

   commit;
end;
/
