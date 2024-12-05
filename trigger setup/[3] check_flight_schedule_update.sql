/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/

alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';

/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/
CREATE OR REPLACE TRIGGER check_flight_schedule_update
BEFORE UPDATE ON flight_schedule
FOR EACH ROW
DECLARE
    overlapping_schedule_error EXCEPTION;
    aircraft_maintenance_error EXCEPTION;
    PRAGMA AUTONOMOUS_TRANSACTION; -- Add autonomous transaction
BEGIN
    -- Only check for conflicts when scheduling new flights or changing times
    IF :NEW.flight_status = 'scheduled' AND 
       (:OLD.scheduled_dep_time != :NEW.scheduled_dep_time OR 
        :OLD.scheduled_arr_time != :NEW.scheduled_arr_time) THEN
        
        -- Use a compound trigger to avoid mutating table error
        -- Check overlapping schedules in a separate transaction
        DECLARE
            v_conflict_count NUMBER;
        BEGIN
            SELECT COUNT(*)
            INTO v_conflict_count
            FROM flight_schedule fs
            WHERE fs.aircraft_aircraft_id = :NEW.aircraft_aircraft_id
            AND fs.flight_schedule_id != :NEW.flight_schedule_id
            AND fs.flight_status = 'scheduled'
            AND (
                (:NEW.scheduled_dep_time BETWEEN fs.scheduled_dep_time AND fs.scheduled_arr_time)
                OR
                (:NEW.scheduled_arr_time BETWEEN fs.scheduled_dep_time AND fs.scheduled_arr_time)
                OR
                (fs.scheduled_dep_time BETWEEN :NEW.scheduled_dep_time AND :NEW.scheduled_arr_time)
                OR
                (fs.scheduled_arr_time BETWEEN :NEW.scheduled_dep_time AND :NEW.scheduled_arr_time)
            );
            
            IF v_conflict_count > 0 THEN
                RAISE overlapping_schedule_error;
            END IF;
        END;
    END IF;

    -- Log successful validation
    DBMS_OUTPUT.PUT_LINE('Flight successfully updated for aircraft ' || :NEW.aircraft_aircraft_id);

EXCEPTION
    WHEN overlapping_schedule_error THEN
        DBMS_OUTPUT.PUT_LINE('Aircraft ' || :NEW.aircraft_aircraft_id || 
            ' is already scheduled for another flight in the same timeframe.');
        RAISE;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred during flight schedule update.');
        RAISE;
END;
/