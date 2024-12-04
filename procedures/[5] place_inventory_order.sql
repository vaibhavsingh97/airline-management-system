/*
======================================================
‼️ THIS FILE SHOULD BE RUN BY MAINTENANCE MANAGER ONLY ‼️
======================================================
*/

-- Place inventory order for unavailable items

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

        DBMS_OUTPUT.PUT_LINE('Inventory order placed for item ' || p_inventory_id || 
                             ' with order ID: ' || v_order_id || 
                             ' from supplier: ' || p_supplier_name || 
                             ' with amount: ' || p_order_amount);

        COMMIT;  -- Commit the transaction

    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            -- Handle duplicate value errors (e.g., trying to place duplicate orders for the same item)
            DBMS_OUTPUT.PUT_LINE('Error: Duplicate order detected. An order already exists for the same item.');
            ROLLBACK;  -- Rollback the transaction in case of duplicate values
        WHEN TOO_MANY_ROWS THEN
            -- Handle case where query returns more than one row unexpectedly
            DBMS_OUTPUT.PUT_LINE('Error: Too many rows returned while trying to insert the order.');
            ROLLBACK;  -- Rollback the transaction in case of too many rows
        WHEN VALUE_ERROR THEN
            -- Handle errors related to data type mismatches or invalid values
            DBMS_OUTPUT.PUT_LINE('Error: Invalid data entered for the inventory order.');
            ROLLBACK;  -- Rollback the transaction in case of invalid input
        WHEN OTHERS THEN
            -- Handle any other unexpected errors
            DBMS_OUTPUT.PUT_LINE('An unexpected error occurred while placing the inventory order.');
            ROLLBACK;  -- Rollback the transaction for any other error
    END;
END place_inventory_order;
/