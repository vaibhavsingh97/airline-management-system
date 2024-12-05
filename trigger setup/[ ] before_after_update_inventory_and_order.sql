/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/

alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
-- Create a trigger to reorder inventory from inventory_order table
CREATE OR REPLACE TRIGGER reorder_inventory
BEFORE UPDATE ON inventory
FOR EACH ROW
DECLARE
    v_order_quantity INTEGER;
    invalid_data EXCEPTION;
BEGIN
    -- Validate data: Quantity in hand and reorder threshold must be positive
    IF :NEW.quantity_in_hand <= 0 OR :NEW.reorder_threshold <= 0 THEN
        RAISE invalid_data;
    END IF;

    -- Check if inventory is low before updating
    IF :NEW.quantity_in_hand < :NEW.reorder_threshold THEN
        -- Debugging/logging
        DBMS_OUTPUT.PUT_LINE('Low inventory detected for item: ' || :NEW.item_name);

        -- Calculate the order quantity
        v_order_quantity := :NEW.reorder_threshold + :NEW.quantity_in_hand;

        -- Insert a new order with status 'pending' for the same inventory ID

        insert_inventory_order(
            SYSDATE,                     -- Order date
            v_order_quantity,            -- Order quantity
            v_order_quantity * 100,      -- Initial order amount
            'pending',                   -- Initial status
            'Default Supplier',          -- Placeholder supplier name
            SYSDATE,                     -- Created at
            SYSDATE,                     -- Updated at
            :NEW.inventory_id   );       -- Inventory ID (foreign key)

        -- Debugging/logging
        DBMS_OUTPUT.PUT_LINE('Order placed for inventory ID: ' || :NEW.inventory_id || 
                             ' | Order Quantity: ' || v_order_quantity);
    END IF;

EXCEPTION
    WHEN invalid_data THEN
        DBMS_OUTPUT.PUT_LINE('Invalid data detected in inventory table. Check quantity_in_hand and reorder_threshold.');
        RAISE;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred in the reorder_inventory trigger.');
        RAISE;
END;
/

-- Create a trigger to update inventory table after order
CREATE OR REPLACE TRIGGER update_inventory_after_order
AFTER UPDATE ON inventory_order
FOR EACH ROW
WHEN (NEW.order_status = 'pending') -- Trigger fires only when the status becomes 'pending'
DECLARE
    v_current_quantity INTEGER;
    no_inventory_found EXCEPTION;
BEGIN
    -- Check if the inventory ID exists in the inventory table
    SELECT quantity_in_hand
    INTO v_current_quantity
    FROM inventory
    WHERE inventory_id = :NEW.inventory_inventory_id;


    IF v_current_quantity IS NULL THEN
        -- Log an error if no matching inventory ID is found
        DBMS_OUTPUT.PUT_LINE('No matching inventory found for inventory_id: ' || :NEW.inventory_inventory_id);
        RAISE no_inventory_found;
    END IF;


    -- Update the quantity in hand for the specific inventory ID
    UPDATE inventory
    SET quantity_in_hand = v_current_quantity + :NEW.order_quantity,
        updated_at = SYSDATE
    WHERE inventory_id = :NEW.inventory_inventory_id;

    -- Log a success message for debugging
    DBMS_OUTPUT.PUT_LINE('Inventory updated for inventory_id: ' || :NEW.inventory_inventory_id ||
                         ' | New Quantity: ' || (v_current_quantity + :NEW.order_quantity));
EXCEPTION
    WHEN no_inventory_found THEN
        -- Log an error if no matching inventory ID is found
        DBMS_OUTPUT.PUT_LINE('No matching inventory found for inventory_id: ' || :NEW.inventory_inventory_id);
        RAISE;
    WHEN OTHERS THEN
        -- Handle any other unexpected errors
        DBMS_OUTPUT.PUT_LINE('An error occurred in update_inventory_after_order' );
        RAISE;
END;
/
