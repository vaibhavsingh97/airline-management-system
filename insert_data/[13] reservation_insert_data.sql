SET SERVEROUTPUT ON;

create or replace procedure insert_reservation (
   p_reservation_id       in number,
   p_travel_date          in varchar2,
   p_reservation_status   in varchar2,
   p_airfare              in number,
   p_seat_number          in varchar2,
   p_pnr                  in varchar2,
   p_start_date           in varchar2,
   p_end_date             in varchar2,
   p_created_at           in varchar2,
   p_updated_at           in varchar2,
   p_passenger_id         in number,
   p_seat_id              in number
) is
   v_count number;
begin
   -- Check if a record exists with the provided reservation_id
   select count(*)
     into v_count
     from reservation
    where reservation_id = p_reservation_id;

   -- If a record exists, update it
   if v_count > 0 then
      update reservation
         set travel_date = to_date(p_travel_date, 'DD-MM-YYYY'),
             reservation_status = p_reservation_status,
             airfare = p_airfare,
             seat_number = p_seat_number,
             pnr = p_pnr,
             start_date = to_date(p_start_date, 'YYYY-MM-DD HH24:MI:SS'),
             end_date = to_date(p_end_date, 'YYYY-MM-DD HH24:MI:SS'),
             updated_at = to_date(p_updated_at, 'YYYY-MM-DD HH24:MI:SS'),
             passenger_passenger_id = p_passenger_id,
             seat_seat_id = p_seat_id
       where reservation_id = p_reservation_id;
      
      dbms_output.put_line('✅ Successfully updated reservation with ID: ' || p_reservation_id);
      commit; -- Commit the update
   else
      -- If the record doesn't exist, perform the insertion
      begin
         insert into reservation (
            reservation_id,
            travel_date,
            reservation_status,
            airfare,
            seat_number,
            pnr,
            start_date,
            end_date,
            created_at,
            updated_at,
            passenger_passenger_id,
            seat_seat_id
         ) values (
            p_reservation_id,
            to_date(p_travel_date, 'DD-MM-YYYY'),
            p_reservation_status,
            p_airfare,
            p_seat_number,
            p_pnr,
            to_date(p_start_date, 'YYYY-MM-DD HH24:MI:SS'),
            to_date(p_end_date, 'YYYY-MM-DD HH24:MI:SS'),
            to_date(p_created_at, 'YYYY-MM-DD HH24:MI:SS'),
            to_date(p_updated_at, 'YYYY-MM-DD HH24:MI:SS'),
            p_passenger_id,
            p_seat_id
         );
         dbms_output.put_line('✅ Successfully inserted reservation with ID: ' || p_reservation_id);
         commit; -- Commit the insertion
      exception
         when others then
            dbms_output.put_line('Error Code: ' || sqlcode);
            dbms_output.put_line('Error Message: ' || sqlerrm);
            -- If an error occurs during insertion, raise a custom error
            raise_application_error(
               -20005,
               '❌ Failed to insert reservation with ID: ' || p_reservation_id
            );
      end;
   end if;
exception
   when others then
      -- If an error occurs during the procedure execution, raise a custom error
      dbms_output.put_line('Error Code: ' || sqlcode);
      dbms_output.put_line('Error Message: ' || sqlerrm);
      raise_application_error(
         -20006,
         '❌ Failed to process reservation with ID: ' || p_reservation_id
      );
end insert_reservation;
/

begin
   -- Inserting data into reservation table using the procedure
   insert_reservation(1401, '11-02-2025', 'cancelled', 8890.22, '91I', 'TDW290', '2024-04-01 07:08:24', '2024-04-04 07:08:24', '2024-04-01 07:08:24', '2024-04-01 07:08:24', 804, 1103);
   insert_reservation(1402, '23-10-2024', 'confirmed', 9860.92, '83G', 'MVJ441', '2024-10-04 22:12:48', '2024-10-07 22:12:48', '2024-10-04 22:12:48', '2024-10-04 22:12:48', 810, 1104);
   insert_reservation(1403, '12-05-2024', 'cancelled', 8766.91, '84Q', 'UGE527', '2023-08-18 15:08:47', '2023-08-21 15:08:47', '2023-08-18 15:08:47', '2023-08-18 15:08:47', 801, 1109);
   insert_reservation(1404, '07-11-2024', 'confirmed', 9101.44, '94N', 'DDB146', '2023-01-19 13:29:10', '2023-01-22 13:29:10', '2023-01-19 13:29:10', '2023-01-19 13:29:10', 802, 1107);
   insert_reservation(1405, '16-05-2025', 'confirmed', 8085.09, '18L', 'KLM472', '2024-02-23 02:54:29', '2024-02-26 02:54:29', '2024-02-23 02:54:29', '2024-02-23 02:54:29', 808, 1109);
   insert_reservation(1406, '14-02-2025', 'confirmed', 7033.23, '77O', 'OGX792', '2024-08-12 16:06:40', '2024-08-15 16:06:40', '2024-08-12 16:06:40', '2024-08-12 16:06:40', 803, 1102);
   insert_reservation(1407, '06-07-2025', 'cancelled', 9884.95, '73B', 'KPF789', '2023-10-21 13:30:34', '2023-10-24 13:30:34', '2023-10-21 13:30:34', '2023-10-21 13:30:34', 805, 1102);
   insert_reservation(1408, '04-04-2025', 'confirmed', 1628.37, '72U', 'BKU141', '2024-08-28 10:59:50', '2024-08-31 10:59:50', '2024-08-28 10:59:50', '2024-08-28 10:59:50', 807, 1109);
   insert_reservation(1409, '17-01-2025', 'cancelled', 1303.54, '13Z', 'DYY833', '2023-06-25 13:41:39', '2023-06-28 13:41:39', '2023-06-25 13:41:39', '2023-06-25 13:41:39', 808, 1105);
   insert_reservation(1410, '10-12-2025', 'confirmed', 7970.6, '42S', 'XNT661', '2023-03-21 03:31:59', '2023-03-24 03:31:59', '2023-03-21 03:31:59', '2023-03-21 03:31:59', 803, 1102);
   commit;
end;
/