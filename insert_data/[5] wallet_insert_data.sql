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
   v_wallet_id VARCHAR2(50);
BEGIN
   -- Generate a new wallet_id (you might want to use a more sophisticated method)
   v_wallet_id := 'W' || TO_CHAR(WALLET_SEQ.NEXTVAL, 'FM0000000');

   -- Check if a record exists with the generated wallet_id (just in case)
   SELECT COUNT(*)
     INTO v_count
     FROM wallet
    WHERE wallet_id = v_wallet_id;

   -- If a record doesn't exist (which should always be the case), insert a new record
   IF v_count = 0 THEN
      INSERT INTO wallet (
         wallet_id,
         program_tier,
         points_earned,
         points_redeemed,
         transaction_id,
         transaction_reason,
         created_at,
         updated_at
      ) VALUES ( 
         v_wallet_id,
         p_program_tier,
         p_points_earned,
         p_points_redeemed,
         p_transaction_id,
         p_transaction_reason,
         TO_DATE(p_created_at, 'YYYY-MM-DD HH24:MI:SS'),
         TO_DATE(p_updated_at, 'YYYY-MM-DD HH24:MI:SS') 
      );

      DBMS_OUTPUT.PUT_LINE('✅ Successfully inserted wallet with ID: ' || v_wallet_id);
      COMMIT; -- Commit the insertion
   ELSE
      -- This should never happen if wallet_id is generated uniquely
      RAISE_APPLICATION_ERROR(-20003, 'Wallet ID already exists: ' || v_wallet_id);
   END IF;

EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error Code: ' || SQLCODE);
      DBMS_OUTPUT.PUT_LINE('Error Message: ' || SQLERRM);
      -- If an error occurs, raise a custom error
      RAISE_APPLICATION_ERROR(
         -20002,
         '❌ Failed to process wallet: ' || SQLERRM
      );
END insert_wallet;
/

begin
    -- Inserting data into wallet table
   insert_wallet(
      501,
      'platinum',
      18698,
      1202,
      '30466',
      'credit',
      '2023-01-01 09:05:30',
      '2023-01-01 09:05:30'
   );
   insert_wallet(
      502,
      'platinum',
      15594,
      6195,
      '83242',
      'credit',
      '2023-02-18 15:25:44',
      '2023-02-18 15:25:44'
   );
   insert_wallet(
      503,
      'gold',
      15612,
      17814,
      '22330',
      'debit',
      '2023-04-05 10:16:12',
      '2023-04-05 10:16:12'
   );
   insert_wallet(
      504,
      'silver',
      11443,
      14835,
      '20140',
      'debit',
      '2023-06-19 07:50:03',
      '2023-06-19 07:50:03'
   );
   insert_wallet(
      505,
      'platinum',
      1840,
      19177,
      '87732',
      'debit',
      '2023-08-30 12:11:09',
      '2023-08-30 12:11:09'
   );
   insert_wallet(
      506,
      'platinum',
      12019,
      9249,
      '28888',
      'credit',
      '2023-10-14 19:22:18',
      '2023-10-14 19:22:18'
   );
   insert_wallet(
      507,
      'gold',
      15201,
      16649,
      '17633',
      'credit',
      '2023-12-02 22:05:45',
      '2023-12-02 22:05:45'
   );
   insert_wallet(
      508,
      'gold',
      18361,
      15299,
      '60702',
      'debit',
      '2024-01-17 11:37:55',
      '2024-01-17 11:37:55'
   );
   insert_wallet(
      509,
      'gold',
      7565,
      13260,
      '49848',
      'credit',
      '2024-03-27 16:14:30',
      '2024-03-27 16:14:30'
   );
   insert_wallet(
      510,
      'gold',
      12319,
      16339,
      '04743',
      'debit',
      '2024-05-09 20:45:12',
      '2024-05-09 20:45:12'
   );

   commit;
end;
/