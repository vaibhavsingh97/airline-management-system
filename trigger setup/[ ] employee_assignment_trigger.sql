/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/

CREATE OR REPLACE TRIGGER check_crew_assignment
BEFORE INSERT OR UPDATE ON crew_assignment
FOR EACH ROW
DECLARE
    v_count INTEGER;
    v_last_assignment_time DATE;
    v_emp_type VARCHAR2(15);
    v_scheduled_dep_time DATE;
    v_scheduled_arr_time DATE;
    emp_type_error EXCEPTION;
    crew_assignment_error EXCEPTION;
    min_time_expired EXCEPTION;
BEGIN
    -- Validate employee type (crew or pilot)
    SELECT emp_type
    INTO v_emp_type
    FROM employee
    WHERE employee_id = :NEW.employee_employee_id;

    IF v_emp_type NOT IN ('crew', 'pilot') THEN
        RAISE emp_type_error;
    END IF;

    -- Fetch scheduled departure and arrival times from flight_schedule
    SELECT scheduled_dep_time, scheduled_arr_time
    INTO v_scheduled_dep_time, v_scheduled_arr_time
    FROM flight_schedule
    WHERE flight_schedule_id = :NEW.fs_flight_schedule_id;

    -- Check for overlapping assignments
    SELECT COUNT(*)
    INTO v_count
    FROM crew_assignment ca
    JOIN flight_schedule fs
    ON ca.fs_flight_schedule_id = fs.flight_schedule_id
    WHERE ca.employee_employee_id = :NEW.employee_employee_id
      AND fs.scheduled_dep_time BETWEEN v_scheduled_dep_time AND v_scheduled_arr_time
      AND ca.assignment_id <> :NEW.assignment_id;

    IF v_count > 0 THEN
        RAISE crew_assignment_error;    
    END IF;

    -- Check for 10-hour minimum off-time
    SELECT MAX(fs.scheduled_arr_time)
    INTO v_last_assignment_time
    FROM crew_assignment ca
    JOIN flight_schedule fs
    ON ca.fs_flight_schedule_id = fs.flight_schedule_id
    WHERE ca.employee_employee_id = :NEW.employee_employee_id;

    IF v_last_assignment_time IS NOT NULL THEN
        IF v_scheduled_dep_time < v_last_assignment_time + INTERVAL '10' HOUR THEN
            RAISE min_time_expired;
        END IF;
    END IF;

    -- Log success message
    DBMS_OUTPUT.PUT_LINE('Crew member ' || :NEW.employee_employee_id || ' assigned to flight successfully.');

EXCEPTION
    WHEN emp_type_error THEN
        DBMS_OUTPUT.PUT_LINE('Employee ' || :NEW.employee_employee_id || ' is not a valid crew member or pilot.');
        RETURN;

    WHEN crew_assignment_error THEN
        DBMS_OUTPUT.PUT_LINE('Crew member ' || :NEW.employee_employee_id || ' is already assigned to another flight during this time period.');
        RETURN;

    WHEN min_time_expired THEN
        DBMS_OUTPUT.PUT_LINE('Crew member ' || :NEW.employee_employee_id || ' has not met the 10-hour minimum off-time requirement.');
        RETURN;

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred');
        RETURN;
END;
/