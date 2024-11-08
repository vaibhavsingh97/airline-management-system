SET SERVEROUTPUT ON;

create or replace procedure insert_flight_schedule (
   p_flight_schedule_id in integer,
   p_departure_airport  in varchar2,
   p_scheduled_dep_time in varchar2,
   p_actual_dep_time    in varchar2,
   p_arrival_airport    in varchar2,
   p_scheduled_arr_time in varchar2,
   p_actual_arr_time    in varchar2,
   p_flight_status      in varchar2,
   p_created_at         in varchar2,
   p_updated_at         in varchar2,
   p_aircraft_id        in integer,
   p_route_id           in integer
) is
   v_count number;
begin
   -- Check if a record exists with the provided flight_schedule_id
   select count(*)
     into v_count
     from flight_schedule
    where flight_schedule_id = p_flight_schedule_id;

   -- If a record exists, update it
   if v_count > 0 then
      update flight_schedule
         set departure_airport = p_departure_airport,
             scheduled_dep_time = to_date(p_scheduled_dep_time, 'YYYY-MM-DD HH24:MI:SS'),
             actual_dep_time = to_date(p_actual_dep_time, 'YYYY-MM-DD HH24:MI:SS'),
             arrival_airport = p_arrival_airport,
             scheduled_arr_time = to_date(p_scheduled_arr_time, 'YYYY-MM-DD HH24:MI:SS'),
             actual_arr_time = to_date(p_actual_arr_time, 'YYYY-MM-DD HH24:MI:SS'),
             flight_status = p_flight_status,
             updated_at = to_date(p_updated_at, 'YYYY-MM-DD HH24:MI:SS'),
             aircraft_aircraft_id = p_aircraft_id,
             routes_route_id = p_route_id
       where flight_schedule_id = p_flight_schedule_id;
      
      dbms_output.put_line('✅ Successfully updated flight schedule with ID: ' || p_flight_schedule_id);
      commit; -- Commit the update
   else
      -- If the record doesn't exist, perform the insertion
      begin
         insert into flight_schedule (
            flight_schedule_id,
            departure_airport,
            scheduled_dep_time,
            actual_dep_time,
            arrival_airport,
            scheduled_arr_time,
            actual_arr_time,
            flight_status,
            created_at,
            updated_at,
            aircraft_aircraft_id,
            routes_route_id
         ) values ( 
            p_flight_schedule_id,
            p_departure_airport,
            to_date(p_scheduled_dep_time, 'YYYY-MM-DD HH24:MI:SS'),
            to_date(p_actual_dep_time, 'YYYY-MM-DD HH24:MI:SS'),
            p_arrival_airport,
            to_date(p_scheduled_arr_time, 'YYYY-MM-DD HH24:MI:SS'),
            to_date(p_actual_arr_time, 'YYYY-MM-DD HH24:MI:SS'),
            p_flight_status,
            to_date(p_created_at, 'YYYY-MM-DD HH24:MI:SS'),
            to_date(p_updated_at, 'YYYY-MM-DD HH24:MI:SS'),
            p_aircraft_id,
            p_route_id 
         );
         dbms_output.put_line('✅ Successfully inserted flight schedule with ID: ' || p_flight_schedule_id);
         commit; -- Commit the insertion
      exception
         when others then
            -- If an error occurs during insertion, raise a custom error
            dbms_output.put_line('Error Code: ' || SQLCODE);
            dbms_output.put_line('Error Message: ' || SQLERRM);
            raise_application_error(
               -20001,
               '❌ Failed to insert flight schedule with ID: ' || p_flight_schedule_id
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
         '❌ Failed to process flight schedule with ID: ' || p_flight_schedule_id
      );
end insert_flight_schedule;
/

begin
    -- Inserting data into flight_schedule table
   insert_flight_schedule(
      1001,
      'DEN',
      '2024-02-15 23:17:22',
      '2024-02-15 23:17:22',
      'BOS',
      '2024-08-02 07:40:52',
      '2024-08-02 07:40:52',
      'scheduled',
      '2024-10-16 15:19:23',
      '2024-10-16 15:19:23',
      109,
      204
   );
   insert_flight_schedule(
      1002,
      'MIA',
      '2023-12-21 02:30:21',
      '2023-12-21 02:30:21',
      'ATL',
      '2024-06-23 05:41:31',
      '2024-06-23 05:41:31',
      'ontime',
      '2024-09-01 07:51:24',
      '2024-09-01 07:51:24',
      102,
      209
   );
   insert_flight_schedule(
      1003,
      'BOS',
      '2024-07-10 19:58:24',
      '2024-07-10 19:58:24',
      'ATL',
      '2024-02-22 06:41:00',
      '2024-02-22 06:41:00',
      'ontime',
      '2024-03-15 22:43:51',
      '2024-03-15 22:43:51',
      108,
      201
   );
   insert_flight_schedule(
      1004,
      'BOS',
      '2024-11-23 13:37:32',
      '2024-11-23 13:37:32',
      'ATL',
      '2024-11-30 06:56:53',
      '2024-11-30 06:56:53',
      'scheduled',
      '2024-04-04 22:14:15',
      '2024-04-04 22:14:15',
      106,
      201
   );
   insert_flight_schedule(
      1005,
      'DEN',
      '2024-08-12 13:36:46',
      '2024-08-12 13:36:46',
      'DFW',
      '2024-08-25 00:54:45',
      '2024-08-25 00:54:45',
      'ontime',
      '2024-09-13 08:38:04',
      '2024-09-13 08:38:04',
      107,
      208
   );
   insert_flight_schedule(
      1006,
      'ATL',
      '2024-10-25 07:28:22',
      '2024-10-25 07:28:22',
      'ORD',
      '2024-04-01 06:49:29',
      '2024-04-01 06:49:29',
      'ontime',
      '2024-01-20 04:42:44',
      '2024-01-20 04:42:44',
      109,
      205
   );
   insert_flight_schedule(
      1007,
      'ATL',
      '2024-10-30 07:28:08',
      '2024-10-30 07:28:08',
      'ORD',
      '2024-07-27 14:59:25',
      '2024-07-27 14:59:25',
      'scheduled',
      '2024-02-10 04:49:24',
      '2024-02-10 04:49:24',
      110,
      205
   );
   insert_flight_schedule(
      1008,
      'DEN',
      '2024-04-05 17:43:01',
      '2024-04-05 17:43:01',
      'ATL',
      '2024-05-31 23:42:09',
      '2024-05-31 23:42:09',
      'cancelled',
      '2024-09-09 14:25:08',
      '2024-09-09 14:25:08',
      110,
      203
   );
   insert_flight_schedule(
      1009,
      'BOS',
      '2024-04-27 12:55:37',
      '2024-04-27 12:55:37',
      'ATL',
      '2024-05-15 01:40:19',
      '2024-05-15 01:40:19',
      'ontime',
      '2024-05-15 14:18:51',
      '2024-05-15 14:18:51',
      105,
      201
   );
   insert_flight_schedule(
      1010,
      'ATL',
      '2024-09-20 10:11:27',
      '2024-09-20 10:11:27',
      'ORD',
      '2024-12-10 21:44:20',
      '2024-12-10 21:44:20',
      'ontime',
      '2024-07-29 15:36:22',
      '2024-07-29 15:36:22',
      108,
      205
   );

   commit;
end;
/