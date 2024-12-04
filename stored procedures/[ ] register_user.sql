/*
================================================
‼️ THIS FILE SHOULD BE RUN BY Passenger ONLY ‼️
================================================
*/
create or replace procedure register_user (
   first_name      in varchar2,
   last_name       in varchar2,
   email           in varchar2,
   phone           in number,
   gender          in varchar2,
   dob             in varchar2,
   seat_preference in varchar2
) as
begin
   developer.insert_passenger(
      first_name,
      last_name,
      email,
      phone,
      gender,
      dob,
      seat_preference,
      sysdate,
      sysdate
   );
   commit;
   dbms_output.put_line('User ' || first_name || ' registered successfully. ✅');
exception
   when others then
      dbms_output.put_line('❌ Failed to register user ' || first_name);
      raise; -- Stop execution if registration fails
end;
/

begin
   register_user('John', 'Doe', 'johndoe@example.com', '9892784657', 'male', '01-01-1990', 'window');
   COMMIT;
end;
/
