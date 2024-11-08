-- View 5: Scheduled_maintenance_record: Lists scheduled aircraft maintenance with due and completion dates
-- Creator: Maintenance Manager
 
SET SERVEROUTPUT ON;
 
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
            mr.main_record_date AS completion_date,  -- Using main_record_date as completion date
            a.aircraft_id,
            a.aircraft_model,
            e.employee_id,
            e.emp_first_name,
            ms.created_at,
            ms.updated_at
        FROM developer.maintenance_schedule ms
        LEFT JOIN developer.maintenance_record mr ON ms.main_schedule_id = mr.ms_main_schedule_id
        LEFT JOIN developer.aircraft a ON mr.aircraft_aircraft_id = a.aircraft_id
        LEFT JOIN developer.employee e ON mr.employee_employee_id = e.employee_id
        ORDER BY ms.main_schedule_id';
 
    DBMS_OUTPUT.PUT_LINE('View Scheduled_Maintenance_Record CREATED SUCCESSFULLY ✅');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error Code: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('Error Message: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE('FAILED TO CREATE VIEW Scheduled_Maintenance_Record ❌');
END;
/