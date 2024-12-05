/*================================================
‼️ THIS FILE SHOULD BE RUN BY FLIGHT OPERATIONS MANAGER ONLY ‼️
================================================*/

DECLARE
    table_exists INTEGER;
    tables_to_check SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('FLIGHT_SCHEDULE', 'AIRCRAFT', 'CREW_ASSIGNMENT', 'EMPLOYEE');
BEGIN
    -- Loop through the required tables
    FOR i IN 1..tables_to_check.COUNT LOOP
        EXECUTE IMMEDIATE 'SELECT COUNT(*) FROM all_tables WHERE UPPER(table_name) = :tbl' 
        INTO table_exists 
        USING tables_to_check(i);

        -- If any table does not exist, exit and print error
        IF table_exists = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Error: The ' || tables_to_check(i) || ' table does not exist. View creation aborted.');
            RETURN;
        END IF;
    END LOOP;

    -- Proceed to create the view if all tables exist
    BEGIN
        EXECUTE IMMEDIATE 'CREATE OR REPLACE VIEW Flight_and_crew_schedule AS
        SELECT 
            fs.flight_schedule_id,
            fs.departure_airport,
            fs.scheduled_dep_time,
            fs.arrival_airport,
            fs.scheduled_arr_time,
            fs.flight_status,
            a.aircraft_id,
            a.aircraft_name,
            a.aircraft_model,
            ca.assignment_id,
            ca.assignment_role,
            e.employee_id,
            e.emp_first_name,
            e.emp_last_name
        FROM 
            developer.flight_schedule fs
        JOIN developer.aircraft a ON fs.aircraft_aircraft_id = a.aircraft_id
        JOIN developer.crew_assignment ca ON fs.flight_schedule_id = ca.fs_flight_schedule_id
        JOIN developer.employee e ON ca.employee_employee_id = e.employee_id
        ORDER BY 
            fs.scheduled_dep_time';

        DBMS_OUTPUT.PUT_LINE('✅View Flight_and_crew_schedule created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('❌Error creating view Flight_and_crew_schedule');
    END;
END;
/