/*================================================
‼️ THIS FILE SHOULD BE RUN BY INVENTORY MANAGER ONLY ‼️
================================================*/

DECLARE
    table_exists INTEGER;
BEGIN
    -- Check if the inventory table exists
    SELECT COUNT(*)
    INTO table_exists
    FROM all_tables
    WHERE UPPER(table_name) = 'INVENTORY';

    -- Proceed if the inventory table exists
    IF table_exists > 0 THEN
        -- Attempt to create the view
        BEGIN
            EXECUTE IMMEDIATE 'CREATE OR REPLACE VIEW Current_Inventory_Status AS
            SELECT 
                inventory_id,
                item_name,
                item_category,
                inv_last_updated,
                quantity_in_hand AS current_stock
            FROM 
                DEVELOPER.inventory
            ORDER BY 
                inventory_id';
            
            DBMS_OUTPUT.PUT_LINE('✅ View Current_Inventory_Status created successfully.');
        
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('❌ Error creating view Current_Inventory_Status ');
        END;
    
    ELSE
        DBMS_OUTPUT.PUT_LINE('❌ Error: The inventory table does not exist. View creation aborted.');
    END IF;
END;
/
