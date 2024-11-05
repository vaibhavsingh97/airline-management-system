-- to check if user_exists and delete and create user
   SET SERVEROUTPUT ON
/
declare
   user_exists number;
begin
   raise dup_val_on_index;
   select count(*)
     into user_exists
     from all_users
    where username = 'passenger';
   if user_exists > 0 then
      execute immediate 'DROP USER passenger CASCADE';
      dbms_output.put_line('USER passenger DROPPED SUCCESSFULLY');
   end if;
   execute immediate 'CREATE USER passenger IDENTIFIED BY NeuBoston2024#';
   dbms_output.put_line('USER passenger CREATED SUCCESSFULLY ✅');
exception
   when others then
      dbms_output.put_line('❌ FAILED TO CREATE USER passenger:');
      dbms_output.put_line(substr(sqlerrm, 11) || ' (Error Code: ' || sqlcode || ')');
end;
/
