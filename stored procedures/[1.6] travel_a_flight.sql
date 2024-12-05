/*================================================
‼️ THIS FILE SHOULD BE RUN BY GROUND OPERATION MANAGER ONLY ‼️
================================================*/

alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
CREATE OR REPLACE PROCEDURE travel_a_flight (
    p_reservation_id IN NUMBER
) IS
    v_baggage_exists NUMBER;
    v_flight_schedule_id NUMBER;
BEGIN
    -- Get flight_schedule_id from reservation
    SELECT s.fs_flight_schedule_id
    INTO v_flight_schedule_id
    FROM developer.reservation r
    JOIN developer.seat s ON r.seat_seat_id = s.seat_id
    WHERE r.reservation_id = p_reservation_id;

    -- Check if baggage exists for this reservation
    SELECT COUNT(*)
    INTO v_baggage_exists
    FROM developer.baggage
    WHERE reservation_reservation_id = p_reservation_id
    AND baggage_status = 'checkin';

    IF v_baggage_exists = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'No checked-in baggage found for this reservation');
    END IF;

    -- Update baggage status to loaded
    UPDATE developer.baggage
    SET baggage_status = 'loaded',
        updated_at = SYSDATE
    WHERE reservation_reservation_id = p_reservation_id
    AND baggage_status = 'checkin';

    -- Update flight status to departed
    UPDATE developer.flight_schedule
    SET flight_status = 'departed',
        actual_dep_time = SYSDATE,
        updated_at = SYSDATE
    WHERE flight_schedule_id = v_flight_schedule_id
    AND flight_status = 'scheduled';

    IF SQL%ROWCOUNT > 0 THEN
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('✅ Baggage status updated to loaded for reservation ID: ' || p_reservation_id);
        DBMS_OUTPUT.PUT_LINE('✅ Flight status updated to departed');
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('❌ No baggage found for reservation ID: ' || p_reservation_id);
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('❌ Failed to update baggage status ');
END;
/

-- Test the procedure
BEGIN
    travel_a_flight(7); -- reservation_id
END;
/
