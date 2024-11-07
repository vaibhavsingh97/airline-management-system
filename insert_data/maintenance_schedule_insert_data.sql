create or replace procedure insert_maintenance_schedule (
   p_main_schedule_id in integer,
   p_main_type        in varchar2,
   p_schedule_date    in date,
   p_created_at       in date,
   p_updated_at       in date
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
                         'DD-MM-YYYY HH24:MI:SS'),
                 to_date(p_created_at,
                         'DD-MM-YYYY HH24:MI:SS'),
                 to_date(p_updated_at,
                         'DD-MM-YYYY HH24:MI:SS') );
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
      '18-01-2023 07:00:00',
      '15-01-2023 07:22:13',
      '15-01-2023 07:22:13'
   );
   insert_maintenance_schedule(
      302,
      'inspection',
      '10-03-2023 14:00:00',
      '07-03-2023 14:35:50',
      '07-03-2023 14:35:50'
   );
   insert_maintenance_schedule(
      303,
      'scheduled',
      '27-05-2023 11:00:00',
      '22-05-2023 11:12:40',
      '22-05-2023 11:12:40'
   );
   insert_maintenance_schedule(
      304,
      'unscheduled',
      '14-07-2023 21:00:00',
      '09-07-2023 20:50:33',
      '09-07-2023 20:50:33'
   );
   insert_maintenance_schedule(
      305,
      'inspection',
      '30-09-2023 04:00:00',
      '25-09-2023 04:17:05',
      '25-09-2023 04:17:05'
   );
   insert_maintenance_schedule(
      306,
      'unscheduled',
      '19-11-2023 09:00:00',
      '14-11-2023 09:28:57',
      '14-11-2023 09:28:57'
   );
   insert_maintenance_schedule(
      307,
      'scheduled',
      '06-02-2024 16:00:00',
      '03-02-2024 16:11:21',
      '03-02-2024 16:11:21'
   );
   insert_maintenance_schedule(
      308,
      'scheduled',
      '22-04-2024 19:00:00',
      '17-04-2024 19:03:02',
      '17-04-2024 19:03:02'
   );
   insert_maintenance_schedule(
      309,
      'scheduled',
      '03-07-2024 22:00:00',
      '28-06-2024 22:09:45',
      '28-06-2024 22:09:45'
   );
   insert_maintenance_schedule(
      310,
      'emergency',
      '16-08-2024 14:00:00',
      '12-08-2024 13:50:38',
      '12-08-2024 13:50:38'
   );
   commit;
end;
/