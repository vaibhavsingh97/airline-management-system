/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/
SET SERVEROUTPUT ON;
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';

CREATE OR REPLACE PROCEDURE insert_reservation_payment (
   p_payment_id         IN NUMBER,
   p_reservation_id     IN NUMBER,
   p_created_at         IN VARCHAR2,
   p_updated_at         IN VARCHAR2
) IS
   v_count NUMBER;
   v_res_pay_id NUMBER;
BEGIN
   -- Check if a record exists with the provided payment_id and reservation_id
   SELECT COUNT(*)
     INTO v_count
     FROM reservation_payment
    WHERE payment_payment_id = p_payment_id
      AND reservation_reservation_id = p_reservation_id;

   -- If a record doesn't exist, perform the insertion
   IF v_count = 0 THEN
      BEGIN
         INSERT INTO reservation_payment (
            payment_payment_id,
            reservation_reservation_id,
            created_at,
            updated_at
         ) VALUES (
            p_payment_id,
            p_reservation_id,
            TO_DATE(p_created_at, 'YYYY-MM-DD HH24:MI:SS'),
            TO_DATE(p_updated_at, 'YYYY-MM-DD HH24:MI:SS')
         ) RETURNING res_pay_id INTO v_res_pay_id;
         
         DBMS_OUTPUT.PUT_LINE('✅ Successfully inserted reservation_payment with ID: ' || v_res_pay_id);
         COMMIT; -- Commit the insertion
      EXCEPTION
         WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(
               '❌ Failed to insert reservation_payment for ID: ' || v_res_pay_id
            );
      END;
   END IF;
EXCEPTION
   WHEN OTHERS THEN
      -- If an error occurs during the procedure execution, raise a custom error
      DBMS_OUTPUT.PUT_LINE(
         '❌ Failed to process reservation_payment for ID: ' || v_res_pay_id
      );
END insert_reservation_payment;
/

begin
   -- Inserting data into reservation_payment table using the procedure
   insert_reservation_payment(1,1,'2024-02-01 07:08:24','2024-02-01 07:08:24');
   insert_reservation_payment(2,2,'2024-03-01 12:06:00','2024-03-01 12:06:00');
   insert_reservation_payment(3,2,'2024-03-03 14:13:51','2024-03-03 14:13:51');
   insert_reservation_payment(4,3,'2024-06-21 17:28:32','2024-06-21 17:28:32');
   insert_reservation_payment(5,4,'2024-09-19 03:01:21','2024-09-19 03:01:21');
   insert_reservation_payment(6,5,'2024-10-01 20:31:58','2024-10-01 20:31:58');
   commit;
end;
/
