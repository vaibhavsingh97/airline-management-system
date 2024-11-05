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
    where username = 'flight_operation_manager';
   if user_exists > 0 then
      execute immediate 'DROP USER flight_operation_manager CASCADE';
      dbms_output.put_line('USER flight_operation_manager DROPPED SUCCESSFULLY');
   end if;
   execute immediate 'CREATE USER flight_operation_manager IDENTIFIED BY NeuBoston2024#';
   dbms_output.put_line('USER flight_operation_manager CREATED SUCCESSFULLY ✅');
exception
   when others then
      dbms_output.put_line('❌ FAILED TO CREATE USER flight_operation_manager:');
      dbms_output.put_line(substr(sqlerrm, 11) || ' (Error Code: ' || sqlcode || ')');
end;
/
