/*================================================
‼ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼
================================================*/
SET SERVEROUTPUT ON;
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';

create or replace procedure insert_seat (
   p_seat_number        in varchar2,
   p_seat_type          in varchar2,
   p_seat_class         in varchar2,
   p_is_available       in char,
   p_created_at         in varchar2,
   p_updated_at         in varchar2,
   p_fs_flight_schedule_id in number
) is
   v_count number;
   v_seat_id INTEGER; 
begin
   -- Check if a record exists with the provided seat_id
   select count(*)
     into v_count
     from seat
    where seat_number = p_seat_number and fs_flight_schedule_id = p_fs_flight_schedule_id;

   -- If a record exists, update it
   if v_count > 0 then
      update seat
         set seat_type = p_seat_type,
             seat_class = p_seat_class,
             is_available = p_is_available,
             updated_at = to_date(p_updated_at, 'YYYY-MM-DD HH24:MI:SS')
       where seat_number = p_seat_number and fs_flight_schedule_id = p_fs_flight_schedule_id
       RETURNING seat_id INTO v_seat_id;
      
      dbms_output.put_line('✅ Successfully updated seat with ID: ' || v_seat_id);
      commit; -- Commit the update
   else
      -- If the record doesn't exist, perform the insertion
      begin
         insert into seat (
            seat_number,
            seat_type,
            seat_class,
            is_available,
            created_at,
            updated_at,
            fs_flight_schedule_id
         ) values ( 
            p_seat_number,
            p_seat_type,
            p_seat_class,
            p_is_available,
            to_date(p_created_at, 'YYYY-MM-DD HH24:MI:SS'),
            to_date(p_updated_at, 'YYYY-MM-DD HH24:MI:SS'),
            p_fs_flight_schedule_id 
         ) RETURNING seat_id INTO v_seat_id;
         dbms_output.put_line('✅ Successfully inserted seat with ID: ' || v_seat_id);
         commit; -- Commit the insertion
      exception
         when others then
            -- If an error occurs during insertion, raise a custom error
            DBMS_OUTPUT.PUT_LINE(
               '❌ Failed to insert seat with ID: ' || v_seat_id
            );
      end;
   end if;
exception
   when others then
      -- If an error occurs during the procedure execution, raise a custom error
      DBMS_OUTPUT.PUT_LINE(
         '❌ Failed to process seat with ID: ' || v_seat_id
      );
end insert_seat;
/

begin
    -- Inserting data into seat table
   insert_seat(
      '1A',
      'middle',
      'first',
      't',
      '2023-10-15 23:07:31',
      '2023-10-15 23:07:31',
      1
   );
   insert_seat(
      '2A',
      'window',
      'economy',
      'f',
      '2023-06-30 12:54:22',
      '2023-06-30 12:54:22',
      1
   );
   insert_seat(
      '4F',
      'window',
      'first',
      't',
      '2023-08-23 05:27:07',
      '2023-08-23 05:27:07',
      9
   );
   insert_seat(
      '7G',
      'window',
      'first',
      'f',
      '2023-01-24 07:50:59',
      '2023-01-24 07:50:59',
      6
   );
   insert_seat(
      '14D',
      'aisle',
      'first',
      't',
      '2023-08-30 13:49:03',
      '2023-08-30 13:49:03',
      5
   );
   insert_seat(
      '7E',
      'middle',
      'business',
      'f',
      '2024-04-26 06:05:51',
      '2024-04-26 06:05:51',
      8
   );
   insert_seat(
      '9C',
      'middle',
      'premium economy',
      't',
      '2023-05-16 22:26:54',
      '2023-05-16 22:26:54',
      7
   );
   insert_seat(
      '10F',
      'aisle',
      'business',
      't',
      '2022-10-22 11:59:11',
      '2022-10-22 11:59:11',
      12
   );
   insert_seat(
      '12B',
      'window',
      'business',
      'f',
      '2023-01-31 13:25:58',
      '2023-01-31 13:25:58',
      11
   );
   insert_seat(
      '2C',
      'window',
      'economy',
      't',
      '2024-10-17 02:02:32',
      '2024-10-17 02:02:32',
      10
   );
   insert_seat(
      '21E',
      'middle',
      'economy',
      't',
      '2024-10-17 02:02:32',
      '2024-10-17 02:02:32',
      2
   );
   insert_seat(
      '2C',
      'window',
      'economy',
      't',
      '2024-10-17 02:02:32',
      '2024-10-17 02:02:32',
      14
   );
   commit;
end;
/
