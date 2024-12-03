/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE insert_reservation (
   p_travel_date          IN VARCHAR2,
   p_reservation_status   IN VARCHAR2,
   p_airfare              IN NUMBER,
   p_seat_number          IN VARCHAR2,
   p_pnr                  IN VARCHAR2,
   p_start_date           IN VARCHAR2,
   p_end_date             IN VARCHAR2,
   p_created_at           IN VARCHAR2,
   p_updated_at           IN VARCHAR2,
   p_passenger_id         IN NUMBER,
   p_seat_id              IN NUMBER
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
      SET travel_date = TO_DATE(p_travel_date, 'DD-MM-YYYY'),
          reservation_status = p_reservation_status,
          airfare = p_airfare,
          seat_number = p_seat_number,
          start_date = TO_DATE(p_start_date, 'YYYY-MM-DD HH24:MI:SS'),
          end_date = TO_DATE(p_end_date, 'YYYY-MM-DD HH24:MI:SS'),
          updated_at = TO_DATE(p_updated_at, 'YYYY-MM-DD HH24:MI:SS'),
          passenger_passenger_id = p_passenger_id,
          seat_seat_id = p_seat_id
      WHERE pnr = p_pnr
      RETURNING reservation_id INTO v_reservation_id;
      
      DBMS_OUTPUT.PUT_LINE('✅ Successfully updated reservation with ID: ' || v_reservation_id);
   ELSE
      -- Insert new reservation record
      INSERT INTO reservation (
         travel_date,
         reservation_status,
         airfare,
         seat_number,
         pnr,
         start_date,
         end_date,
         created_at,
         updated_at,
         passenger_passenger_id,
         seat_seat_id
      ) VALUES (
         TO_DATE(p_travel_date, 'DD-MM-YYYY'),
         p_reservation_status,
         p_airfare,
         p_seat_number,
         p_pnr,
         TO_DATE(p_start_date, 'YYYY-MM-DD HH24:MI:SS'),
         TO_DATE(p_end_date, 'YYYY-MM-DD HH24:MI:SS'),
         TO_DATE(p_created_at, 'YYYY-MM-DD HH24:MI:SS'),
         TO_DATE(p_updated_at, 'YYYY-MM-DD HH24:MI:SS'),
         p_passenger_id,
         p_seat_id
      ) RETURNING reservation_id INTO v_reservation_id;
      
      DBMS_OUTPUT.PUT_LINE('✅ Successfully inserted reservation with ID: ' || v_reservation_id);
   END IF;

   COMMIT; -- Commit the transaction
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error Code: ' || SQLCODE);
      DBMS_OUTPUT.PUT_LINE('Error Message: ' || SQLERRM);
      RAISE_APPLICATION_ERROR(-20006, '❌ Failed to insert or update reservation: ' || p_pnr);
END insert_reservation;
/

begin
   -- Inserting data into reservation table using the procedure
   insert_reservation(1401, '11-02-2025', 'cancelled', 8890.22, '91I', 'TDW290', '2024-04-01 07:08:24', '2024-04-04 07:08:24', '2024-04-01 07:08:24', '2024-04-01 07:08:24', 804, 1103);
   insert_reservation(1402, '23-10-2024', 'confirmed', 9860.92, '83G', 'MVJ441', '2024-10-04 22:12:48', '2024-10-07 22:12:48', '2024-10-04 22:12:48', '2024-10-04 22:12:48', 810, 1104);
   insert_reservation(1403, '12-05-2024', 'cancelled', 8766.91, '84Q', 'UGE527', '2023-08-18 15:08:47', '2023-08-21 15:08:47', '2023-08-18 15:08:47', '2023-08-18 15:08:47', 801, 1109);
   insert_reservation(1404, '07-11-2024', 'confirmed', 9101.44, '94N', 'DDB146', '2023-01-19 13:29:10', '2023-01-22 13:29:10', '2023-01-19 13:29:10', '2023-01-19 13:29:10', 802, 1107);
   insert_reservation(1405, '16-05-2025', 'confirmed', 8085.09, '18L', 'KLM472', '2024-02-23 02:54:29', '2024-02-26 02:54:29', '2024-02-23 02:54:29', '2024-02-23 02:54:29', 808, 1109);
   insert_reservation(1406, '14-02-2025', 'confirmed', 7033.23, '77O', 'OGX792', '2024-08-12 16:06:40', '2024-08-15 16:06:40', '2024-08-12 16:06:40', '2024-08-12 16:06:40', 803, 1102);
   insert_reservation(1407, '06-07-2025', 'cancelled', 9884.95, '73B', 'KPF789', '2023-10-21 13:30:34', '2023-10-24 13:30:34', '2023-10-21 13:30:34', '2023-10-21 13:30:34', 805, 1102);
   insert_reservation(1408, '04-04-2025', 'confirmed', 1628.37, '72U', 'BKU141', '2024-08-28 10:59:50', '2024-08-31 10:59:50', '2024-08-28 10:59:50', '2024-08-28 10:59:50', 807, 1109);
   insert_reservation(1409, '17-01-2025', 'cancelled', 1303.54, '13Z', 'DYY833', '2023-06-25 13:41:39', '2023-06-28 13:41:39', '2023-06-25 13:41:39', '2023-06-25 13:41:39', 808, 1105);
   insert_reservation(1410, '10-12-2025', 'confirmed', 7970.6, '42S', 'XNT661', '2023-03-21 03:31:59', '2023-03-24 03:31:59', '2023-03-21 03:31:59', '2023-03-21 03:31:59', 803, 1102);
   commit;
end;
/