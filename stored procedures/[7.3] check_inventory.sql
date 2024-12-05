/*================================================
‼️ THIS FILE SHOULD BE RUN BY MAINTENANCE MANAGER ONLY ‼️
================================================*/

-- Check item availability in inventory
alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
CREATE OR REPLACE FUNCTION check_inventory(
    p_inventory_id IN NUMBER,
    p_required_quantity IN NUMBER
) RETURN BOOLEAN IS
    v_quantity_in_hand INTEGER;
BEGIN
    -- Check for inventory availability
    BEGIN
        SELECT quantity_in_hand
        INTO v_quantity_in_hand
        FROM developer.inventory
        WHERE inventory_id = p_inventory_id;

    EXCEPTION
        WHEN OTHERS THEN
            -- Handle any other unexpected errors
            DBMS_OUTPUT.PUT_LINE('❌ An unexpected error occurred while checking inventory for item ' || p_inventory_id);
            RETURN FALSE;  -- Return FALSE for any other error
    END;

    -- Return TRUE if sufficient quantity exists, otherwise return FALSE
    RETURN v_quantity_in_hand >= p_required_quantity;
END check_inventory;
/
