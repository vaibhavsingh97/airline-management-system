/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/
SET SERVEROUTPUT ON;
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';

CREATE OR REPLACE PROCEDURE insert_wallet (
   p_membership_id      IN VARCHAR2,
   p_program_tier       IN VARCHAR2,
   p_points_earned      IN INTEGER,
   p_points_redeemed    IN INTEGER,
   p_transaction_id     IN VARCHAR2,
   p_transaction_reason IN VARCHAR2,
   p_passenger_passenger_id IN VARCHAR2,
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

   IF v_count > 0 THEN
      -- Update existing wallet record
      UPDATE wallet
      SET membership_id = p_membership_id,
          program_tier = p_program_tier,
          points_earned = p_points_earned,
          points_redeemed = p_points_redeemed,
          transaction_reason = p_transaction_reason,
          passenger_passenger_id = p_passenger_passenger_id,
          updated_at = TO_DATE(p_updated_at, 'YYYY-MM-DD HH24:MI:SS')
      WHERE transaction_id = p_transaction_id
      RETURNING wallet_id INTO v_wallet_id;

      DBMS_OUTPUT.PUT_LINE('✅ Successfully updated wallet with ID: ' || v_wallet_id);
      
      ELSE
      -- If a record doesn't exist, insert a new record
      INSERT INTO wallet (
         membership_id,
         program_tier,
         points_earned,
         points_redeemed,
         transaction_id,
         transaction_reason,
         passenger_passenger_id,
         created_at,
         updated_at
      ) VALUES ( 
         p_membership_id,
         p_program_tier,
         p_points_earned,
         p_points_redeemed,
         p_transaction_id,
         p_transaction_reason,
         p_passenger_passenger_id,
         TO_DATE(p_created_at, 'YYYY-MM-DD HH24:MI:SS'),
         TO_DATE(p_updated_at, 'YYYY-MM-DD HH24:MI:SS') 
      ) RETURNING wallet_id INTO v_wallet_id;

      DBMS_OUTPUT.PUT_LINE('✅ Successfully inserted wallet with ID: ' || v_wallet_id);
      COMMIT; -- Commit the insertion
   END IF;

EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(
         '❌ Failed to process wallet ');
END insert_wallet;
/

begin
    -- Inserting data into wallet table
   insert_wallet(
      'HN321',
      'platinum',
      100,
      0,
      '30466',
      'credit',
      1,
      '2023-01-01 09:05:30',
      '2023-01-01 09:05:30'
   );
   insert_wallet(
      'GD787',
      'platinum',
      400,
      0,
      '83242',
      'credit',
      2,
      '2023-02-18 15:25:44',
      '2023-02-18 15:25:44'
   );
   insert_wallet(
      'PF498',
      'gold',
      200,
      0,
      '22330',
      'credit',
      3,
      '2023-04-05 10:16:12',
      '2023-04-05 10:16:12'
   );
   insert_wallet(
      'OC396',
      'silver',
      600,
      0,
      '20140',
      'credit',
      4,
      '2023-06-19 07:50:03',
      '2023-06-19 07:50:03'
   );
   insert_wallet(
      'DP912',
      'platinum',
      700,
      0,
      '87732',
      'credit',
      5,
      '2023-08-30 12:11:09',
      '2023-08-30 12:11:09'
   );
   insert_wallet(
      'PF498',
      'gold',
      0,
      100,
      '22331',
      'debit',
      3,
      '2023-04-05 10:16:12',
      '2023-04-05 10:16:12'
   );
   insert_wallet(
      'DP912',
      'platinum',
      0,
      400,
      '87733',
      'debit',
      5,
      '2023-08-30 12:11:09',
      '2023-08-30 12:11:09'
   );
   commit;
end;
/
