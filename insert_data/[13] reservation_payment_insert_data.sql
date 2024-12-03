/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/
SET SERVEROUTPUT ON;

create or replace procedure insert_reservation_payment (
   p_payment_id         in number,
   p_reservation_id     in number,
   p_created_at         in varchar2,
   p_updated_at         in varchar2
) is
   v_count number;
begin
   -- Check if a record exists with the provided payment_id and reservation_id
   select count(*)
     into v_count
     from reservation_payment
    where payment_payment_id = p_payment_id
      and reservation_reservation_id = p_reservation_id;

   -- If a record exists, update it
   if v_count > 0 then
      update reservation_payment
         set updated_at = to_date(p_updated_at, 'YYYY-MM-DD HH24:MI:SS')
       where payment_payment_id = p_payment_id
         and reservation_reservation_id = p_reservation_id;
      
      dbms_output.put_line('✅ Successfully updated reservation_payment for Payment ID: ' || p_payment_id || ' and Reservation ID: ' || p_reservation_id);
      commit; -- Commit the update
   else
      -- If the record doesn't exist, perform the insertion
      begin
         insert into reservation_payment (
            payment_payment_id,
            reservation_reservation_id,
            created_at,
            updated_at
         ) values (
            p_payment_id,
            p_reservation_id,
            to_date(p_created_at, 'YYYY-MM-DD HH24:MI:SS'),
            to_date(p_updated_at, 'YYYY-MM-DD HH24:MI:SS')
         );
         dbms_output.put_line('✅ Successfully inserted reservation_payment for Payment ID: ' || p_payment_id || ' and Reservation ID: ' || p_reservation_id);
         commit; -- Commit the insertion
      exception
         when others then
            dbms_output.put_line('Error Code: ' || sqlcode);
            dbms_output.put_line('Error Message: ' || sqlerrm);
            -- If an error occurs during insertion, raise a custom error
            raise_application_error(
               -20007,
               '❌ Failed to insert reservation_payment for Payment ID: ' || p_payment_id || ' and Reservation ID: ' || p_reservation_id
            );
      end;
   end if;
exception
   when others then
      -- If an error occurs during the procedure execution, raise a custom error
      dbms_output.put_line('Error Code: ' || sqlcode);
      dbms_output.put_line('Error Message: ' || sqlerrm);
      raise_application_error(
         -20008,
         '❌ Failed to process reservation_payment for Payment ID: ' || p_payment_id || ' and Reservation ID: ' || p_reservation_id
      );
end insert_reservation_payment;
/

begin
   -- Inserting data into reservation_payment table using the procedure
   insert_reservation_payment(1501, 1401, '2024-04-01 07:08:24', '2024-04-01 07:08:24');
   insert_reservation_payment(1502, 1402, '2024-10-04 22:12:48', '2024-10-04 22:12:48');
   insert_reservation_payment(1503, 1403, '2023-08-18 15:08:47', '2023-08-18 15:08:47');
   insert_reservation_payment(1504, 1404, '2023-01-19 13:29:10', '2023-01-19 13:29:10');
   insert_reservation_payment(1505, 1405, '2023-02-23 02:54:29', '2023-02-23 02:54:29');
   insert_reservation_payment(1506, 1406, '2024-08-12 16:06:40', '2024-08-12 16:06:40');
   commit;
end;
/