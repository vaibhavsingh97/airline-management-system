/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/
SET SERVEROUTPUT ON;

create or replace procedure insert_payment (
   p_payment_id      in number,
   p_payment_date    in varchar2,
   p_payment_amount  in number,
   p_payment_mode    in varchar2,
   p_payment_type    in varchar2,
   p_created_at      in varchar2,
   p_updated_at      in varchar2
) is
   v_count number;
begin
   -- Check if a record exists with the provided payment_id
   select count(*)
     into v_count
     from payment
    where payment_id = p_payment_id;

   -- If a record exists, update it
   if v_count > 0 then
      update payment
         set payment_date = to_date(p_payment_date, 'YYYY-MM-DD HH24:MI:SS'),
             payment_amount = p_payment_amount,
             payment_mode = p_payment_mode,
             payment_type = p_payment_type,
             updated_at = to_date(p_updated_at, 'YYYY-MM-DD HH24:MI:SS')
       where payment_id = p_payment_id;
      
      dbms_output.put_line('✅ Successfully updated payment with ID: ' || p_payment_id);
      commit; -- Commit the update
   else
      -- If the record doesn't exist, perform the insertion
      begin
         insert into payment (
            payment_id,
            payment_date,
            payment_amount,
            payment_mode,
            payment_type,
            created_at,
            updated_at
         ) values (
            p_payment_id,
            to_date(p_payment_date, 'YYYY-MM-DD HH24:MI:SS'),
            p_payment_amount,
            p_payment_mode,
            p_payment_type,
            to_date(p_created_at, 'YYYY-MM-DD HH24:MI:SS'),
            to_date(p_updated_at, 'YYYY-MM-DD HH24:MI:SS')
         );
         dbms_output.put_line('✅ Successfully inserted payment with ID: ' || p_payment_id);
         commit; -- Commit the insertion
      exception
         when others then
            DBMS_OUTPUT.PUT_LINE(
               '❌ Failed to insert payment with ID: ' || p_payment_id
            );
      end;
   end if;
exception
   when others then
      -- If an error occurs during the procedure execution, raise a custom error
      DBMS_OUTPUT.PUT_LINE(
         '❌ Failed to process payment with ID: ' || p_payment_id
      );
end insert_payment;
/

begin
   -- Inserting data into payment table using the procedure
   insert_payment(1501, '2024-04-01 07:08:24', 1699.5, 'debitcard', 'partial', '2024-04-01 07:08:24', '2024-04-01 07:08:24');
   insert_payment(1502, '2024-10-04 22:12:48', 8666.25, 'debitcard', 'full', '2024-10-04 22:12:48', '2024-10-04 22:12:48');
   insert_payment(1503, '2023-08-18 15:08:47', 1403.49, 'bank', 'full', '2023-08-18 15:08:47', '2023-08-18 15:08:47');
   insert_payment(1504, '2023-01-19 13:29:10', 800.55, 'wallet', 'partial', '2023-01-19 13:29:10', '2023-01-19 13:29:10');
   insert_payment(1505, '2023-02-23 02:54:29', 8033.3, 'bank', 'full', '2023-02-23 02:54:29', '2023-02-23 02:54:29');
   insert_payment(1506, '2024-08-12 16:06:40', 9460.96, 'creditcard', 'full', '2024-08-12 16:06:40', '2024-08-12 16:06:40');
   commit;
end;
/
