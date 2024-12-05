/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/
SET SERVEROUTPUT ON;
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';

CREATE OR REPLACE PROCEDURE insert_refund (
   p_refund_amount      IN NUMBER,
   p_refund_reason      IN VARCHAR2,
   p_created_at         IN VARCHAR2,
   p_updated_at         IN VARCHAR2,
   p_payment_id         IN NUMBER
) IS
   v_count NUMBER;
   v_refund_id NUMBER;
BEGIN
   -- Check if a record exists with the provided payment_id
   SELECT COUNT(*)
     INTO v_count
     FROM refund
    WHERE payment_payment_id = p_payment_id;

   -- If a record doesn't exist, perform the insertion
   IF v_count = 0 THEN
      BEGIN
         INSERT INTO refund (
            refund_amount,
            refund_reason,
            created_at,
            updated_at,
            payment_payment_id
         ) VALUES (
            p_refund_amount,
            p_refund_reason,
            TO_DATE(p_created_at, 'YYYY-MM-DD HH24:MI:SS'),
            TO_DATE(p_updated_at, 'YYYY-MM-DD HH24:MI:SS'),
            p_payment_id
         ) RETURNING refund_id INTO v_refund_id;
         
         DBMS_OUTPUT.PUT_LINE('✅ Successfully inserted refund with ID: ' || v_refund_id);
         COMMIT; -- Commit the insertion
      EXCEPTION
         WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(
               '❌ Failed to insert refund for ID: ' || v_refund_id
            );
      END;
   END IF;
EXCEPTION
   WHEN OTHERS THEN
      -- If an error occurs during the procedure execution, raise a custom error
      DBMS_OUTPUT.PUT_LINE(
         '❌ Failed to process refund for ID: ' || v_refund_id
      );
END insert_refund;
/

begin
   -- Inserting data into refund table using the procedure
   insert_refund(50, 'reservation cancelled', '2024-10-20 21:13:40', '2024-10-20 21:13:40', 5);
   insert_refund(80, 'reservation cancelled', '2024-10-31 00:18:11', '2024-10-31 00:18:11', 6);
   commit;
end;
/
