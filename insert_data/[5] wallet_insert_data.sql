/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE insert_wallet (
   p_program_tier       IN VARCHAR2,
   p_points_earned      IN INTEGER,
   p_points_redeemed    IN INTEGER,
   p_transaction_id     IN VARCHAR2,
   p_transaction_reason IN VARCHAR2,
   p_created_at         IN VARCHAR2,
   p_updated_at         IN VARCHAR2
) IS
   v_count NUMBER;
   v_wallet_id NUMBER;
BEGIN
   -- Check if a record exists with the provided transaction_id
   SELECT COUNT(*)
     INTO v_count
     FROM wallet
    WHERE transaction_id = p_transaction_id;

   -- If a record doesn't exist, insert a new record
   IF v_count = 0 THEN
      INSERT INTO wallet (
         program_tier,
         points_earned,
         points_redeemed,
         transaction_id,
         transaction_reason,
         created_at,
         updated_at
      ) VALUES ( 
         p_program_tier,
         p_points_earned,
         p_points_redeemed,
         p_transaction_id,
         p_transaction_reason,
         TO_DATE(p_created_at, 'YYYY-MM-DD HH24:MI:SS'),
         TO_DATE(p_updated_at, 'YYYY-MM-DD HH24:MI:SS') 
      ) RETURNING wallet_id INTO v_wallet_id;

      DBMS_OUTPUT.PUT_LINE('✅ Successfully inserted wallet with ID: ' || v_wallet_id);
      COMMIT; -- Commit the insertion
   ELSE
      DBMS_OUTPUT.PUT_LINE('❗ Wallet with transaction ID ' || p_transaction_id || ' already exists.');
   END IF;

EXCEPTION
   WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE(
         '❌ Failed to process wallet: ' || SQLERRM
      );
END insert_wallet;
/

begin
    -- Inserting data into wallet table
   insert_wallet(
      'platinum',
      18698,
      1202,
      '30466',
      'credit',
      '2023-01-01 09:05:30',
      '2023-01-01 09:05:30'
   );
   insert_wallet(
      'platinum',
      15594,
      6195,
      '83242',
      'credit',
      '2023-02-18 15:25:44',
      '2023-02-18 15:25:44'
   );
   insert_wallet(
      'gold',
      15612,
      17814,
      '22330',
      'debit',
      '2023-04-05 10:16:12',
      '2023-04-05 10:16:12'
   );
   insert_wallet(
      'silver',
      11443,
      14835,
      '20140',
      'debit',
      '2023-06-19 07:50:03',
      '2023-06-19 07:50:03'
   );
   insert_wallet(
      'platinum',
      1840,
      19177,
      '87732',
      'debit',
      '2023-08-30 12:11:09',
      '2023-08-30 12:11:09'
   );
   commit;
end;
/
