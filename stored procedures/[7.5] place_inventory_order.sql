/*
======================================================
‼️ THIS FILE SHOULD BE RUN BY MAINTENANCE MANAGER ONLY ‼️
======================================================
*/

-- Place inventory order for unavailable items
alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
CREATE OR REPLACE PROCEDURE place_inventory_order(
    p_inventory_id IN NUMBER,
    p_quantity IN NUMBER,
    p_supplier_name IN VARCHAR2,
    p_order_amount IN NUMBER
) IS
    v_order_id NUMBER;
BEGIN
    BEGIN
        -- Insert inventory order into the inventory_order table
        INSERT INTO developer.inventory_order (
            order_date, 
            order_quantity,
            order_amount,
            order_status, 
            supplier_name, 
            inventory_inventory_id, 
            created_at, 
            updated_at
        ) VALUES (
            SYSDATE, 
            p_quantity,
            p_order_amount,
            'pending',  -- Order status set to 'pending'
            p_supplier_name,
            p_inventory_id,
            SYSDATE,
            SYSDATE
        )
        RETURNING order_id INTO v_order_id;  -- Capture the generated order ID

        DBMS_OUTPUT.PUT_LINE('✅ Inventory order placed for item ' || p_inventory_id || 
                             ' with order ID: ' || v_order_id || 
                             ' from supplier: ' || p_supplier_name || 
                             ' with amount: ' || p_order_amount);

        COMMIT;  -- Commit the transaction

    EXCEPTION
        WHEN OTHERS THEN
            -- Handle any other unexpected errors
            DBMS_OUTPUT.PUT_LINE('❌ An unexpected error occurred while placing the inventory order.');
            ROLLBACK;  -- Rollback the transaction for any other error
    END;
END place_inventory_order;
/
