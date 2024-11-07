   SET SERVEROUTPUT ON;


create or replace procedure insert_aircraft (
   p_aircraft_id      in number,
   p_aircraft_name    in varchar2,
   p_aircraft_model   in varchar2,
   p_seating_capacity in number,
   p_fuel_capacity    in number,
   p_created_at       in varchar2,
   p_updated_at       in varchar2
) is
   v_count number;
begin
    -- Try to delete the existing aircraft record if it exists
    -- Check if a record exists with the provided aircraft_id
   select count(*)
     into v_count
     from aircraft
    where aircraft_id = p_aircraft_id;

    -- If a record exists, delete it
   if v_count > 0 then
      delete from aircraft
       where aircraft_id = p_aircraft_id;
      commit; -- Commit the deletion
      null;
   end if;

    -- Perform the insertion into the aircraft table
   begin
      insert into aircraft (
         aircraft_id,
         aircraft_name,
         aircraft_model,
         seating_capacity,
         fuel_capacity,
         created_at,
         updated_at
      ) values ( p_aircraft_id,
                 p_aircraft_name,
                 p_aircraft_model,
                 p_seating_capacity,
                 p_fuel_capacity,
                 to_date(p_created_at,
                         'DD-MM-YYYY HH24:MI:SS'),
                 to_date(p_updated_at,
                         'DD-MM-YYYY HH24:MI:SS') );
      dbms_output.put_line('✅ Successfully inserted aircraft with ID: ' || p_aircraft_id);
      commit; -- Commit the insertion
    -- Raise an exception if the insert fails (e.g., due to duplicate or any other issue)
   exception
      when others then
         dbms_output.put_line('Error Code: ' || sqlcode);
         dbms_output.put_line('Error Message: ' || sqlerrm);
            -- If an error occurs during insertion, raise a custom error
         raise_application_error(
            -20004,
            '❌ Failed to insert aircraft with ID: ' || p_aircraft_id
         );
   end;

end insert_aircraft;
/


begin
    -- Inserting data into aircraft table using the procedure
   insert_aircraft(
      101,
      'Boeing 747',
      '747',
      114,
      24429,
      '18-09-2023 10:23:45',
      '18-09-2023 10:23:45'
   );
   insert_aircraft(
      102,
      'Airbus A380',
      'A380',
      180,
      17833,
      '24-09-2023 15:45:12',
      '24-09-2023 15:45:12'
   );
   insert_aircraft(
      103,
      'Boeing 737',
      '737',
      173,
      47631,
      '03-10-2023 09:12:01',
      '03-10-2023 09:12:01'
   );
   insert_aircraft(
      104,
      'Airbus A320',
      'A320',
      311,
      1690,
      '11-10-2023 22:08:30',
      '11-10-2023 22:08:30'
   );
   insert_aircraft(
      105,
      'Boeing 787 Dreamliner',
      '787',
      25,
      25656,
      '19-10-2023 14:37:50',
      '19-10-2023 14:37:50'
   );
   insert_aircraft(
      106,
      'Airbus A350',
      'A350',
      200,
      41818,
      '27-10-2023 08:56:10',
      '27-10-2023 08:56:10'
   );
   insert_aircraft(
      107,
      'Embraer E190',
      'E190',
      397,
      38087,
      '06-11-2023 12:20:55',
      '06-11-2023 12:20:55'
   );
   insert_aircraft(
      108,
      'Bombardier CRJ900',
      'CRJ900',
      40,
      22015,
      '15-01-2024 20:31:15',
      '15-01-2024 20:31:15'
   );
   insert_aircraft(
      109,
      'Boeing 777',
      '777',
      351,
      25374,
      '22-03-2024 18:19:45',
      '22-03-2024 18:19:45'
   );
   insert_aircraft(
      110,
      'Airbus A330',
      'A330',
      273,
      22488,
      '30-05-2024 04:45:35',
      '30-05-2024 04:45:35'
   );
   commit;
end;
/