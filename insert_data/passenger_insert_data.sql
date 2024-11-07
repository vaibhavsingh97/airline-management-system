create or replace procedure insert_passenger (
   passenger_id    in integer,
   pass_first_name in varchar2,
   pass_last_name  in varchar2,
   pass_email      in varchar2,
   pass_phone      in number,
   gender          in varchar2,
   dob             in date,
   seat_preference in varchar2,
   created_at      in date,
   updated_at      in date,
   wallet_id       in varchar2
) is
   v_count number;
begin
    -- Try to delete the existing passenger record if it exists
    -- Check if a record exists with the provided passenger_id
   select count(*)
     into v_count
     from passenger
    where passenger_id = p_passenger_id;

        -- If a record exists, delete it
   if v_count > 0 then
      delete from passenger
       where passenger_id = p_passenger_id;
      commit; -- Commit the deletion
      null;
   end if;

    -- Perform the insertion into the passenger table
   begin
      insert into passenger (
         passenger_id,
         pass_first_name,
         pass_last_name,
         pass_email,
         pass_phone,
         gender,
         dob,
         seat_preference,
         created_at,
         updated_at,
         wallet_id
      ) values ( p_passenger_id,
                 p_pass_first_name,
                 p_pass_last_name,
                 p_pass_email,
                 p_pass_phone,
                 p_gender,
                 p_dob,
                 p_seat_preference,
                 to_date(p_created_at,
                         'DD-MM-YYYY HH24:MI:SS'),
                 to_date(p_updated_at,
                         'DD-MM-YYYY HH24:MI:SS'),
                 p_wallet_id );
      dbms_output.put_line('✅ Successfully inserted passenger with ID: ' || p_passenger_id);
      commit; -- Commit the insertion
   exception
      when others then
            -- If an error occurs during insertion, raise a custom error
         raise_application_error(
            -20001,
            '❌ Failed to insert passenger with ID: ' || p_passenger_id
         );
   end;

end insert_passenger;
/


begin
    -- Inserting data into passenger table
   insert_passenger(
      801,
      'Catina',
      'Mellers',
      'cmellers0@tuttocitta.it',
      '8865882514',
      'female',
      '10-05-1931',
      'aisle',
      '2022-09-23 00:53:23',
      '2022-09-23 00:53:23',
      null
   );
   insert_passenger(
      802,
      'Tabby',
      'Pegg',
      'tpegg1@google.de',
      '5778897044',
      'female',
      '15-05-1957',
      'middle',
      '2023-07-16 03:07:23',
      '2023-07-16 03:07:23',
      502
   );
   insert_passenger(
      803,
      'Kitty',
      'Warlawe',
      'kwarlawe2@ibm.com',
      '9827571789',
      'female',
      '10-01-1989',
      'aisle',
      '2023-03-25 04:11:48',
      '2023-03-25 04:11:48',
      503
   );
   insert_passenger(
      804,
      'Eda',
      'Borham',
      'eborham3@jiathis.com',
      '3082546537',
      'female',
      '31-07-1964',
      'middle',
      '2024-07-02 13:08:56',
      '2024-07-02 13:08:56',
      504
   );
   insert_passenger(
      805,
      'Pennie',
      'Jouandet',
      'pjouandet4@sphinn.com',
      '1877433374',
      'female',
      '08-08-1982',
      'window',
      '2024-06-11 05:39:51',
      '2024-06-11 05:39:51',
      505
   );
   insert_passenger(
      806,
      'Daven',
      'Krollman',
      'dkrollman5@chronoengine.com',
      '2117070929',
      'male',
      '25-08-1996',
      'window',
      '2024-07-03 00:27:07',
      '2024-07-03 00:27:07',
      null
   );
   insert_passenger(
      807,
      'Sigismondo',
      'Marnane',
      'smarnane6@multiply.com',
      '4906837346',
      'male',
      '13-09-2003',
      'window',
      '2023-08-06 00:35:55',
      '2023-08-06 00:35:55',
      507
   );
   insert_passenger(
      808,
      'Jessalyn',
      'Underdown',
      'junderdown7@liveinternet.ru',
      '1091457252',
      'female',
      '03-01-1984',
      'middle',
      '2022-12-21 08:43:43',
      '2022-12-21 08:43:43',
      508
   );
   insert_passenger(
      809,
      'Brucie',
      'Heersema',
      'bheersema8@nhs.uk',
      '2506837379',
      'male',
      '03-12-1943',
      'aisle',
      '2024-04-21 22:05:36',
      '2024-04-21 22:05:36',
      509
   );
   insert_passenger(
      810,
      'Ebeneser',
      'Gravet',
      'egravet9@furl.net',
      '5616473517',
      'male',
      '15-01-1947',
      'aisle',
      '2024-04-10 20:30:02',
      '2024-04-10 20:30:02',
      null
   );
   commit;
end;
/