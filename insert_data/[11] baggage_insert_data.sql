/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE insert_baggage (
   p_baggage_weight     IN NUMBER,
   p_baggage_status     IN VARCHAR2,
   p_created_at         IN VARCHAR2,
   p_updated_at         IN VARCHAR2,
   p_reservation_id     IN NUMBER
) IS
   v_count NUMBER;
   v_baggage_id NUMBER;
BEGIN
   -- Check if a record exists with the provided reservation_id
   SELECT COUNT(*)
     INTO v_count
     FROM baggage
    WHERE reservation_reservation_id = p_reservation_id;

   -- If a record exists, update it
   IF v_count > 0 THEN
      UPDATE baggage
         SET baggage_weight = p_baggage_weight,
             baggage_status = p_baggage_status,
             updated_at = TO_DATE(p_updated_at, 'YYYY-MM-DD HH24:MI:SS')
       WHERE reservation_reservation_id = p_reservation_id
      RETURNING baggage_id INTO v_baggage_id;
      
      DBMS_OUTPUT.PUT_LINE('✅ Successfully updated baggage with ID: ' || v_baggage_id);
      COMMIT; -- Commit the update
   ELSE
      -- If the record doesn't exist, perform the insertion
      BEGIN
         INSERT INTO baggage (
            baggage_weight,
            baggage_status,
            created_at,
            updated_at,
            reservation_reservation_id
         ) VALUES (
            p_baggage_weight,
            p_baggage_status,
            TO_DATE(p_created_at, 'YYYY-MM-DD HH24:MI:SS'),
            TO_DATE(p_updated_at, 'YYYY-MM-DD HH24:MI:SS'),
            p_reservation_id
         ) RETURNING baggage_id INTO v_baggage_id;
         
         DBMS_OUTPUT.PUT_LINE('✅ Successfully inserted baggage with ID: ' || v_baggage_id);
         COMMIT; -- Commit the insertion
      EXCEPTION
         WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(
               '❌ Failed to insert baggage for reservation ID: ' || p_reservation_id
            );
      END;
   END IF;
EXCEPTION
   WHEN OTHERS THEN
      -- If an error occurs during the procedure execution, raise a custom error
      DBMS_OUTPUT.PUT_LINE(
         '❌ Failed to process baggage for reservation ID: ' || p_reservation_id
      );
END insert_baggage;
/

begin
   -- Inserting data into baggage table using the procedure
   insert_baggage(1701, 43.22, 'check-in', '2025-02-11 15:56:20', '2025-02-11 15:56:20', 1401);
   insert_baggage(1702, 19.23, 'loaded', '2024-10-23 16:58:34', '2024-10-23 16:58:34', 1402);
   insert_baggage(1703, 41.79, 'loaded', '2024-05-12 00:39:06', '2024-05-12 00:39:06', 1403);
   insert_baggage(1704, 17.64, 'unloaded', '2024-11-07 18:00:49', '2024-11-07 18:00:49', 1404);
   insert_baggage(1705, 5.17, 'loaded', '2025-05-16 20:00:56', '2025-05-16 20:00:56', 1405);
   insert_baggage(1706, 37.35, 'loaded', '2025-02-14 16:42:58', '2025-02-14 16:42:58', 1406);
   commit;
end;
/
