/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/
SET SERVEROUTPUT ON;
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';

CREATE OR REPLACE PROCEDURE insert_baggage (
   p_baggage_weight     IN NUMBER,
   p_baggage_status     IN VARCHAR2,
   p_created_at         IN VARCHAR2,
   p_updated_at         IN VARCHAR2,
   p_reservation_id     IN NUMBER
) IS
   v_baggage_id NUMBER;
BEGIN
   -- Always perform the insertion
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
      ROLLBACK;
END insert_baggage;
/

begin
   -- Inserting data into baggage table using the procedure
   insert_baggage(10, 'claimed', '2024-02-15 17:04:58', '2024-02-15 22:41:58', 1);
   insert_baggage(15, 'claimed', '2024-02-15 17:05:35', '2024-02-15 22:42:05', 1);
   insert_baggage(12, 'checkin', '2024-08-12 11:03:12', '2024-08-12 11:03:12', 3);
   insert_baggage(18, 'checkin', '2024-08-12 11:04:00', '2024-08-12 11:04:00', 3);
   commit;
end;
/
