/*
================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================
*/

CREATE OR REPLACE PROCEDURE cancel_reservation (
    p_reservation_id IN NUMBER,
    p_cancellation_reason IN VARCHAR2
) IS
    v_reservation_status VARCHAR2(15);
    v_payment_id NUMBER;
    v_seat_id NUMBER;
    v_payment_amount NUMBER;
    v_booking_time DATE;
    v_hours_since_booking NUMBER;
    invalid_reservation EXCEPTION;
    already_cancelled EXCEPTION;
    past_cancellation_window EXCEPTION;
BEGIN
    -- Check if reservation exists and get its details
    SELECT reservation_status, seat_seat_id, airfare, created_at
    INTO v_reservation_status, v_seat_id, v_payment_amount, v_booking_time
    FROM developer.reservation
    WHERE reservation_id = p_reservation_id;
    
    -- Calculate hours since booking
    v_hours_since_booking := (SYSDATE - v_booking_time) * 24;
    
    -- Validate reservation status
    IF v_reservation_status = 'cancelled' THEN
        RAISE already_cancelled;
    END IF;
    
    -- Get associated payment ID
    SELECT payment_payment_id 
    INTO v_payment_id
    FROM developer.reservation_payment
    WHERE reservation_reservation_id = p_reservation_id;
    
    -- Update reservation status to cancelled
    UPDATE developer.reservation
    SET reservation_status = 'cancelled',
        updated_at = SYSDATE
    WHERE reservation_id = p_reservation_id;
    
    -- Make seat available again
    UPDATE developer.seat
    SET is_available = 't',
        updated_at = SYSDATE
    WHERE seat_id = v_seat_id;
    
    -- Process refund only if cancellation is within 24 hours of booking
    IF v_hours_since_booking <= 24 THEN
        -- Create refund record for full amount
        developer.insert_refund(
            v_payment_amount,        -- refund_amount
            p_cancellation_reason || ' (Within 24hrs of booking - Full Refund)',
            TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'),
            TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'),
            v_payment_id            -- payment_id
        );
        
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('✅ Reservation ' || p_reservation_id || ' cancelled successfully');
        DBMS_OUTPUT.PUT_LINE('Full refund of $' || v_payment_amount || ' has been initiated');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('✅ Reservation ' || p_reservation_id || ' cancelled successfully');
        DBMS_OUTPUT.PUT_LINE('No refund issued (cancellation after 24 hours of booking)');
    END IF;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('❌ Reservation not found');
    WHEN already_cancelled THEN
        DBMS_OUTPUT.PUT_LINE('❌ Reservation is already cancelled');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('❌ Failed to cancel reservation: ' || SQLERRM);
END;
/

-- Test the procedure
BEGIN
    cancel_reservation(
        8,                              -- reservation_id
        'Change of travel plans'        -- cancellation_reason
    );
    cancel_reservation(
        10,                              -- reservation_id
        'Change of travel plans'        -- cancellation_reason
    );
END;
/
