
/*=====================================================
‼️ THIS FILE SHOULD BE RUN BY MAINTENANCE MANAGER ONLY ‼️
=======================================================
*/
alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
CREATE OR REPLACE PROCEDURE get_main_schedule_id (
    p_aircraft_id IN INTEGER,                -- Input: Aircraft ID
    p_main_schedule_id OUT INTEGER           -- Output: Main Schedule ID
) IS
BEGIN
    -- Try to fetch the main schedule ID for the given aircraft
    SELECT ms.main_schedule_id
    INTO p_main_schedule_id
    FROM developer.maintenance_schedule ms
    WHERE ms.aircraft_aircraft_id = p_aircraft_id
    AND ROWNUM = 1;  -- In case there are multiple records, we'll return the first one

    -- If the schedule exists, the ID will be returned into the OUT parameter
    DBMS_OUTPUT.PUT_LINE('✅ Found maintenance schedule ID: ' || p_main_schedule_id);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- If no schedule is found for the aircraft
        DBMS_OUTPUT.PUT_LINE('❌ No maintenance schedule found for aircraft ID: ' || p_aircraft_id);
        p_main_schedule_id := NULL;  -- Set the OUT parameter to NULL if no schedule is found

    WHEN TOO_MANY_ROWS THEN
        -- In case of more than one schedule (unexpected scenario)
        DBMS_OUTPUT.PUT_LINE('❌ More than one maintenance schedule found for aircraft ID: ' || p_aircraft_id);
        p_main_schedule_id := NULL;  -- Set the OUT parameter to NULL as this is an error scenario

    WHEN OTHERS THEN
        -- Handle any other unexpected errors
        DBMS_OUTPUT.PUT_LINE('❌ An unexpected error occurred while fetching the maintenance schedule for aircraft ID: ' || p_aircraft_id);
        p_main_schedule_id := NULL;  -- Set the OUT parameter to NULL in case of any other error
END get_main_schedule_id;
/
