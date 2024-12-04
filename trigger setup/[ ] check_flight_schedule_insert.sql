/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/

CREATE OR REPLACE TRIGGER check_flight_schedule_insert
BEFORE INSERT ON flight_schedule
FOR EACH ROW
DECLARE
    v_route_conflict_count NUMBER;
    v_upcoming_maintenance_count INTEGER;
    flight_status_error EXCEPTION;
    aircraft_maintenance_error EXCEPTION;
BEGIN
    -- Check if a flight is already scheduled for the same route within 1 hour
    SELECT COUNT(*)
    INTO v_route_conflict_count
    FROM flight_schedule fs
    WHERE fs.routes_route_id = :NEW.routes_route_id
      AND ABS(TO_NUMBER(:NEW.scheduled_dep_time - fs.scheduled_dep_time) * 1440) <= 60;

    IF v_route_conflict_count > 0 THEN
        RAISE flight_status_error;
    END IF;

    -- Check for maintenance scheduled today or tomorrow
    SELECT COUNT(*)
    INTO v_upcoming_maintenance_count
    FROM maintenance_schedule ms
    WHERE ms.schedule_date BETWEEN SYSDATE AND SYSDATE + 1
      AND ms.aircraft_aircraft_id = :NEW.aircraft_aircraft_id;

    IF v_upcoming_maintenance_count > 0 THEN
        RAISE aircraft_maintenance_error;
    END IF;

    -- Log successful validation
    DBMS_OUTPUT.PUT_LINE('Flight successfully scheduled for aircraft ' || :NEW.aircraft_aircraft_id);

EXCEPTION
    WHEN flight_status_error THEN
        DBMS_OUTPUT.PUT_LINE('A flight is already scheduled for this route within 1 hour.');
        RAISE;
    WHEN aircraft_maintenance_error THEN
        DBMS_OUTPUT.PUT_LINE('Aircraft ' || :NEW.aircraft_aircraft_id || 
            ' has maintenance scheduled and cannot be assigned to a flight.'
        );
        RAISE;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred during flight schedule insert.');
        RAISE;
END;
/