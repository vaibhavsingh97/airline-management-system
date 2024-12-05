/*=====================================================
‼️ THIS FILE SHOULD BE RUN BY MAINTENANCE MANAGER ONLY ‼️
=======================================================
*/

-- Check maintenance schedule for an aircraft
alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
CREATE OR REPLACE FUNCTION check_maintenance_schedule(
    p_aircraft_id IN NUMBER
) RETURN BOOLEAN IS
    v_scheduled_count INTEGER;
BEGIN
    -- Attempt to fetch the maintenance schedule count
    SELECT COUNT(*)
    INTO v_scheduled_count
    FROM developer.maintenance_schedule
    WHERE aircraft_aircraft_id = p_aircraft_id;

    -- Return TRUE if maintenance is scheduled, else FALSE
    RETURN v_scheduled_count > 0;

EXCEPTION 
    WHEN OTHERS THEN
        -- Handle any other unexpected errors
        DBMS_OUTPUT.PUT_LINE('❌ Error occurred while checking maintenance schedule for aircraft ID: ' || p_aircraft_id);
        RETURN FALSE;
END check_maintenance_schedule;
/
