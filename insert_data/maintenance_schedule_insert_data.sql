create or replace procedure insert_maintenance_schedule (
   p_main_schedule_id in integer,
   p_main_type        in varchar2,
   p_schedule_date    in varchar2,
   p_created_at       in varchar2,
   p_updated_at       in varchar2
) is
   v_count number;
begin
    -- Try to delete the existing maintenance schedule record if it exists
    -- Check if a record exists with the provided main_schedule_id
   select count(*)
     into v_count
     from maintenance_schedule
    where main_schedule_id = p_main_schedule_id;

    -- If a record exists, delete it
   if v_count > 0 then
      delete from maintenance_schedule
       where main_schedule_id = p_main_schedule_id;
      commit; -- Commit the deletion
      null;
   end if;

    -- Perform the insertion into the maintenance_schedule table
   begin
      insert into maintenance_schedule (
         main_schedule_id,
         main_type,
         schedule_date,
         created_at,
         updated_at
      ) values ( p_main_schedule_id,
                 p_main_type,
                 to_date(p_schedule_date,
                         'YYYY-MM-DD HH24:MI:SS'),
                 to_date(p_created_at,
                         'YYYY-MM-DD HH24:MI:SS'),
                 to_date(p_updated_at,
                         'YYYY-MM-DD HH24:MI:SS') );
      dbms_output.put_line('✅ Successfully inserted maintenance_schedule with ID: ' || p_main_schedule_id);
      commit; -- Commit the insertion
   exception
      when others then
            -- If an error occurs during insertion, raise a custom error
         raise_application_error(
            -20001,
            '❌ Failed to insert maintenance schedule with ID: ' || p_main_schedule_id
         );
   end;

end insert_maintenance_schedule;
/


begin
    -- Inserting data into maintenance_schedule table using the procedure
   insert_maintenance_schedule(
      301,
      'scheduled',
      '2023-01-18 07:00:00',
      '2023-01-15 07:22:13',
      '2023-01-15 07:22:13'
   );
   insert_maintenance_schedule(
      302,
      'inspection',
      '2023-03-10 14:00:00',
      '2023-03-07 14:35:50',
      '2023-03-07 14:35:50'
   );
   insert_maintenance_schedule(
      303,
      'scheduled',
      '2023-05-27 11:00:00',
      '2023-05-22 11:12:40',
      '2023-05-22 11:12:40'
   );
   insert_maintenance_schedule(
      304,
      'unscheduled',
      '2023-07-14 21:00:00',
      '2023-07-09 20:50:33',
      '2023-07-09 20:50:33'
   );
   insert_maintenance_schedule(
      305,
      'inspection',
      '2023-09-30 04:00:00',
      '2023-09-25 04:17:05',
      '2023-09-25 04:17:05'
   );
   insert_maintenance_schedule(
      306,
      'unscheduled',
      '2023-11-19 09:00:00',
      '2023-11-14 09:28:57',
      '2023-11-14 09:28:57'
   );
   insert_maintenance_schedule(
      307,
      'scheduled',
      '2024-02-06 16:00:00',
      '2024-02-03 16:11:21',
      '2024-02-03 16:11:21'
   );
   insert_maintenance_schedule(
      308,
      'scheduled',
      '2024-04-22 19:00:00',
      '2024-04-17 19:03:02',
      '2024-04-17 19:03:02'
   );
   insert_maintenance_schedule(
      309,
      'scheduled',
      '2024-07-03 22:00:00',
      '2024-06-28 22:09:45',
      '2024-06-28 22:09:45'
   );
   insert_maintenance_schedule(
      310,
      'emergency',
      '2024-08-16 14:00:00',
      '2024-08-12 13:50:38',
      '2024-08-12 13:50:38'
   );
   commit;
end;
/