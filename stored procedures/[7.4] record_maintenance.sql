
/*=====================================================
‼️ THIS FILE SHOULD BE RUN BY MAINTENANCE MANAGER ONLY ‼️
=======================================================
*/
alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
CREATE OR REPLACE PROCEDURE record_maintenance(
    p_maintenance_type IN VARCHAR2,
    p_description IN VARCHAR2,
    p_employee_id IN NUMBER,
    p_inventory_id IN NUMBER,
    p_main_schedule_id IN NUMBER,
    p_maintenance_record_id OUT NUMBER  -- OUT parameter to return the generated ID
) IS
BEGIN
    BEGIN
        -- Insert the maintenance record into the database
        INSERT INTO developer.maintenance_record (
            main_record_date, 
            main_record_type, 
            main_record_description,
            employee_employee_id,
            inventory_inventory_id,
            ms_main_schedule_id,
            created_at,
            updated_at
        ) VALUES (
            SYSDATE, 
            p_maintenance_type, 
            p_description, 
            p_employee_id,
            p_inventory_id,
            p_main_schedule_id,
            SYSDATE, 
            SYSDATE
        )
        RETURNING main_record_id INTO p_maintenance_record_id;  -- Capture the generated ID

        DBMS_OUTPUT.PUT_LINE('✅ Maintenance record logged with record ID: ' || p_maintenance_record_id);

        COMMIT;  -- Commit the transaction

    EXCEPTION
        WHEN OTHERS THEN
            -- Handle any other unexpected errors
            DBMS_OUTPUT.PUT_LINE('❌ An unexpected error occurred while logging the maintenance record');
            ROLLBACK;  -- Rollback the transaction for any other error
    END;
END record_maintenance;
/
