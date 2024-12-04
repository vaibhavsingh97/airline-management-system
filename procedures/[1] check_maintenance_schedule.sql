/*=====================================================
‼️ THIS FILE SHOULD BE RUN BY MAINTENANCE MANAGER ONLY ‼️
=======================================================
*/

-- Check maintenance schedule for an aircraft

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
    WHEN NO_DATA_FOUND THEN
        -- No rows found for the given aircraft, return FALSE
        DBMS_OUTPUT.PUT_LINE('No maintenance schedule found for aircraft ID: ' || p_aircraft_id);
        RETURN FALSE;
        
    WHEN TOO_MANY_ROWS THEN
        -- In case there is an unexpected result, log the error and return FALSE
        DBMS_OUTPUT.PUT_LINE('Error: More than one maintenance schedule found for aircraft ID: ' || p_aircraft_id);
        RETURN FALSE;
        
    WHEN OTHERS THEN
        -- Handle any other unexpected errors
        DBMS_OUTPUT.PUT_LINE('Error occurred while checking maintenance schedule for aircraft ID: ' || p_aircraft_id);
        RETURN FALSE;
END check_maintenance_schedule;
/