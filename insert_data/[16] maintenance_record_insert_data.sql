/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/
SET SERVEROUTPUT ON;

create or replace procedure insert_maintenance_record (
   p_main_record_id   in number,
   p_main_record_date in varchar2,
   p_main_record_type in varchar2,
   p_description      in varchar2,
   p_created_at       in varchar2,
   p_updated_at       in varchar2,
   p_aircraft_id      in number,
   p_employee_id      in number,
   p_inventory_id     in number,
   p_main_schedule_id in number
) is
   v_count number;
begin
   -- Check if a record exists with the provided main_record_id
   select count(*)
     into v_count
     from maintenance_record
    where main_record_id = p_main_record_id;

   -- If a record exists, update it
   if v_count > 0 then
      update maintenance_record
         set main_record_date = to_date(p_main_record_date, 'YYYY-MM-DD HH24:MI:SS'),
             main_record_type = p_main_record_type,
             main_record_description = p_description,
             updated_at = to_date(p_updated_at, 'YYYY-MM-DD HH24:MI:SS'),
             aircraft_aircraft_id = p_aircraft_id,
             employee_employee_id = p_employee_id,
             inventory_inventory_id = p_inventory_id,
             ms_main_schedule_id = p_main_schedule_id
       where main_record_id = p_main_record_id;
      
      dbms_output.put_line('✅ Successfully updated maintenance record with ID: ' || p_main_record_id);
      commit; -- Commit the update
   else
      -- If the record doesn't exist, perform the insertion
      begin
         insert into maintenance_record (
            main_record_id,
            main_record_date,
            main_record_type,
            main_record_description,
            created_at,
            updated_at,
            aircraft_aircraft_id,
            employee_employee_id,
            inventory_inventory_id,
            ms_main_schedule_id
         ) values ( 
            p_main_record_id,
            to_date(p_main_record_date, 'YYYY-MM-DD HH24:MI:SS'),
            p_main_record_type,
            p_description,
            to_date(p_created_at, 'YYYY-MM-DD HH24:MI:SS'),
            to_date(p_updated_at, 'YYYY-MM-DD HH24:MI:SS'),
            p_aircraft_id,
            p_employee_id,
            p_inventory_id,
            p_main_schedule_id 
         );
         dbms_output.put_line('✅ Successfully inserted maintenance record with ID: ' || p_main_record_id);
         commit; -- Commit the insertion
      exception
         when others then
            -- If an error occurs during insertion, raise a custom error
            DBMS_OUTPUT.PUT_LINE(
               '❌ Failed to insert maintenance record with ID: ' || p_main_record_id
            );
      end;
   end if;
exception
   when others then
      -- If an error occurs during the procedure execution, raise a custom error
      DBMS_OUTPUT.PUT_LINE(
         '❌ Failed to process maintenance record with ID: ' || p_main_record_id
      );
end insert_maintenance_record;
/

begin
   -- Inserting data into maintenance_record table
   insert_maintenance_record(
      901,
      '2023-07-31 00:02:33',
      'routine',
      'Refueling aircraft',
      '2024-09-13 03:19:16',
      '2024-09-13 03:19:16',
      105,
      601,
      404,
      301
   );

   insert_maintenance_record(
      902,
      '2024-03-16 14:37:05',
      'routine',
      'Testing communication systems',
      '2024-05-11 19:08:50',
      '2024-05-11 19:08:50',
      106,
      605,
      403,
      301
   );

   insert_maintenance_record(
      903,
      '2024-10-20 12:55:42',
      'inspection',
      'Testing communication systems',
      '2023-11-06 06:24:55',
      '2023-11-06 06:24:55',
      106,
      603,
      406,
      306
   );

   insert_maintenance_record(
      904,
      '2023-08-25 10:19:09',
      'inspection',
      'Inspecting brakes',
      '2024-07-11 12:17:03',
      '2024-07-11 12:17:03',
      106,
      610,
      409,
      303
   );

   insert_maintenance_record(
      905,
      '2023-12-31 19:52:46',
      'cleaning',
      'Inspecting brakes',
      '2024-08-05 07:40:53',
      '2024-08-05 07:40:53',
      105,
      610,
      403,
      307
   );

   insert_maintenance_record(
      906,
      '2023-08-07 08:32:44',
      'routine',
      'Replacing air filters',
      '2024-03-29 03:34:53',
      '2024-03-29 03:34:53',
      104,
      607,
      401,
      307
   );

   insert_maintenance_record(
      907,
      '2023-09-23 13:11:38',
      'repairs',
      'Refueling aircraft',
      '2024-10-16 08:54:40',
      '2024-10-16 08:54:40',
      102,
      608,
      406,
      304
   );

   commit;
end;
/
