create or replace procedure insert_route (
   p_route_id            in integer,
   p_origin_airport      in varchar2,
   p_destination_airport in varchar2,
   p_distance            in integer,
   p_created_at          in varchar2,
   p_updated_at          in varchar2
) is
   v_count number;
begin
    -- Try to delete the existing route record if it exists
    -- Check if a record exists with the provided route_id
   select count(*)
     into v_count
     from route
    where route_id = p_route_id;

    -- If a record exists, delete it
   if v_count > 0 then
      delete from route
       where route_id = p_route_id;
      commit; -- Commit the deletion
      null;
   end if;

    -- Perform the insertion into the route table
   begin
      insert into route (
         route_id,
         origin_airport,
         destination_airport,
         distance,
         created_at,
         updated_at
      ) values ( p_route_id,
                 p_origin_airport,
                 p_destination_airport,
                 p_distance,
                 to_date(p_created_at,
                         'YYYY-MM-DD HH24:MI:SS'),
                 to_date(p_updated_at,
                         'YYYY-MM-DD HH24:MI:SS') );
      dbms_output.put_line('✅ Successfully inserted route with ID: ' || p_route_id);
      commit; -- Commit the insertion
   exception
      when others then
            -- If an error occurs during insertion, raise a custom error
         raise_application_error(
            -20001,
            '❌ Failed to insert route with ID: ' || p_route_id
         );
   end;

end insert_route;
/


begin
    -- Inserting data into route table using the procedure
   insert_route(
      201,
      'BOS',
      'ATL',
      2779,
      '2023-01-05 12:15:33',
      '2023-01-05 12:15:33'
   );
   insert_route(
      202,
      'DEN',
      'SFO',
      2528,
      '2023-02-14 08:45:20',
      '2023-02-14 08:45:20'
   );
   insert_route(
      203,
      'DEN',
      'ATL',
      2818,
      '2023-04-28 21:17:55',
      '2023-04-28 21:17:55'
   );
   insert_route(
      204,
      'DEN',
      'BOS',
      1782,
      '2023-06-13 05:38:09',
      '2023-06-13 05:38:09'
   );
   insert_route(
      205,
      'ATL',
      'ORD',
      1094,
      '2023-08-09 16:24:41',
      '2023-08-09 16:24:41'
   );
   insert_route(
      206,
      'ORD',
      'JFK',
      2618,
      '2023-10-03 10:35:20',
      '2023-10-03 10:35:20'
   );
   insert_route(
      207,
      'DFW',
      'LAX',
      2242,
      '2023-11-17 22:50:11',
      '2023-11-17 22:50:11'
   );
   insert_route(
      208,
      'DEN',
      'DFW',
      1868,
      '2024-02-03 06:44:57',
      '2024-02-03 06:44:57'
   );
   insert_route(
      209,
      'MIA',
      'ATL',
      4254,
      '2024-04-21 13:19:32',
      '2024-04-21 13:19:32'
   );
   insert_route(
      210,
      'DFW',
      'MIA',
      1576,
      '2024-06-12 18:56:45',
      '2024-06-12 18:56:45'
   );
   commit;
end;
/