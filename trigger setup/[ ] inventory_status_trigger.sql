/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/

CREATE OR REPLACE TRIGGER check_inventory
BEFORE INSERT ON inventory
FOR EACH ROW
DECLARE
    v_order_quantity INTEGER;
    invalid_data EXCEPTION;
BEGIN
    -- Validate data: Quantity in hand and reorder threshold must be positive
    IF :NEW.quantity_in_hand <= 0 OR :NEW.reorder_threshold <= 0 THEN
        RAISE invalid_data;
    END IF;

    -- Validate data: Quantity in hand cannot exceed reorder threshold
    IF :NEW.quantity_in_hand < :NEW.reorder_threshold THEN
        RAISE invalid_data;
    END IF;

EXCEPTION
    WHEN invalid_data THEN
        DBMS_OUTPUT.PUT_LINE('Invalid data detected in inventory table. Check quantity_in_hand and reorder_threshold.');
        RAISE;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred in the check_inventory trigger.');
        RAISE;
       
END;
/



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
        INSERT INTO inventory_order (
            order_date, order_quantity, order_amount, order_status, supplier_name,
            created_at, updated_at, inventory_inventory_id
        ) VALUES (
            SYSDATE,                     -- Order date
            v_order_quantity,            -- Order quantity
            7000.00,                     -- Initial order amount
            'completed',                   -- Initial status
            'Default Supplier',          -- Placeholder supplier name
            SYSDATE,                     -- Created at
            SYSDATE,                     -- Updated at
            :NEW.inventory_id            -- Inventory ID (foreign key)
        );

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
