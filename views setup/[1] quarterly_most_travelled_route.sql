/*================================================
‼️ THIS FILE SHOULD BE RUN BY FLIGHT OPERATIONS MANAGER ONLY ‼️
================================================*/

SET SERVEROUTPUT ON;

DECLARE
    v_flight_schedule_exists NUMBER;
    v_route_exists NUMBER;
    v_view_exists NUMBER;
BEGIN
    -- Check if the view exists
  SELECT COUNT(*)
  INTO v_view_exists
  FROM all_views
  WHERE view_name = 'QUARTERLY_MOST_TRAVELLED_ROUTE';
 
  -- If the view exists, drop it
  IF v_view_exists > 0 THEN
    EXECUTE IMMEDIATE 'DROP VIEW Quarterly_Most_Travelled_Route';
    DBMS_OUTPUT.PUT_LINE('✅ Existing view Quarterly_Most_Travelled_Route dropped.');
  END IF;

    -- Check if the 'flight_schedule' table exists
    SELECT COUNT(*)
    INTO v_flight_schedule_exists
    FROM all_tables
    WHERE table_name = 'FLIGHT_SCHEDULE'
    AND owner = 'DEVELOPER';

    -- Check if the 'route' table exists
    SELECT COUNT(*)
    INTO v_route_exists
    FROM all_tables
    WHERE table_name = 'ROUTE'
    AND owner = 'DEVELOPER';

    -- Only create the view if both tables exist
    IF v_flight_schedule_exists > 0 AND v_route_exists > 0 THEN
        EXECUTE IMMEDIATE 'CREATE OR REPLACE VIEW Quarterly_Most_Travelled_Route AS
            SELECT
                TO_CHAR(f.scheduled_dep_time, ''Q'') AS quarter,
                TO_CHAR(f.scheduled_dep_time, ''YYYY'') AS year,
                r.origin_airport,
                r.destination_airport,
                COUNT(f.flight_schedule_id) AS travel_count,
                DENSE_RANK() OVER (PARTITION BY TO_CHAR(f.scheduled_dep_time, ''Q''), TO_CHAR(f.scheduled_dep_time, ''YYYY'')
                                   ORDER BY COUNT(f.flight_schedule_id) DESC) AS rank
            FROM
                 developer.flight_schedule f
            JOIN
                 developer.route r ON f.routes_route_id = r.route_id
            GROUP BY
                TO_CHAR(f.scheduled_dep_time, ''Q''),
                TO_CHAR(f.scheduled_dep_time, ''YYYY''),
                r.origin_airport,
                r.destination_airport
            ORDER BY
                year,
                quarter,
                rank';

        DBMS_OUTPUT.PUT_LINE('✅ View Quarterly_Most_Travelled_Route created successfully.');

    ELSE
        -- Display a message if one or both tables do not exist
        DBMS_OUTPUT.PUT_LINE('❌ Required tables flight_schedule or route do not exist. View creation aborted.');
    END IF;
    EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('❌ Error creating view Quarterly_Most_Travelled_Route ');
END;
/
