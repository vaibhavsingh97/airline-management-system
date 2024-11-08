SET SERVEROUTPUT ON;

create or replace procedure insert_seat (
   p_seat_id            in number,
   p_seat_type          in varchar2,
   p_seat_class         in varchar2,
   p_is_available       in char,
   p_created_at         in varchar2,
   p_updated_at         in varchar2,
   p_flight_schedule_id in number
) is
   v_count number;
begin
   -- Check if a record exists with the provided seat_id
   select count(*)
     into v_count
     from seat
    where seat_id = p_seat_id;

   -- If a record exists, update it
   if v_count > 0 then
      update seat
         set seat_type = p_seat_type,
             seat_class = p_seat_class,
             is_available = p_is_available,
             updated_at = to_date(p_updated_at, 'YYYY-MM-DD HH24:MI:SS'),
             fs_flight_schedule_id = p_flight_schedule_id
       where seat_id = p_seat_id;
      
      dbms_output.put_line('✅ Successfully updated seat with ID: ' || p_seat_id);
      commit; -- Commit the update
   else
      -- If the record doesn't exist, perform the insertion
      begin
         insert into seat (
            seat_id,
            seat_type,
            seat_class,
            is_available,
            created_at,
            updated_at,
            fs_flight_schedule_id
         ) values ( 
            p_seat_id,
            p_seat_type,
            p_seat_class,
            p_is_available,
            to_date(p_created_at, 'YYYY-MM-DD HH24:MI:SS'),
            to_date(p_updated_at, 'YYYY-MM-DD HH24:MI:SS'),
            p_flight_schedule_id 
         );
         dbms_output.put_line('✅ Successfully inserted seat with ID: ' || p_seat_id);
         commit; -- Commit the insertion
      exception
         when others then
            -- If an error occurs during insertion, raise a custom error
            dbms_output.put_line('Error Code: ' || SQLCODE);
            dbms_output.put_line('Error Message: ' || SQLERRM);
            raise_application_error(
               -20001,
               '❌ Failed to insert seat with ID: ' || p_seat_id
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
         '❌ Failed to process seat with ID: ' || p_seat_id
      );
end insert_seat;
/

begin
    -- Inserting data into seat table
   insert_seat(
      1101,
      'middle',
      'first',
      't',
      '2023-10-15 23:07:31',
      '2023-10-15 23:07:31',
      1004
   );
   insert_seat(
      1102,
      'window',
      'economy',
      'f',
      '2023-06-30 12:54:22',
      '2023-06-30 12:54:22',
      1010
   );
   insert_seat(
      1103,
      'window',
      'first',
      't',
      '2023-08-23 05:27:07',
      '2023-08-23 05:27:07',
      1010
   );
   insert_seat(
      1104,
      'window',
      'first',
      'f',
      '2023-01-24 07:50:59',
      '2023-01-24 07:50:59',
      1007
   );
   insert_seat(
      1105,
      'aisle',
      'first',
      't',
      '2023-08-30 13:49:03',
      '2023-08-30 13:49:03',
      1001
   );
   insert_seat(
      1106,
      'middle',
      'business',
      'f',
      '2024-04-26 06:05:51',
      '2024-04-26 06:05:51',
      1007
   );
   insert_seat(
      1107,
      'middle',
      'premium economy',
      't',
      '2023-05-16 22:26:54',
      '2023-05-16 22:26:54',
      1003
   );
   insert_seat(
      1108,
      'aisle',
      'business',
      't',
      '2022-10-22 11:59:11',
      '2022-10-22 11:59:11',
      1002
   );
   insert_seat(
      1109,
      'window',
      'business',
      'f',
      '2023-01-31 13:25:58',
      '2023-01-31 13:25:58',
      1005
   );
   insert_seat(
      1110,
      'window',
      'economy',
      't',
      '2024-10-17 02:02:32',
      '2024-10-17 02:02:32',
      1008
   );
   commit;
end;
/