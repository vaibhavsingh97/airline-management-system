/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/

alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';

-- Create a trigger to check inventory
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
