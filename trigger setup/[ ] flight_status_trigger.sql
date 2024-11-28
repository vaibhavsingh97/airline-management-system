/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/

CREATE OR REPLACE TRIGGER check_and_update_flight_status
BEFORE INSERT OR UPDATE ON flight_schedule
FOR EACH ROW
BEGIN
    -- Check if the actual departure time is delayed by more than 15 minutes
    IF :NEW.actual_dep_time > :NEW.scheduled_dep_time + INTERVAL '15' MINUTE THEN
        :NEW.flight_status := 'delayed'; -- Set the status to 'DELAYED'
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred');
        RETURN;
END;
/

CREATE OR REPLACE TRIGGER check_route_within_one_hour
BEFORE INSERT OR UPDATE ON flight_schedule
FOR EACH ROW
DECLARE
    v_conflict_count NUMBER;
    flight_status_error EXCEPTION;

BEGIN
    -- Check if a flight is already scheduled for the same route within 1 hour
    SELECT COUNT(*)
    INTO v_conflict_count
    FROM flight_schedule fs
    WHERE fs.routes_route_id = :NEW.routes_route_id
      AND ABS(TO_NUMBER(:NEW.scheduled_dep_time - fs.scheduled_dep_time) * 1440) <= 60;

    -- If conflict exists, raise an error
    IF v_conflict_count > 0 THEN
        RAISE flight_status_error ;
    END IF;

    EXCEPTION
    WHEN flight_status_error THEN
        DBMS_OUTPUT.PUT_LINE('A flight is already scheduled for this route within 1 hour.');
        RETURN;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred');
        RETURN;
END;
/