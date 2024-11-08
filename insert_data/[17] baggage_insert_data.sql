SET SERVEROUTPUT ON;

create or replace procedure insert_baggage (
   p_baggage_id         in number,
   p_baggage_weight     in number,
   p_baggage_status     in varchar2,
   p_created_at         in varchar2,
   p_updated_at         in varchar2,
   p_reservation_id     in number
) is
   v_count number;
begin
   -- Check if a record exists with the provided baggage_id
   select count(*)
     into v_count
     from baggage
    where baggage_id = p_baggage_id;

   -- If a record exists, update it
   if v_count > 0 then
      update baggage
         set baggage_weight = p_baggage_weight,
             baggage_status = p_baggage_status,
             updated_at = to_date(p_updated_at, 'YYYY-MM-DD HH24:MI:SS'),
             reservation_reservation_id = p_reservation_id
       where baggage_id = p_baggage_id;
      
      dbms_output.put_line('✅ Successfully updated baggage with ID: ' || p_baggage_id);
      commit; -- Commit the update
   else
      -- If the record doesn't exist, perform the insertion
      begin
         insert into baggage (
            baggage_id,
            baggage_weight,
            baggage_status,
            created_at,
            updated_at,
            reservation_reservation_id
         ) values (
            p_baggage_id,
            p_baggage_weight,
            p_baggage_status,
            to_date(p_created_at, 'YYYY-MM-DD HH24:MI:SS'),
            to_date(p_updated_at, 'YYYY-MM-DD HH24:MI:SS'),
            p_reservation_id
         );
         dbms_output.put_line('✅ Successfully inserted baggage with ID: ' || p_baggage_id);
         commit; -- Commit the insertion
      exception
         when others then
            dbms_output.put_line('Error Code: ' || sqlcode);
            dbms_output.put_line('Error Message: ' || sqlerrm);
            -- If an error occurs during insertion, raise a custom error
            raise_application_error(
               -20009,
               '❌ Failed to insert baggage with ID: ' || p_baggage_id
            );
      end;
   end if;
exception
   when others then
      -- If an error occurs during the procedure execution, raise a custom error
      dbms_output.put_line('Error Code: ' || sqlcode);
      dbms_output.put_line('Error Message: ' || sqlerrm);
      raise_application_error(
         -20010,
         '❌ Failed to process baggage with ID: ' || p_baggage_id
      );
end insert_baggage;
/

begin
   -- Inserting data into baggage table using the procedure
   insert_baggage(1701, 43.22, 'check-in', '2025-02-11 15:56:20', '2025-02-11 15:56:20', 1401);
   insert_baggage(1702, 19.23, 'loaded', '2024-10-23 16:58:34', '2024-10-23 16:58:34', 1402);
   insert_baggage(1703, 41.79, 'loaded', '2024-05-12 00:39:06', '2024-05-12 00:39:06', 1403);
   insert_baggage(1704, 17.64, 'unloaded', '2024-11-07 18:00:49', '2024-11-07 18:00:49', 1404);
   insert_baggage(1705, 5.17, 'loaded', '2025-05-16 20:00:56', '2025-05-16 20:00:56', 1405);
   insert_baggage(1706, 37.35, 'loaded', '2025-02-14 16:42:58', '2025-02-14 16:42:58', 1406);
   commit;
end;
/