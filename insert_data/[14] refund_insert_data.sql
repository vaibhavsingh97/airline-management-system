/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/
SET SERVEROUTPUT ON;

create or replace procedure insert_refund (
   p_refund_id          in number,
   p_refund_amount      in number,
   p_refund_reason      in varchar2,
   p_created_at         in varchar2,
   p_updated_at         in varchar2,
   p_payment_id         in number
) is
   v_count number;
begin
   -- Check if a record exists with the provided refund_id
   select count(*)
     into v_count
     from refund
    where refund_id = p_refund_id;

   -- If a record exists, update it
   if v_count > 0 then
      update refund
         set refund_amount = p_refund_amount,
             refund_reason = p_refund_reason,
             updated_at = to_date(p_updated_at, 'YYYY-MM-DD HH24:MI:SS'),
             payment_payment_id = p_payment_id
       where refund_id = p_refund_id;
      
      dbms_output.put_line('✅ Successfully updated refund with ID: ' || p_refund_id);
      commit; -- Commit the update
   else
      -- If the record doesn't exist, perform the insertion
      begin
         insert into refund (
            refund_id,
            refund_amount,
            refund_reason,
            created_at,
            updated_at,
            payment_payment_id
         ) values (
            p_refund_id,
            p_refund_amount,
            p_refund_reason,
            to_date(p_created_at, 'YYYY-MM-DD HH24:MI:SS'),
            to_date(p_updated_at, 'YYYY-MM-DD HH24:MI:SS'),
            p_payment_id
         );
         dbms_output.put_line('✅ Successfully inserted refund with ID: ' || p_refund_id);
         commit; -- Commit the insertion
      exception
         when others then
            DBMS_OUTPUT.PUT_LINE(
               '❌ Failed to insert refund with ID: ' || p_refund_id
            );
      end;
   end if;
exception
   when others then
      -- If an error occurs during the procedure execution, raise a custom error
      DBMS_OUTPUT.PUT_LINE(
         '❌ Failed to process refund with ID: ' || p_refund_id
      );
end insert_refund;
/

begin
   -- Inserting data into refund table using the procedure
   insert_refund(1601, 1699.50, 'reservation cancelled', '2024-03-15 10:00:00', '2024-03-15 10:00:00', 1501);
   insert_refund(1602, 9884.95, 'reservation cancelled', '2024-08-25 16:00:00', '2024-08-25 16:00:00', 1506);
   commit;
end;
/
