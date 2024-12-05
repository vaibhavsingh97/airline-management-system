/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/
SET SERVEROUTPUT ON;
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';

CREATE OR REPLACE PROCEDURE insert_reservation (
   p_travel_date          IN VARCHAR2,
   p_reservation_status   IN VARCHAR2,
   p_created_at           IN VARCHAR2,
   p_updated_at           IN VARCHAR2,
   p_airfare              IN NUMBER,
   p_passenger_id         IN NUMBER,
   p_seat_id              IN NUMBER,
   p_pnr                  IN VARCHAR2,
   p_start_date           IN VARCHAR2,
   p_end_date             IN VARCHAR2
) IS
   v_count NUMBER;
   v_reservation_id NUMBER;
BEGIN
   -- Check if a record exists with the provided PNR (assuming PNR is unique)
   SELECT COUNT(*)
   INTO v_count
   FROM reservation
   WHERE pnr = p_pnr;

   IF v_count > 0 THEN
      -- Update existing reservation record
      UPDATE reservation
      SET travel_date = TO_DATE(p_travel_date, 'YYYY-MM-DD HH24:MI:SS'),
          reservation_status = p_reservation_status,
          updated_at = TO_DATE(p_updated_at, 'YYYY-MM-DD HH24:MI:SS'),
          airfare = p_airfare,
          passenger_passenger_id = p_passenger_id,
          seat_seat_id = p_seat_id,
          start_date = TO_DATE(p_start_date, 'YYYY-MM-DD HH24:MI:SS'),
          end_date = TO_DATE(p_end_date, 'YYYY-MM-DD HH24:MI:SS')
      WHERE pnr = p_pnr
      RETURNING reservation_id INTO v_reservation_id;
      
      DBMS_OUTPUT.PUT_LINE('✅ Successfully updated reservation with ID: ' || v_reservation_id);
   ELSE
      -- Insert new reservation record
      INSERT INTO reservation (
         travel_date,
         reservation_status,
         created_at,
         updated_at,
         airfare,
         passenger_passenger_id,
         seat_seat_id,
         pnr,
         start_date,
         end_date
      ) VALUES (
         TO_DATE(p_travel_date, 'YYYY-MM-DD HH24:MI:SS'),
         p_reservation_status,
         TO_DATE(p_created_at, 'YYYY-MM-DD HH24:MI:SS'),
         TO_DATE(p_updated_at, 'YYYY-MM-DD HH24:MI:SS'),
         p_airfare,
         p_passenger_id,
         p_seat_id,
         p_pnr,
         TO_DATE(p_start_date, 'YYYY-MM-DD HH24:MI:SS'),
         TO_DATE(p_end_date, 'YYYY-MM-DD HH24:MI:SS')
      ) RETURNING reservation_id INTO v_reservation_id;
      
      DBMS_OUTPUT.PUT_LINE('✅ Successfully inserted reservation with ID: ' || v_reservation_id);
   END IF;

   COMMIT; -- Commit the transaction
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('❌ Failed to insert or update reservation: ' || p_pnr);
END insert_reservation;
/

begin
   -- Inserting data into reservation table using the procedure
   insert_reservation('2024-02-15 20:17:22', 'confirmed', '2024-02-01 07:08:24', '2024-02-01 07:08:24', 100, 1,2,'TDW290',NULL,NULL);
   insert_reservation('2024-04-05 17:43:01', 'partial', '2024-03-01 12:06:00', '2024-03-01 12:06:00', 300, 3,9,'ABF012','2024-03-01 12:06:00','2024-03-04 12:06:00');
   insert_reservation('2024-08-12 13:36:46', 'confirmed', '2024-06-21 17:28:32', '2024-06-21 17:28:32', 60, 2,6,'QPO934',NULL,NULL);
   insert_reservation('2024-10-25 07:28:22', 'cancelled', '2024-09-19 03:01:21', '2024-10-20 21:13:40', 50, 4,3,'ZDG387',NULL,NULL);
   insert_reservation('2024-11-23 13:37:32', 'cancelled', '2024-10-01 20:31:58', '2024-10-31 00:18:11', 80, 5,7,'PSM162',NULL,NULL);
   insert_reservation('2024-08-12 13:36:46', 'confirmed', '2024-06-21 17:28:32', '2024-06-21 17:28:32', 60,5,6,'QPO984',NULL,NULL);

   commit;
end;
/
