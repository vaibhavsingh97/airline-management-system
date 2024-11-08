SET SERVEROUTPUT ON;

create or replace procedure insert_ground_ops_schedule (
   p_ops_schedule_id in number,
   p_created_at      in varchar2,
   p_updated_at      in varchar2,
   p_employee_id     in number,
   p_main_record_id  in number,
   p_inventory_id    in number
) is
   v_count number;
begin
   -- Check if a record exists with the provided ops_schedule_id
   select count(*)
     into v_count
     from ground_ops_schedule
    where ops_schedule_id = p_ops_schedule_id;

   -- If a record exists, update it
   if v_count > 0 then
      update ground_ops_schedule
         set updated_at = to_date(p_updated_at, 'YYYY-MM-DD HH24:MI:SS'),
             employee_employee_id = p_employee_id,
             mr_main_record_id = p_main_record_id,
             inventory_inventory_id = p_inventory_id
       where ops_schedule_id = p_ops_schedule_id;
      
      dbms_output.put_line('✅ Successfully updated ground ops schedule with ID: ' || p_ops_schedule_id);
      commit; -- Commit the update
   else
      -- If the record doesn't exist, perform the insertion
      begin
         insert into ground_ops_schedule (
            ops_schedule_id,
            created_at,
            updated_at,
            employee_employee_id,
            mr_main_record_id,
            inventory_inventory_id
         ) values (
            p_ops_schedule_id,
            to_date(p_created_at, 'YYYY-MM-DD HH24:MI:SS'),
            to_date(p_updated_at, 'YYYY-MM-DD HH24:MI:SS'),
            p_employee_id,
            p_main_record_id,
            p_inventory_id
         );
         dbms_output.put_line('✅ Successfully inserted ground ops schedule with ID: ' || p_ops_schedule_id);
         commit; -- Commit the insertion
      exception
         when others then
            -- If an error occurs during insertion, raise a custom error
            dbms_output.put_line('Error Code: ' || SQLCODE);
            dbms_output.put_line('Error Message: ' || SQLERRM);
            raise_application_error(
               -20001,
               '❌ Failed to insert ground ops schedule with ID: ' || p_ops_schedule_id
            );
      end;
   end if;
exception
   when others then
      -- If an error occurs during the procedure execution, raise a custom error
      dbms_output.put_line('Error Code: ' || SQLCODE);
      dbms_output.put_line('Error Message: ' || SQLERRM);
      raise_application_error(
         -20002,
         '❌ Failed to process ground ops schedule with ID: ' || p_ops_schedule_id
      );
end insert_ground_ops_schedule;
/

begin
    -- Inserting data into ground_ops_schedule table
   insert_ground_ops_schedule(1301, '2024-09-20 15:56:48', '2024-09-20 15:56:48', 610, 906, 401);
   insert_ground_ops_schedule(1302, '2024-10-22 12:58:34', '2024-10-22 12:58:34', 604, 906, 403);
   insert_ground_ops_schedule(1303, '2024-05-14 10:38:49', '2024-05-14 10:38:49', 609, 905, 410);
   insert_ground_ops_schedule(1304, '2024-06-10 17:49:50', '2024-06-10 17:49:50', 610, 902, 405);
   insert_ground_ops_schedule(1305, '2023-12-19 23:12:19', '2023-12-19 23:12:19', 605, 904, 405);
   insert_ground_ops_schedule(1306, '2024-09-03 10:23:45', '2024-09-03 10:23:45', 609, 904, 409);

   commit;
end;
/