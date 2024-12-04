CREATE OR REPLACE PROCEDURE find_available_flights (
   p_origin IN VARCHAR2,
   p_destination IN VARCHAR2,
   p_travel_date IN VARCHAR2
) IS
   v_flight_count NUMBER := 0;
BEGIN
   FOR rec IN (
      SELECT fs.flight_schedule_id, fs.departure_airport, fs.arrival_airport, 
             fs.scheduled_dep_time, fs.scheduled_arr_time, fs.flight_status
      FROM flight_schedule fs
      JOIN route r ON fs.routes_route_id = r.route_id
      WHERE r.origin_airport = p_origin
        AND r.destination_airport = p_destination
        AND TRUNC(fs.scheduled_dep_time) = TO_DATE(p_travel_date, 'YYYY-MM-DD')
        AND fs.flight_status = 'scheduled'
   ) LOOP
      v_flight_count := v_flight_count + 1;
      DBMS_OUTPUT.PUT_LINE('Flight ID: ' || rec.flight_schedule_id || 
                          ', Departure: ' || rec.scheduled_dep_time || 
                          ', Arrival: ' || rec.scheduled_arr_time);
   END LOOP;

   IF v_flight_count = 0 THEN
      DBMS_OUTPUT.PUT_LINE('❌ No flights available from ' || p_origin || 
                          ' to ' || p_destination || 
                          ' on ' || p_travel_date);
   END IF;
END;
/

CREATE OR REPLACE PROCEDURE find_available_seats (
    p_flight_schedule_id IN NUMBER
) IS
    v_seat_count NUMBER := 0;
BEGIN
    -- Get available seats for the flight
    FOR rec IN (
        SELECT 
            s.seat_id,
            s.seat_number,
            s.seat_type,
            s.seat_class
        FROM seat s
        WHERE s.fs_flight_schedule_id = p_flight_schedule_id
        AND s.is_available = 't'
        ORDER BY s.seat_class, s.seat_number
    ) LOOP
        v_seat_count := v_seat_count + 1;
        DBMS_OUTPUT.PUT_LINE(
            'Seat ID: ' || rec.seat_id || 
            ', Number: ' || rec.seat_number || 
            ', Type: ' || rec.seat_type ||
            ', Class: ' || rec.seat_class
        );
    END LOOP;

    IF v_seat_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('❌ No available seats for flight ' || p_flight_schedule_id);
    ELSE
        DBMS_OUTPUT.PUT_LINE('✅ Found ' || v_seat_count || ' available seat(s)');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('❌ Error finding available seats: ' || SQLERRM);
END;
/

-- Test Procedure
BEGIN
   find_available_flights('BOS', 'ATL', '2024-11-23');
   find_available_seats(7);
END;
/
