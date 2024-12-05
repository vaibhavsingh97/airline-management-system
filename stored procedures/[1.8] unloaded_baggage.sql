/*================================================
‼️ THIS FILE SHOULD BE RUN BY GROUND OPERATION MANAGER ONLY ‼️
================================================*/
alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
CREATE OR REPLACE PROCEDURE unload_baggage (
    p_flight_schedule_id IN NUMBER
) IS
    v_count NUMBER := 0;
BEGIN
    -- Update baggage status to unloaded for all baggage associated with reservations on this flight
    UPDATE developer.baggage b
    SET b.baggage_status = 'unloaded',
        b.updated_at = SYSDATE
    WHERE b.baggage_status = 'loaded'
    AND EXISTS (
        SELECT 1 
        FROM developer.reservation r
        JOIN developer.seat s ON r.seat_seat_id = s.seat_id
        WHERE b.reservation_reservation_id = r.reservation_id
        AND s.fs_flight_schedule_id = p_flight_schedule_id
    );
    
    v_count := SQL%ROWCOUNT;
    
    IF v_count > 0 THEN
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('✅ Successfully unloaded ' || v_count || ' baggage items from flight ' || p_flight_schedule_id);
    ELSE
        DBMS_OUTPUT.PUT_LINE('No loaded baggage found for flight ' || p_flight_schedule_id);
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('❌ Failed to unload baggage ');
END;
/

-- Test the procedure
BEGIN
    unload_baggage(7); -- flight_schedule_id
END;
/
