/*
=======================================================
‼️ THIS FILE SHOULD BE RUN BY MAINTENANCE MANAGER ONLY ‼️
=======================================================
*/

DECLARE
    -- Declare variables for functions' return values
    v_is_scheduled BOOLEAN;
    v_is_available BOOLEAN;
    v_aircraft_id INTEGER := 8;
    v_maintenance_sch_id INTEGER;
    v_maintenance_rec_id INTEGER;
    v_inventory_id INTEGER := 2;
    v_required_quantity INTEGER := 10;
    v_order_amount NUMBER := 1000;
    v_supplier_name VARCHAR2(50) := 'Cronin and Mante';
BEGIN
    -- Step 1: Check if maintenance is scheduled for aircraft
    v_is_scheduled := check_maintenance_schedule(v_aircraft_id);

    IF v_is_scheduled THEN
        DBMS_OUTPUT.PUT_LINE('Maintenance is already scheduled for aircraft: ' || v_aircraft_id);
    ELSE
        -- Step 2: No maintenance scheduled, creating maintenance schedule
        DBMS_OUTPUT.PUT_LINE('No maintenance scheduled for aircraft: ' || v_aircraft_id);
        DBMS_OUTPUT.PUT_LINE('Creating maintenance schedule for aircraft: ' || v_aircraft_id || ' ...');
        
        -- Call procedure to create and get maintenance schedule ID
        create_and_return_maintenance_schedule_id(v_aircraft_id, SYSDATE, 'scheduled', v_maintenance_sch_id);
        DBMS_OUTPUT.PUT_LINE('Created maintenance schedule for aircraft: ' || v_aircraft_id || ' with schedule ID: ' || v_maintenance_sch_id);
        
        -- Step 3: Check inventory availability
        v_is_available := check_inventory(v_inventory_id, v_required_quantity);

        IF v_is_available THEN
            -- Step 4: If inventory is available, record the maintenance
            DBMS_OUTPUT.PUT_LINE('Sufficient inventory available for item id ' || v_inventory_id);
            record_maintenance('routine', 'Routine engine inspection', 14, v_inventory_id, v_maintenance_sch_id, v_maintenance_rec_id);
            DBMS_OUTPUT.PUT_LINE('Maintenance record created for maintenance schedule ID: ' || v_maintenance_sch_id);
        ELSE
            -- Step 5: If inventory is not available, place an order
            DBMS_OUTPUT.PUT_LINE('Not enough inventory available for item id ' || v_inventory_id);
            DBMS_OUTPUT.PUT_LINE('Placing order for item ' || v_inventory_id);
            place_inventory_order(v_inventory_id, v_required_quantity, v_supplier_name, v_order_amount);
            DBMS_OUTPUT.PUT_LINE('Inventory order placed for item ' || v_inventory_id);
        END IF;
    END IF;
    
    -- If the process completes successfully, commit the changes
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        -- Rollback in case of any error
        DBMS_OUTPUT.PUT_LINE('An error occurred during the process. Rolling back all changes.');
        ROLLBACK;
END;
/