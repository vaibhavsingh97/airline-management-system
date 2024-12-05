/*
================================================
‼️ THIS FILE SHOULD BE RUN BY Passenger ONLY ‼️
================================================
*/
alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
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
   -- register_user('John', 'Doe', 'johndoe@example.com', '9892784657', 'male', '01-01-1990', 'window');
   -- Jane will cancel flight within 24 hours
   register_user('Jane', 'Doe', 'janedoe@example.com', '9823783873', 'female', '01-01-1992', 'aisle');
   -- -- Alice will cancel flight after 24 hours
   -- register_user('Alice', 'Smith', 'alicesmith@example.com', '9878675645', 'female', '01-01-1995', 'middle');

   -- register_user('Charlie', 'White', 'charliewhite@example.com', '9754567654', 'male', '01-01-2000', 'aisle');
   register_user('David1', 'Black1', 'davidblack1@example.com', '7656567676', 'male', '03-02-2003', 'middle');
   -- Bob will not get seat
   --register_user('Bob', 'Brown', 'bobrown@example.com', '9876545656', 'male', '01-01-1998', 'window'); -- Case 1.2
   COMMIT;
end;
/
