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
    where username = 'crew_manager';
   if user_exists > 0 then
      execute immediate 'DROP USER crew_manager CASCADE';
      dbms_output.put_line('USER crew_manager DROPPED SUCCESSFULLY');
   end if;
   execute immediate 'CREATE USER crew_manager IDENTIFIED BY NeuBoston2024#';
   dbms_output.put_line('USER crew_manager CREATED SUCCESSFULLY ✅');
exception
   when others then
      dbms_output.put_line('❌ FAILED TO CREATE USER crew_manager:');
      dbms_output.put_line(substr(sqlerrm, 11) || ' (Error Code: ' || sqlcode || ')');
end;
/
