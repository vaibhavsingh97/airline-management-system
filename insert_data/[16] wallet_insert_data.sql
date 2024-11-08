SET SERVEROUTPUT ON;

create or replace procedure insert_wallet (
   p_wallet_id          in varchar2,
   p_program_tier       in varchar2,
   p_points_earned      in integer,
   p_points_redeemed    in integer,
   p_transaction_id     in varchar2,
   p_transaction_reason in varchar2,
   p_created_at         in varchar2,
   p_updated_at         in varchar2
) is
   v_count number;
begin
   -- Check if a record exists with the provided wallet_id
   select count(*)
     into v_count
     from wallet
    where wallet_id = p_wallet_id;

   -- If a record exists, update it
   if v_count > 0 then
      update wallet
         set program_tier = p_program_tier,
             points_earned = p_points_earned,
             points_redeemed = p_points_redeemed,
             transaction_id = p_transaction_id,
             transaction_reason = p_transaction_reason,
             updated_at = to_date(p_updated_at, 'YYYY-MM-DD HH24:MI:SS')
       where wallet_id = p_wallet_id;
      
      dbms_output.put_line('✅ Successfully updated wallet with ID: ' || p_wallet_id);
      commit; -- Commit the update
   else
      -- If the record doesn't exist, perform the insertion
      begin
         insert into wallet (
            wallet_id,
            program_tier,
            points_earned,
            points_redeemed,
            transaction_id,
            transaction_reason,
            created_at,
            updated_at
         ) values ( 
            p_wallet_id,
            p_program_tier,
            p_points_earned,
            p_points_redeemed,
            p_transaction_id,
            p_transaction_reason,
            to_date(p_created_at, 'YYYY-MM-DD HH24:MI:SS'),
            to_date(p_updated_at, 'YYYY-MM-DD HH24:MI:SS') 
         );
         dbms_output.put_line('✅ Successfully inserted wallet with ID: ' || p_wallet_id);
         commit; -- Commit the insertion
      exception
         when others then
            -- If an error occurs during insertion, raise a custom error
            DBMS_OUTPUT.PUT_LINE('Error Code: ' || SQLCODE);
            DBMS_OUTPUT.PUT_LINE('Error Message: ' || SQLERRM);
            raise_application_error(
               -20001,
               '❌ Failed to insert wallet with ID: ' || p_wallet_id
            );
      end;
   end if;
exception
   when others then
      -- If an error occurs during the procedure execution, raise a custom error
      DBMS_OUTPUT.PUT_LINE('Error Code: ' || SQLCODE);
      DBMS_OUTPUT.PUT_LINE('Error Message: ' || SQLERRM);
      raise_application_error(
         -20002,
         '❌ Failed to process wallet with ID: ' || p_wallet_id
      );
end insert_wallet;
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