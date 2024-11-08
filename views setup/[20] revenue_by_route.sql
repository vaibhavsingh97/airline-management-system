SET SERVEROUTPUT ON;

-- View 7: Revenue_By_Route: Displays the maximum revenue generated on different routes
-- Creator: Flight Operations Manager

DECLARE
    v_route_exists NUMBER;
    v_flight_schedule_exists NUMBER;
    v_reservation_exists NUMBER;
    v_view_exists NUMBER;
BEGIN
    -- Check if the view already exists
    SELECT COUNT(*)
    INTO v_view_exists
    FROM all_views
    WHERE view_name = 'REVENUE_BY_ROUTE';

    -- If the view exists, drop it
    IF v_view_exists > 0 THEN
        EXECUTE IMMEDIATE 'DROP VIEW Revenue_by_route';
        DBMS_OUTPUT.PUT_LINE('✅ Existing view Revenue_by_route dropped.');
    END IF;

    -- Check if required tables exist in the DEVELOPER schema
    SELECT COUNT(*) INTO v_route_exists FROM all_tables WHERE table_name = 'ROUTE' AND owner = 'DEVELOPER';
    SELECT COUNT(*) INTO v_flight_schedule_exists FROM all_tables WHERE table_name = 'FLIGHT_SCHEDULE' AND owner = 'DEVELOPER';
    SELECT COUNT(*) INTO v_reservation_exists FROM all_tables WHERE table_name = 'RESERVATION' AND owner = 'DEVELOPER';

    -- Create the view only if all required tables exist
    IF v_route_exists > 0 AND v_flight_schedule_exists > 0 AND v_reservation_exists > 0 THEN
        BEGIN
            EXECUTE IMMEDIATE 'CREATE OR REPLACE VIEW Revenue_by_route AS
                SELECT 
                    r.route_id,
                    r.origin_airport,
                    r.destination_airport,
                    COUNT(DISTINCT fs.flight_schedule_id) AS total_flights,
                    SUM(res.airfare) AS total_revenue,
                    MAX(res.airfare) AS max_revenue_per_flight
                FROM 
                    developer.route r
                JOIN developer.flight_schedule fs ON r.route_id = fs.routes_route_id
                JOIN developer.reservation res ON fs.flight_schedule_id = res.fs_flight_schedule_id
                GROUP BY 
                    r.route_id, r.origin_airport, r.destination_airport
                ORDER BY 
                    total_revenue DESC';

            DBMS_OUTPUT.PUT_LINE('✅ View Revenue_by_route created successfully.');
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('❌ Error creating view Revenue_by_route: ' || SQLERRM);
        END;
    ELSE
        -- Output error if any required table is missing
        DBMS_OUTPUT.PUT_LINE('❌ Required tables route, flight_schedule, or reservation do not exist in DEVELOPER schema. View creation aborted.');
    END IF;
END;
/
