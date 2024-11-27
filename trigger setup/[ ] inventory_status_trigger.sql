/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/

CREATE OR REPLACE TRIGGER check_and_reorder_inventory
BEFORE INSERT OR UPDATE ON inventory
FOR EACH ROW
WHEN (NEW.quantity_in_hand < NEW.reorder_threshold) -- Trigger only for low inventory
DECLARE
    v_order_id INTEGER;
    v_order_quantity INTEGER;
BEGIN
    -- Output a message for debugging/logging
    DBMS_OUTPUT.PUT_LINE('Inventory is low for item: ' || :NEW.item_name);

    -- Calculate the order quantity
    v_order_quantity := :NEW.reorder_threshold - :NEW.quantity_in_hand;

    -- Insert a new order with status 'pending'
    INSERT INTO inventory_order (
        order_date, order_quantity, order_amount, order_status, supplier_name,
        inventory_inventory_id, created_at, updated_at
    ) VALUES (
        SYSDATE,                     -- Order date
        v_order_quantity,            -- Order quantity
        0,                           -- Order amount
        'pending',                   -- Initial status
        'Default Supplier',          -- Placeholder supplier name
        :NEW.inventory_id,           -- Inventory ID (foreign key)
        SYSDATE,                     -- Created at
        SYSDATE                      -- Updated at
    )
    RETURNING order_id INTO v_order_id; -- Get the generated order_id

    -- Update the order to 'completed'
    UPDATE inventory_order
    SET order_status = 'completed',order_amount = 7000.00,updated_at = SYSDATE
    WHERE order_id = v_order_id;

    -- Replenish the inventory
    :NEW.quantity_in_hand := :NEW.quantity_in_hand + v_order_quantity;

    -- Output a message confirming the inventory replenishment
    DBMS_OUTPUT.PUT_LINE('Inventory replenished for item: ' || :NEW.item_name || 
                         ' | New Quantity: ' || :NEW.quantity_in_hand);
END;
/