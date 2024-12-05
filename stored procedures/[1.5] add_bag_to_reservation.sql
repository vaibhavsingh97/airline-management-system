/*
================================================
‼️ THIS FILE SHOULD BE RUN BY PASSENGER ONLY ‼️
================================================
*/

alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
CREATE OR REPLACE PROCEDURE add_bags_to_reservation (
    p_reservation_id IN NUMBER,
    p_baggage_count IN NUMBER,
    p_baggage_weight IN NUMBER
) IS
    v_res_exists NUMBER;
    v_success_count NUMBER := 0;
    invalid_reservation EXCEPTION;
BEGIN
    -- Check reservation exists and is confirmed
    SELECT COUNT(*)
    INTO v_res_exists
    FROM developer.reservation
    WHERE reservation_id = p_reservation_id
    AND reservation_status = 'confirmed';
    
    IF v_res_exists = 0 THEN
        RAISE invalid_reservation;
    END IF;
    
    -- Insert baggage entries and track successes
    FOR i IN 1..p_baggage_count LOOP
        developer.insert_baggage(
            p_baggage_weight,
            'checkin',
            TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'),
            TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'),
            p_reservation_id
        );
        v_success_count := v_success_count + 1;
    END LOOP;
    
    -- Only commit and show success if all bags were added
    IF v_success_count = p_baggage_count THEN
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('✅ Successfully added ' || v_success_count || 
                            ' baggage entries for reservation ID: ' || p_reservation_id);
    END IF;

EXCEPTION
    WHEN invalid_reservation THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('❌ Invalid or unconfirmed reservation ID: ' || p_reservation_id);
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('❌ Failed to add baggage ');
END;
/

-- Test the procedure
BEGIN
    add_bags_to_reservation(
        7,    -- reservation_id
        2,    -- number of bags
        15.5  -- weight per bag
    );
END;
/
