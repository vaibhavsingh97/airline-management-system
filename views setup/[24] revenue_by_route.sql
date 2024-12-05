/*================================================
‼️ THIS FILE SHOULD BE RUN BY FLIGHT OPERATIONS MANAGER ONLY ‼️
================================================*/

DECLARE
    table_exists INTEGER;
    TYPE table_list_type IS TABLE OF VARCHAR2(30);
    table_list table_list_type := table_list_type('ROUTE', 'FLIGHT_SCHEDULE', 'RESERVATION');
BEGIN
    -- Check if all necessary tables exist
    FOR i IN 1..table_list.COUNT LOOP
        -- Check if table exists (case-insensitive check)
        EXECUTE IMMEDIATE 'SELECT COUNT(*) FROM all_tables WHERE UPPER(table_name) = :tbl' 
        INTO table_exists 
        USING UPPER(table_list(i));

        -- If any table does not exist, abort and exit
        IF table_exists = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Error: The ' || table_list(i) || ' table does not exist. View creation aborted.');
            RETURN;
        END IF;
    END LOOP;

    -- Create the view if all checks pass
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
        JOIN developer.seat st on st.fs_flight_schedule_id = fs.flight_schedule_id
        JOIN developer.reservation res ON res.seat_seat_id = st.seat_id
        GROUP BY 
            r.route_id, r.origin_airport, r.destination_airport
        ORDER BY 
            total_revenue DESC';

        DBMS_OUTPUT.PUT_LINE('✅View Revenue_by_route created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('❌Error creating view Revenue_by_route');
    END;
END;
/