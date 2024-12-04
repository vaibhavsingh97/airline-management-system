/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/
SET SERVEROUTPUT ON;
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';

CREATE OR REPLACE PROCEDURE insert_payment (
   p_payment_date    IN VARCHAR2,
   p_payment_amount  IN NUMBER,
   p_payment_mode    IN VARCHAR2,
   p_payment_type    IN VARCHAR2,
   p_created_at      IN VARCHAR2,
   p_updated_at      IN VARCHAR2
) IS
   v_count NUMBER;
   v_payment_id NUMBER;
BEGIN
   -- Check if a record exists with the provided payment details
   SELECT COUNT(*)
     INTO v_count
     FROM payment
    WHERE payment_date = TO_DATE(p_payment_date, 'YYYY-MM-DD HH24:MI:SS')
      AND payment_amount = p_payment_amount
      AND payment_mode = p_payment_mode
      AND payment_type = p_payment_type;

   -- If a record doesn't exist, perform the insertion
   IF v_count = 0 THEN
      BEGIN
         INSERT INTO payment (
            payment_date,
            payment_amount,
            payment_mode,
            payment_type,
            created_at,
            updated_at
         ) VALUES (
            TO_DATE(p_payment_date, 'YYYY-MM-DD HH24:MI:SS'),
            p_payment_amount,
            p_payment_mode,
            p_payment_type,
            TO_DATE(p_created_at, 'YYYY-MM-DD HH24:MI:SS'),
            TO_DATE(p_updated_at, 'YYYY-MM-DD HH24:MI:SS')
         ) RETURNING payment_id INTO v_payment_id;
         
         DBMS_OUTPUT.PUT_LINE('✅ Successfully inserted payment with ID: ' || v_payment_id);
         COMMIT; -- Commit the insertion
      EXCEPTION
         WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(
               '❌ Failed to insert payment with ID: ' || v_payment_id
            );
      END;
   END IF;
EXCEPTION
   WHEN OTHERS THEN
      -- If an error occurs during the procedure execution, raise a custom error
      DBMS_OUTPUT.PUT_LINE(
         '❌ Failed to process payment with ID: ' || v_payment_id
      );
END insert_payment;
/

begin
   -- Inserting data into payment table using the procedure
   insert_payment('2024-02-01 07:08:24', 100, 'debitcard', 'full', '2024-02-01 07:08:24', '2024-02-01 07:08:24');
   insert_payment('2024-03-01 12:06:00', 100, 'creditcard', 'partial', '2024-03-01 12:06:00', '2024-03-01 12:06:00');
   insert_payment('2024-03-03 14:13:51', 200, 'creditcard', 'partial', '2024-03-03 14:13:51', '2024-03-03 14:13:51');
   insert_payment('2024-06-21 17:28:32', 60, 'bank', 'full', '2024-06-21 17:28:32', '2024-06-21 17:28:32');
   insert_payment('2024-09-19 03:01:21', 50, 'debitcard', 'full', '2024-09-19 03:01:21', '2024-09-19 03:01:21');
   insert_payment('2024-10-01 20:31:58', 80, 'creditcard', 'full', '2024-10-01 20:31:58', '2024-10-01 20:31:58');
   commit;
end;
/
