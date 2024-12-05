/*
================================================
‼️ THIS FILE SHOULD BE RUN BY CREW_MANAGER ONLY ‼️
================================================
*/

alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
CREATE OR REPLACE PACKAGE crew_assignment_check AS
    -- Assign schedule to staff
    PROCEDURE create_staff_schedule(
        p_assignment_date IN DATE,
        p_employee_id IN NUMBER,
        p_flight_schedule_id IN NUMBER,
        p_assignment_role IN VARCHAR2 -- Role: 'pilot' or 'crew'
    );

    -- Check staff availability
    FUNCTION check_availability(
        p_employee_id IN NUMBER,
        p_scheduled_time IN DATE
    ) RETURN BOOLEAN;

    -- Notify crew operations manager
    PROCEDURE notify_crew_ops_manager(
        p_employee_id IN NUMBER,
        p_reason IN VARCHAR2
    );
END crew_assignment_check;
/

CREATE OR REPLACE PACKAGE BODY crew_assignment_check AS

    -- Assign schedule to staff
    PROCEDURE create_staff_schedule(
        p_assignment_date IN DATE,
        p_employee_id IN NUMBER,
        p_flight_schedule_id IN NUMBER,
        p_assignment_role IN VARCHAR2 -- Role: 'pilot' or 'crew'
    ) AS
        v_last_flight_time DATE;
        v_allocation_hours INTEGER;
        v_existing_assignment_count INTEGER;
        v_emp_type VARCHAR2(15);

        -- Custom exceptions for better control
        emp_type_error EXCEPTION;
        role_mismatch_error EXCEPTION;
        duplicate_assignment_error EXCEPTION;
        insufficient_hours_error EXCEPTION;

    BEGIN
        -- Validate the assignment role
        SELECT emp_type
        INTO v_emp_type
        FROM developer.employee
        WHERE employee_id = p_employee_id;

        -- Raise an error if employee type is invalid
        IF v_emp_type NOT IN ('pilot', 'crew') THEN
            DBMS_OUTPUT.PUT_LINE('❌ Employee ' || p_employee_id || ' type "' || v_emp_type || '" is not valid for assignment.');
            RAISE emp_type_error;
        END IF;
        

        -- Ensure assignment role matches employee type
        IF v_emp_type <> p_assignment_role THEN
            DBMS_OUTPUT.PUT_LINE('❌ Assignment role "' || p_assignment_role || '" does not match employee type "' || v_emp_type || '".');
            RAISE role_mismatch_error;
        END IF;
       

        -- Check if the same employee is already assigned to the flight
        SELECT COUNT(*)
        INTO v_existing_assignment_count
        FROM developer.crew_assignment ca
        WHERE ca.employee_employee_id = p_employee_id
          AND ca.fs_flight_schedule_id = p_flight_schedule_id
          AND ca.assignment_date = p_assignment_date;

        IF v_existing_assignment_count > 0 THEN
            DBMS_OUTPUT.PUT_LINE('❌ Employee ' || p_employee_id || ' is already assigned to flight schedule ' || p_flight_schedule_id || '.');
            RAISE duplicate_assignment_error;
        END IF;
        

        -- Check for 10-hour minimum off-time
        SELECT MAX(fs.scheduled_dep_time)
        INTO v_last_flight_time
        FROM developer.crew_assignment ca
        JOIN developer.flight_schedule fs
            ON ca.fs_flight_schedule_id = fs.flight_schedule_id
        WHERE ca.employee_employee_id = p_employee_id
        AND ca.FS_FLIGHT_SCHEDULE_ID = p_flight_schedule_id;

        IF v_last_flight_time IS NOT NULL THEN
            -- Ensure both p_assignment_date and v_last_flight_time are in DATE format and calculate the difference in hours
            v_allocation_hours := ABS((TRUNC(p_assignment_date) - TRUNC(v_last_flight_time)) * 24);
            --DBMS_OUTPUT.PUT_LINE('There are ' || v_allocation_hours || ' hours between the last flight and the current assignment.');
            
            IF v_allocation_hours < 10 THEN
                DBMS_OUTPUT.PUT_LINE('❌ Employee ' || p_employee_id || ' has not met the 10-hour minimum off-time requirement since the last flight.');
                RAISE insufficient_hours_error;
            END IF;
            
        END IF;

        -- If all validations pass, assign the schedule
        INSERT INTO developer.crew_assignment (
            assignment_date, assignment_role, fs_flight_schedule_id, employee_employee_id, created_at, updated_at
        ) VALUES (
            p_assignment_date, p_assignment_role, p_flight_schedule_id, p_employee_id, SYSDATE, SYSDATE
        );
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('✅ Schedule assigned successfully to employee ID: ' || p_employee_id || ' as ' || p_assignment_role);

    EXCEPTION
        WHEN emp_type_error THEN
            DBMS_OUTPUT.PUT_LINE('❌ Operation aborted: Invalid employee type.');

        WHEN role_mismatch_error THEN
            DBMS_OUTPUT.PUT_LINE('❌ Operation aborted: Role mismatch.');

        WHEN duplicate_assignment_error THEN
            DBMS_OUTPUT.PUT_LINE('❌ Operation aborted: Duplicate assignment.');

        WHEN insufficient_hours_error THEN
            DBMS_OUTPUT.PUT_LINE('❌ Operation aborted: Insufficient off-time.');

        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('❌ An unexpected error occurred.');
    END create_staff_schedule;

    -- Check staff availability
    FUNCTION check_availability(
        p_employee_id IN NUMBER,
        p_scheduled_time IN DATE
    ) RETURN BOOLEAN IS
        v_assignment_count INTEGER;
    BEGIN
        SELECT COUNT(*)
        INTO v_assignment_count
        FROM developer.crew_assignment ca
        JOIN developer.flight_schedule fs ON ca.fs_flight_schedule_id = fs.flight_schedule_id
        WHERE ca.employee_employee_id = p_employee_id
          AND fs.scheduled_dep_time <= p_scheduled_time
          AND fs.scheduled_arr_time >= p_scheduled_time;

        RETURN v_assignment_count = 0;
    END check_availability;

    -- Notify crew operations manager
    PROCEDURE notify_crew_ops_manager(
        p_employee_id IN NUMBER,
        p_reason IN VARCHAR2
    ) AS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('⚠️ Notification to Crew Ops Manager: ' || p_reason || ' for employee ID: ' || p_employee_id);
    END notify_crew_ops_manager;

END crew_assignment_check;
/




/*
BEGIN
    crew_assignment_check.create_staff_schedule(
        p_assignment_date => TO_DATE('2024-09-20 10:11:27', 'YYYY-MM-DD HH24:MI:SS'),
        p_employee_id => 13, -- Pilot's Employee ID
        p_flight_schedule_id => 13, -- Flight Schedule ID
        p_assignment_role => 'pilot' -- Role
    );
END;
/

BEGIN
    crew_assignment_check.create_staff_schedule(
        p_assignment_date => TO_DATE('2024-09-20 10:11:27', 'YYYY-MM-DD HH24:MI:SS'),
        p_employee_id => 16, -- Corporate (Invalid Role)
        p_flight_schedule_id => 13, -- Flight Schedule ID
        p_assignment_role => 'pilot' -- Role
    );
END;

BEGIN
    crew_assignment_check.create_staff_schedule(
        p_assignment_date => TO_DATE('2024-08-30 00:45:24', 'YYYY-MM-DD HH24:MI:SS'),
        p_employee_id => 4, -- Already assigned
        p_flight_schedule_id => 1, -- Flight Schedule ID
        p_assignment_role => 'crew' -- Role
    );
END;
/

BEGIN
    crew_assignment_check.create_staff_schedule(
        p_assignment_date => TO_DATE('2024-04-27 12:55:37', 'YYYY-MM-DD HH24:MI:SS'),
        p_employee_id => 12, -- Already assigned
        p_flight_schedule_id => 12, -- Flight Schedule ID
        p_assignment_role => 'crew' -- Role
    );
END;
/
BEGIN
    crew_assignment_check.create_staff_schedule(
        p_assignment_date => TO_DATE('2024-04-27 12:56:39', 'YYYY-MM-DD HH24:MI:SS'),
        p_employee_id => 12, -- Already assigned
        p_flight_schedule_id => 12, -- Flight Schedule ID
        p_assignment_role => 'crew' -- Role
    );
END;
/
BEGIN
    crew_assignment_check.create_staff_schedule(
        p_assignment_date => TO_DATE('2024-04-27 12:56:39', 'YYYY-MM-DD HH24:MI:SS'),
        p_employee_id => 12, -- Already assigned
        p_flight_schedule_id => 12, -- Flight Schedule ID
        p_assignment_role => 'crew' -- Role
    );
END;
/
/*/
