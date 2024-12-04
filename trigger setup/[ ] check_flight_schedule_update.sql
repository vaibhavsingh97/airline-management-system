/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/

alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';

CREATE OR REPLACE TRIGGER check_flight_schedule_update
BEFORE UPDATE ON flight_schedule
FOR EACH ROW
DECLARE
    v_aircraft_conflict_count NUMBER;
    v_upcoming_maintenance_count INTEGER;
    overlapping_schedule_error EXCEPTION;
    aircraft_maintenance_error EXCEPTION;
BEGIN
    -- Check if the actual departure time is delayed by more than 15 minutes
    IF :NEW.actual_dep_time > :NEW.scheduled_dep_time + INTERVAL '15' MINUTE THEN
        :NEW.flight_status := 'delayed'; -- Set the status to 'DELAYED'
    END IF;

    -- Check if the same aircraft is scheduled for more than one flight in overlapping timeframes
    SELECT COUNT(*)
    INTO v_aircraft_conflict_count
    FROM flight_schedule fs
    WHERE fs.aircraft_aircraft_id = :NEW.aircraft_aircraft_id
      AND (
          (:NEW.scheduled_dep_time BETWEEN fs.scheduled_dep_time AND fs.scheduled_arr_time)
          OR
          (:NEW.scheduled_arr_time BETWEEN fs.scheduled_dep_time AND fs.scheduled_arr_time)
          OR
          (fs.scheduled_dep_time BETWEEN :NEW.scheduled_dep_time AND :NEW.scheduled_arr_time)
          OR
          (fs.scheduled_arr_time BETWEEN :NEW.scheduled_dep_time AND :NEW.scheduled_arr_time)
      )
      AND fs.flight_schedule_id != :NEW.flight_schedule_id;

    IF v_aircraft_conflict_count > 0 THEN
        RAISE overlapping_schedule_error;
    END IF;

    -- Log successful validation
    DBMS_OUTPUT.PUT_LINE('Flight successfully updated for aircraft ' || :NEW.aircraft_aircraft_id);

EXCEPTION
    WHEN overlapping_schedule_error THEN
        DBMS_OUTPUT.PUT_LINE('Aircraft ' || :NEW.aircraft_aircraft_id || 
            ' is already scheduled for another flight in the same timeframe.'
        );
        RAISE;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred during flight schedule update.');
        RAISE;
END;
/