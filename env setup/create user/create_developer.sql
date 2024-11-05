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
    where username = 'developer';
   if user_exists > 0 then
      execute immediate 'DROP USER developer CASCADE';
      dbms_output.put_line('USER developer DROPPED SUCCESSFULLY');
   end if;
   execute immediate 'CREATE USER developer IDENTIFIED BY NeuBoston2024#';
   dbms_output.put_line('USER developer CREATED SUCCESSFULLY ✅');
exception
   when others then
      dbms_output.put_line('❌ FAILED TO CREATE USER developer:');
      dbms_output.put_line(substr(sqlerrm, 11) || ' (Error Code: ' || sqlcode || ')');
end;
/
