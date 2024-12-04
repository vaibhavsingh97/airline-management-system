/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/
alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';

CREATE OR REPLACE TRIGGER check_crew_assignment
BEFORE INSERT OR UPDATE ON crew_assignment
FOR EACH ROW
DECLARE
    v_count INTEGER;
    v_last_assignment_time DATE;
    v_existing_assignment_count INTEGER;
    v_emp_type VARCHAR2(15);
    v_scheduled_dep_time DATE;
    v_scheduled_arr_time DATE;
    emp_type_error EXCEPTION;
    crew_assignment_error EXCEPTION;
    min_time_expired EXCEPTION;
    same_flight_error EXCEPTION;
BEGIN
    -- Validate employee type (crew or pilot)
    SELECT emp_type
    INTO v_emp_type
    FROM employee
    WHERE employee_id = :NEW.employee_employee_id;

    IF v_emp_type NOT IN ('crew', 'pilot') THEN
        RAISE emp_type_error;
    END IF;

    -- Check if the same crew/pilot is already assigned to this same flight
    SELECT COUNT(*)
    INTO v_existing_assignment_count
    FROM crew_assignment ca
    WHERE ca.employee_employee_id = :NEW.employee_employee_id
      AND ca.fs_flight_schedule_id = :NEW.fs_flight_schedule_id
      AND ca.assignment_id <> :NEW.assignment_id; -- Exclude the current assignment

    IF v_existing_assignment_count > 0 THEN
        RAISE same_flight_error; -- Raise custom error if the same employee is already assigned
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
        RAISE;

    WHEN crew_assignment_error THEN
        DBMS_OUTPUT.PUT_LINE('Crew member ' || :NEW.employee_employee_id || ' is already assigned to another flight during this time period.');
        RAISE;

    WHEN min_time_expired THEN
        DBMS_OUTPUT.PUT_LINE('Crew member ' || :NEW.employee_employee_id || ' has not met the 10-hour minimum off-time requirement.');
        RAISE;

    WHEN same_flight_error THEN
        DBMS_OUTPUT.PUT_LINE('Employee ' || :NEW.employee_employee_id || ' is already assigned to this flight.');
        RAISE;

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred in crew assignment trigger.');
        RAISE;
END;
/