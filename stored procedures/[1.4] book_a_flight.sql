/*================================================
‼️ THIS FILE SHOULD BE RUN BY PASSENGER ONLY ‼️
================================================*/

alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
CREATE OR REPLACE PROCEDURE book_flight (
    p_passenger_id IN NUMBER,
    p_flight_schedule_id IN NUMBER,
    p_seat_id IN NUMBER,
    p_airfare IN NUMBER,
    p_payment_mode IN VARCHAR2,  -- 'creditcard', 'debitcard', 'bank', 'wallet'
    p_travel_date IN VARCHAR2
) IS
    v_reservation_id NUMBER;
    v_payment_id NUMBER;
    v_pnr VARCHAR2(6);
    v_current_timestamp VARCHAR2(30);
BEGIN
    -- Generate PNR (6 characters)
    SELECT DBMS_RANDOM.STRING('X', 6) INTO v_pnr FROM DUAL;

    -- Get current timestamp in required format
    v_current_timestamp := TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS');

    -- First create reservation
    developer.insert_reservation(
        p_travel_date,           -- travel_date
        'confirmed',             -- reservation_status
        SYSDATE,                 -- created_at
        SYSDATE,                -- updated_at
        p_airfare,              -- airfare
        p_passenger_id,         -- passenger_id
        p_seat_id,             -- seat_id
        v_pnr,                 -- pnr
        NULL,                  -- start_date
        NULL                   -- end_date
    );
    
    -- Get the reservation_id
    SELECT reservation_id INTO v_reservation_id 
    FROM developer.reservation 
    WHERE pnr = v_pnr;

    DBMS_OUTPUT.PUT_LINE('v_reservation_id: ' || v_reservation_id);
    
    -- Create payment record
    developer.insert_payment(
        v_current_timestamp,    -- payment_date
        p_airfare,             -- payment_amount
        p_payment_mode,        -- payment_mode
        'full',                -- payment_type
        v_current_timestamp,   -- created_at
        v_current_timestamp    -- updated_at
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
    
    -- Update seat availability
    UPDATE developer.seat 
    SET is_available = 'f',
        updated_at = SYSDATE
    WHERE seat_id = p_seat_id;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('✅ Flight booked successfully!');
    DBMS_OUTPUT.PUT_LINE('Reservation PNR: ' || v_pnr);
    DBMS_OUTPUT.PUT_LINE('Payment ID: ' || v_payment_id);
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('❌ Failed to book flight: ');
END;
/

-- Test the procedure
BEGIN
      book_flight(
         12, -- passenger_id
         7, -- flight_schedule_id
         7, -- seat_id
         5000, -- airfare
         'creditcard', -- payment_mode
         '2024-11-23 13:30:00' -- travel_date
      );
    --  book_flight(
    --    6, -- passenger_id
    --     7, -- flight_schedule_id
    --     7, -- seat_id
    --     5000, -- airfare
    --     'creditcard', -- payment_mode
    --     '2024-11-23 13:30:00' -- travel_date
     -- );

    --   book_flight(
    --      7, -- passenger_id
    --      2, -- flight_schedule_id
    --      11, -- seat_id
    --      8000, -- airfare
    --      'bank', -- payment_mode
    --      '2024-03-01 12:00:00' -- travel_date
    --   );

    --   book_flight(
    --      9, -- passenger_id
    --      10, -- flight_schedule_id
    --      10, -- seat_id
    --      2300, -- airfare
    --      'debitcard', -- payment_mode
    --      '2024-12-21 12:00:00' -- travel_date
    --   );

    -- Case 2.1 - Jane will cancel flight within 24 hours
    book_flight(
         9, -- passenger_id
         10, -- flight_schedule_id
         10, -- seat_id
         345, -- airfare
         'creditcard', -- payment_mode
         '2024-10-30 07:28:08' -- travel_date
      );
END;
