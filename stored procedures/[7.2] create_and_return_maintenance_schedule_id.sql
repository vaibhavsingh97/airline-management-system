/*================================================
‼️ THIS FILE SHOULD BE RUN BY MAINTENANCE MANAGER ONLY ‼️
================================================*/

-- Create and return the maintenance schedule for an aircraft
alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
CREATE OR REPLACE PROCEDURE create_and_return_maintenance_schedule_id(
    p_aircraft_id IN NUMBER,
    p_schedule_date IN DATE,
    p_maintenance_type IN VARCHAR2,
    p_maintenance_schedule_id OUT NUMBER  -- OUT parameter to return the generated ID
) IS
BEGIN
    -- Insert a new record into the maintenance_schedule table
    INSERT INTO developer.maintenance_schedule (
        main_type,
        schedule_date,
        aircraft_aircraft_id,
        created_at,
        updated_at
    ) VALUES (
        p_maintenance_type,
        p_schedule_date,
        p_aircraft_id,
        SYSDATE,  -- created_at
        SYSDATE   -- updated_at
    )
    RETURNING main_schedule_id INTO p_maintenance_schedule_id;  -- Capture the generated ID

    -- Output message to confirm the maintenance schedule creation
    DBMS_OUTPUT.PUT_LINE('✅ Maintenance schedule created for aircraft ' || p_aircraft_id ||
                         ' with maintenance type: ' || p_maintenance_type ||
                         ' on ' || TO_CHAR(p_schedule_date, 'YYYY-MM-DD') ||
                         '. Schedule ID: ' || p_maintenance_schedule_id);

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        -- Handle the case when there is a violation of a unique constraint (e.g., duplicate maintenance schedule)
        DBMS_OUTPUT.PUT_LINE('❌ Error: Duplicate maintenance schedule for aircraft ' || p_aircraft_id || 
                             ' on ' || TO_CHAR(p_schedule_date, 'YYYY-MM-DD'));
        RAISE;  -- Reraise the exception to indicate failure

    WHEN OTHERS THEN
        -- Handle any unexpected errors with a custom message
        DBMS_OUTPUT.PUT_LINE('❌ An unexpected error occurred while creating maintenance schedule for aircraft ' || p_aircraft_id);
        RAISE;  -- Reraise the exception to indicate failure

END create_and_return_maintenance_schedule_id;
/
