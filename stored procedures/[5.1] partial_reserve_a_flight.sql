/*================================================
‼️ THIS FILE SHOULD BE RUN BY PASSENGER ONLY ‼️
================================================*/

alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
CREATE OR REPLACE PROCEDURE make_partial_reservation (
    p_passenger_id IN NUMBER,
    p_flight_schedule_id IN NUMBER,
    p_seat_id IN NUMBER,
    p_total_airfare IN NUMBER,
    p_initial_payment IN NUMBER,
    p_payment_mode IN VARCHAR2,  -- 'creditcard', 'debitcard', 'bank', 'wallet'
    p_travel_date IN VARCHAR2
) IS
    v_reservation_id NUMBER;
    v_payment_id NUMBER;
    v_pnr VARCHAR2(6);
    v_current_timestamp VARCHAR2(30);
    v_end_hold_time DATE;
    v_existing_count NUMBER;
    invalid_payment_amount EXCEPTION;
BEGIN
    -- Validate payment amount
    IF p_initial_payment >= p_total_airfare THEN
        RAISE invalid_payment_amount;
    END IF;

    -- Generate PNR
    SELECT DBMS_RANDOM.STRING('X', 6) INTO v_pnr FROM DUAL;
    v_current_timestamp := TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS');
    v_end_hold_time := SYSDATE + (72/24); -- 72 hours hold

    -- Create partial reservation
    developer.insert_reservation(
        p_travel_date,           -- travel_date
        'partial',               -- reservation_status
        v_current_timestamp,     -- created_at
        v_current_timestamp,     -- updated_at
        p_total_airfare,        -- airfare
        p_passenger_id,         -- passenger_id
        p_seat_id,             -- seat_id
        v_pnr,                 -- pnr
        SYSDATE,               -- start_date
        v_end_hold_time        -- end_date
    );

    -- Get the reservation_id
    SELECT reservation_id INTO v_reservation_id 
    FROM developer.reservation 
    WHERE pnr = v_pnr;

    -- Create payment record
    developer.insert_payment(
        v_current_timestamp,    -- payment_date
        p_initial_payment,      -- payment_amount
        p_payment_mode,         -- payment_mode
        'partial',              -- payment_type
        v_current_timestamp,    -- created_at
        v_current_timestamp     -- updated_at
    );

    -- Get the payment_id
    SELECT MAX(payment_id) INTO v_payment_id FROM developer.payment;

    -- Link reservation and payment
    developer.insert_reservation_payment(
        v_payment_id,          -- payment_id
        v_reservation_id,      -- reservation_id
        v_current_timestamp,   -- created_at
        v_current_timestamp    -- updated_at
    );

    -- Mark seat as unavailable
    UPDATE developer.seat 
    SET is_available = 'f',
        updated_at = SYSDATE
    WHERE seat_id = p_seat_id;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('✅ Partial reservation created successfully!');
    DBMS_OUTPUT.PUT_LINE('Reservation PNR: ' || v_pnr);
    DBMS_OUTPUT.PUT_LINE('Initial Payment: $' || p_initial_payment || ' of $' || p_total_airfare);
    DBMS_OUTPUT.PUT_LINE('Reservation hold expires on: ' || TO_CHAR(v_end_hold_time, 'YYYY-MM-DD HH24:MI:SS'));

EXCEPTION
    WHEN invalid_payment_amount THEN
        DBMS_OUTPUT.PUT_LINE('❌ Initial payment must be less than total airfare for partial reservation');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('❌ Failed to create partial reservation ');
END;
/

-- Procedure to release expired holds
CREATE OR REPLACE PROCEDURE release_expired_holds IS
    v_released_count NUMBER := 0;
BEGIN
    -- Update reservation status and release seats
    UPDATE developer.seat s
    SET s.is_available = 't',
        s.updated_at = SYSDATE
    WHERE s.seat_id IN (
        SELECT r.seat_seat_id
        FROM developer.reservation r
        WHERE r.reservation_status = 'partial'
        AND r.end_date < SYSDATE
    );
    
    -- Update reservation status to cancelled
    UPDATE developer.reservation r
    SET r.reservation_status = 'cancelled',
        r.updated_at = SYSDATE
    WHERE r.reservation_status = 'partial'
    AND r.end_date < SYSDATE;
    
    v_released_count := SQL%ROWCOUNT;
    
    IF v_released_count > 0 THEN
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('✅ Released ' || v_released_count || ' expired partial reservations');
    ELSE
        DBMS_OUTPUT.PUT_LINE('No expired partial reservations found');
    END IF;
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('❌ Failed to release expired holds ');
END;
/
-- Test Case 1: Partial reservation that expires
-- BEGIN
--     -- Create partial reservation
--     make_partial_reservation(
--         7,              -- passenger_id
--         14,              -- flight_schedule_id
--         12,              -- seat_id
--         4200,           -- total_airfare
--         20,           -- initial_payment
--         'creditcard',   -- payment_mode
--         '2024-07-15'    -- travel_date
--     );
--    -- Force expire the hold by updating end_date
--     UPDATE developer.reservation
--     SET end_date = SYSDATE - 1
--     WHERE reservation_status = 'partial';
    
--     -- Step 2: Run release_expired_holds
--     release_expired_holds();
-- END;
-- /


CREATE OR REPLACE PROCEDURE make_partial_payment (
    p_reservation_id IN NUMBER,
    p_payment_amount IN NUMBER,
    p_payment_mode IN VARCHAR2
) IS
    v_total_airfare NUMBER;
    v_paid_amount NUMBER := 0;
    v_remaining_amount NUMBER;
    v_payment_id NUMBER;
    v_reservation_status VARCHAR2(15);
    v_end_hold_time DATE;
    invalid_payment EXCEPTION;
    invalid_reservation EXCEPTION;
BEGIN
    -- Get reservation details
    SELECT r.airfare, r.reservation_status, r.end_date,
           NVL(SUM(p.payment_amount), 0)
    INTO v_total_airfare, v_reservation_status, v_end_hold_time, v_paid_amount
    FROM developer.reservation r
    LEFT JOIN developer.reservation_payment rp ON r.reservation_id = rp.reservation_reservation_id
    LEFT JOIN developer.payment p ON rp.payment_payment_id = p.payment_id
    WHERE r.reservation_id = p_reservation_id
    GROUP BY r.airfare, r.reservation_status, r.end_date;

    DBMS_OUTPUT.PUT_LINE('v_reservation_status: ' || v_reservation_status);

    -- Validate reservation
    IF v_reservation_status != 'partial' THEN
        RAISE invalid_reservation;
    END IF;

    -- Check if hold expired
    IF v_end_hold_time < SYSDATE THEN
        DBMS_OUTPUT.PUT_LINE('Reservation hold has expired');
    END IF;

    -- Calculate remaining amount
    v_remaining_amount := v_total_airfare - v_paid_amount;

    -- Validate payment amount
    IF p_payment_amount > v_remaining_amount THEN
        RAISE invalid_payment;
    END IF;

    -- Create payment record
    developer.insert_payment(
        TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'),  -- payment_date
        p_payment_amount,                            -- payment_amount
        p_payment_mode,                             -- payment_mode
        CASE 
            WHEN (v_paid_amount + p_payment_amount) = v_total_airfare THEN 'full'
            ELSE 'partial'
        END,                                        -- payment_type
        TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'), -- created_at
        TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')  -- updated_at
    );

    -- Get new payment_id
    SELECT MAX(payment_id) INTO v_payment_id FROM developer.payment;

    -- Link payment to reservation
    developer.insert_reservation_payment(
        v_payment_id,
        p_reservation_id,
        TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'),
        TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')
    );

    -- Update reservation status if fully paid
    IF (v_paid_amount + p_payment_amount) = v_total_airfare THEN
        UPDATE developer.reservation
        SET reservation_status = 'confirmed',
            updated_at = SYSDATE
        WHERE reservation_id = p_reservation_id;
    END IF;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('✅ Payment processed successfully');
    DBMS_OUTPUT.PUT_LINE('Amount paid: $' || p_payment_amount);
    DBMS_OUTPUT.PUT_LINE('Total paid: $' || (v_paid_amount + p_payment_amount) || 
                        ' of $' || v_total_airfare);
    IF (v_paid_amount + p_payment_amount) = v_total_airfare THEN
        DBMS_OUTPUT.PUT_LINE('Reservation confirmed');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Remaining balance: $' || 
                            (v_total_airfare - (v_paid_amount + p_payment_amount)));
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('❌ Reservation not found');
    WHEN invalid_reservation THEN
        DBMS_OUTPUT.PUT_LINE('❌ Invalid reservation status. Must be partial');
    WHEN invalid_payment THEN
        DBMS_OUTPUT.PUT_LINE('❌ Payment amount exceeds remaining balance');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('❌ Error processing payment ');
END;
/

-- Test Case 2: Partial reservation with successful completion
BEGIN
    make_partial_reservation(
        15,              -- passenger_id
        14,              -- flight_schedule_id
        12,              -- seat_id
        4200,           -- total_airfare
        20,           -- initial_payment
        'creditcard',   -- payment_mode
        '2024-07-15'    -- travel_date
    );
    
    -- Simulate completing the payment within 72 hours
    make_partial_payment(
        /* Use the reservation_id from the previous step */
        33,              -- reservation_id
        3000,           -- payment_amount
        'creditcard'    -- payment_mode
    );
END;
/
