-- to check if user_exists and delete and create user
   SET SERVEROUTPUT ON
/
declare
   user_exists number;
begin
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
declare
   user_exists number;
begin
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
declare
   user_exists number;
begin
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
declare
   user_exists number;
begin
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
declare
   user_exists number;
begin
   select count(*)
     into user_exists
     from all_users
    where username = 'ground_operation_manager';
   if user_exists > 0 then
      execute immediate 'DROP USER ground_operation_manager CASCADE';
      dbms_output.put_line('USER ground_operation_manager DROPPED SUCCESSFULLY');
   end if;
   execute immediate 'CREATE USER ground_operation_manager IDENTIFIED BY NeuBoston2024#';
   dbms_output.put_line('USER ground_operation_manager CREATED SUCCESSFULLY ✅');
exception
   when others then
      dbms_output.put_line('❌ FAILED TO CREATE USER ground_operation_manager:');
      dbms_output.put_line(substr(sqlerrm, 11) || ' (Error Code: ' || sqlcode || ')');
end;
/
declare
   user_exists number;
begin
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
declare
   user_exists number;
begin
   select count(*)
     into user_exists
     from all_users
    where username = 'inventory_manager';
   if user_exists > 0 then
      execute immediate 'DROP USER inventory_manager CASCADE';
      dbms_output.put_line('USER inventory_manager DROPPED SUCCESSFULLY');
   end if;
   execute immediate 'CREATE USER inventory_manager IDENTIFIED BY NeuBoston2024#';
   dbms_output.put_line('USER inventory_manager CREATED SUCCESSFULLY ✅');
exception
   when others then
      dbms_output.put_line('❌ FAILED TO CREATE USER inventory_manager:');
      dbms_output.put_line(substr(sqlerrm, 11) || ' (Error Code: ' || sqlcode || ')');
end;
/
declare
   user_exists number;
begin
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
declare
   user_exists number;
begin
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
