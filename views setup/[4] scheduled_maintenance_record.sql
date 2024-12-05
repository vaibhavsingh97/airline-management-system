/*================================================
‼️ THIS FILE SHOULD BE RUN BY MAINTENANCE MANAGER ONLY ‼️
================================================*/
 
DECLARE
    view_exists NUMBER;
BEGIN
    -- Check if the view exists
    SELECT COUNT(*)
    INTO view_exists
    FROM user_views
    WHERE view_name = 'SCHEDULED_MAINTENANCE_RECORD';
 
    -- Drop the view if it exists
    IF view_exists > 0 THEN
        EXECUTE IMMEDIATE 'DROP VIEW Scheduled_Maintenance_Record';
        DBMS_OUTPUT.PUT_LINE('View Scheduled_Maintenance_Record DROPPED SUCCESSFULLY ✅');
    END IF;
 
    -- Create the view
    EXECUTE IMMEDIATE '
        CREATE OR REPLACE VIEW Scheduled_Maintenance_Record AS
        SELECT
            ms.main_schedule_id AS schedule_id,
            ms.main_type,
            COALESCE(mr.main_record_date, TO_DATE(''01-01-1900'', ''DD-MM-YYYY'')) AS completion_date,
            COALESCE(a.aircraft_id, 0) AS aircraft_id,
            COALESCE(a.aircraft_model, ''UNKNOWN'') AS aircraft_model,
            COALESCE(e.employee_id, 0) AS employee_id,
            COALESCE(e.emp_first_name, ''No Employee'') AS emp_first_name,
            ms.created_at,
            ms.updated_at
        FROM developer.maintenance_schedule ms
        INNER JOIN developer.maintenance_record mr ON ms.main_schedule_id = mr.ms_main_schedule_id
        INNER JOIN developer.aircraft a ON ms.aircraft_aircraft_id = a.aircraft_id
        INNER JOIN developer.employee e ON mr.employee_employee_id = e.employee_id
        ORDER BY ms.main_schedule_id';
 
    DBMS_OUTPUT.PUT_LINE('View Scheduled_Maintenance_Record CREATED SUCCESSFULLY ✅');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('FAILED TO CREATE VIEW Scheduled_Maintenance_Record ❌');
END;
/
 