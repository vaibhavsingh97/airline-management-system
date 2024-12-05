/*================================================
‼️ THIS FILE SHOULD BE RUN BY INVENTORY_MANAGER ONLY ‼️
================================================*/

alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
CREATE OR REPLACE PROCEDURE fulfill_pending_orders
AS
    v_updated_count INTEGER;
BEGIN
    -- Update all orders with status 'pending' to 'fulfilled'
    UPDATE developer.inventory_order
    SET order_status = 'fulfilled',
        updated_at = SYSDATE
    WHERE order_status = 'pending';
    COMMIT;

    -- Get the number of rows updated
    v_updated_count := SQL%ROWCOUNT;

    -- Output the result
    DBMS_OUTPUT.PUT_LINE('Number of pending orders updated to fulfilled: ' || v_updated_count);
EXCEPTION
    WHEN OTHERS THEN
        -- Handle unexpected errors
        DBMS_OUTPUT.PUT_LINE('An error occurred while updating pending orders in inventory_order table.');
        RAISE;
END fulfill_pending_orders;
/

BEGIN
    fulfill_pending_orders;
END;
