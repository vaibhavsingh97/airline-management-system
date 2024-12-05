/*================================================
‼️ THIS FILE SHOULD BE RUN BY FLIGHT OPERATION MANAGER ONLY ‼️
================================================*/

alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
CREATE OR REPLACE PROCEDURE land_flight (
    p_flight_schedule_id IN NUMBER,
    p_actual_arrival_time IN VARCHAR2
) IS
BEGIN
    -- Update flight schedule with actual arrival time and status
    UPDATE developer.flight_schedule
    SET actual_arr_time = TO_DATE(p_actual_arrival_time, 'YYYY-MM-DD HH24:MI:SS'),
        flight_status = CASE 
            WHEN TO_DATE(p_actual_arrival_time, 'YYYY-MM-DD HH24:MI:SS') > scheduled_arr_time + INTERVAL '15' MINUTE 
            THEN 'delayed'
            ELSE 'landed'
        END,
        updated_at = SYSDATE
    WHERE flight_schedule_id = p_flight_schedule_id;

    -- Check if any rows were updated
    IF SQL%ROWCOUNT > 0 THEN
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('✅ Flight ' || p_flight_schedule_id || ' landed successfully at ' || p_actual_arrival_time);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Flight schedule not found');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('❌ Failed to land flight ');
END;
/

-- Test the procedure
BEGIN
    land_flight(
        7,                          -- flight_schedule_id
        '2024-11-23 15:50:00'      -- actual_arrival_time
    );
END;
/
