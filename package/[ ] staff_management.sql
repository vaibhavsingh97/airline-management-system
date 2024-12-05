/*
================================================
‼️ THIS FILE SHOULD BE RUN BY HR_MANAGER ONLY ‼️
================================================
*/

alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';

CREATE OR REPLACE PACKAGE staff_management AS
    -- Procedure to register a staff member
    PROCEDURE register_staff(
        p_emp_first_name IN VARCHAR2,
        p_emp_last_name IN VARCHAR2,
        p_emp_email IN VARCHAR2,
        p_emp_phone IN NUMBER,
        p_emp_type IN VARCHAR2,
        p_emp_subtype IN VARCHAR2,
        p_emp_salary IN NUMBER
    );
END staff_management;
/


CREATE OR REPLACE PACKAGE BODY staff_management AS
    -- Procedure to register a staff member
    PROCEDURE register_staff(
        p_emp_first_name IN VARCHAR2,
        p_emp_last_name IN VARCHAR2,
        p_emp_email IN VARCHAR2,
        p_emp_phone IN NUMBER,
        p_emp_type IN VARCHAR2,
        p_emp_subtype IN VARCHAR2,
        p_emp_salary IN NUMBER
    ) AS
    BEGIN
        INSERT INTO developer.employee (
            emp_first_name, emp_last_name, emp_email, emp_phone, emp_type, emp_subtype, emp_salary, created_at, updated_at
        ) VALUES (
            p_emp_first_name, p_emp_last_name, p_emp_email, p_emp_phone, p_emp_type, p_emp_subtype, p_emp_salary, SYSDATE, SYSDATE
        );
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('✅ Staff member registered successfully: ' || p_emp_first_name || ' ' || p_emp_last_name);
    END register_staff;
END staff_management;
/

/*
BEGIN
    -- Register a pilot
    staff_management.register_staff(
        'Johana', 'Doyle', 'johana.doy@airline.com', 8765433456, 'pilot', NULL, 5600.78
    );

    -- Register a pilot
    staff_management.register_staff(
        'Mockie', 'Fenan', 'mo.fe@xyz.com', 3457896543, 'pilot', NULL, 9000.00
    );

     -- Register a cabin crew
    staff_management.register_staff(
        'Rosie', 'Joy', 'ros.j@gmail.com', 4568902345, 'crew', NULL, 4500.78
    );

    -- Register a cabin crew
    staff_management.register_staff(
        'Sam', 'Philemon', 'sam.phil@gmail.com', 9876345678, 'crew', NULL, 4500.78
    );

    -- Register a ground staff
    staff_management.register_staff(
        'Marica', 'Benoy', 'marica.ben@gmail.com', 3456780123, 'ground_staff', NULL, 2300.00
    );
    -- Register a corporate staff
    staff_management.register_staff(
        'Benedict', 'Cameo', 'Benedict.cam@gmail.com', 9234890123, 'corporate', 'sales', 7800.00
    );
END;
/
*/