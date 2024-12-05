/*================================================
‼️ THIS FILE SHOULD BE RUN BY PASSENGER ONLY ‼️
================================================*/

alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
CREATE OR REPLACE PROCEDURE find_available_seats (
    p_flight_schedule_id IN NUMBER
) IS
    v_seat_count NUMBER := 0;
BEGIN
    -- Get available seats for the flight
    FOR rec IN (
        SELECT 
            s.seat_id,
            s.seat_number,
            s.seat_type,
            s.seat_class
        FROM developer.seat s
        WHERE s.fs_flight_schedule_id = p_flight_schedule_id
        AND s.is_available = 't'
        ORDER BY s.seat_class, s.seat_number
    ) LOOP
        v_seat_count := v_seat_count + 1;
        DBMS_OUTPUT.PUT_LINE(
            'Seat ID: ' || rec.seat_id || 
            ', Number: ' || rec.seat_number || 
            ', Type: ' || rec.seat_type ||
            ', Class: ' || rec.seat_class
        );
    END LOOP;

    IF v_seat_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('❌ No available seats for flight ' || p_flight_schedule_id);
    ELSE
        DBMS_OUTPUT.PUT_LINE('✅ Found ' || v_seat_count || ' available seat(s)');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('❌ Error finding available seats ');
END;
/

-- Test Procedure
BEGIN
    find_available_seats(7);
    find_available_seats(2);
    find_available_seats(10);
    -- find_available_seats(14); -- Case 1.2
END;
