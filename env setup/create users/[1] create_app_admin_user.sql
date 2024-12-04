/* 
================================================
‼️ THIS FILE SHOULD BE RUN BY DBA ADMIN ONLY ‼️
================================================
*/

-- Create App Admin user
SET SERVEROUTPUT ON
/
declare
   user_exists number;
   user_creation_sql varchar2(100);
   user_drop_sql varchar2(100);
   grant_access_sql varchar2(200);
begin
   -- SQL for dropping the user
   user_drop_sql := 'DROP USER app_admin CASCADE';

   -- SQL for creating the user
   user_creation_sql := 'CREATE USER app_admin IDENTIFIED BY NeuBoston2024#';

   grant_access_sql := 'GRANT CONNECT, RESOURCE, SELECT ANY TABLE, CREATE USER, DROP USER, ALTER USER, CREATE ANY VIEW, CREATE ANY PROCEDURE TO app_admin WITH ADMIN OPTION';
   -- Check is users exist
   select count(*)
     into user_exists
     from all_users
    where lower(username) = 'app_admin';

   -- Drop the user if it exists
   if user_exists > 0 then
      begin
         execute immediate user_drop_sql;
         dbms_output.put_line('USER app_admin DROPPED SUCCESSFULLY ✅');
      exception
         when others then
            dbms_output.put_line('❌ FAILED TO DROP USER app_admin:');
            dbms_output.put_line(substr(sqlerrm, 11) || ' (Error Code: ' || sqlcode || ')');
            raise; -- Stop execution if drop fails
      end;
   end if;

      -- Attempt to create the user
   begin
      execute immediate user_creation_sql;
      dbms_output.put_line('USER app_admin CREATED SUCCESSFULLY ✅');
   exception
      when others then
         dbms_output.put_line('❌ FAILED TO CREATE USER app_admin:');
         dbms_output.put_line(substr(sqlerrm, 11) || ' (Error Code: ' || sqlcode || ')');
         raise; -- Stop if user creation fails
   end;

   -- Grant access to the user
   begin
      execute immediate grant_access_sql;
      dbms_output.put_line('Privileges granted to APP_ADMIN successfully. ✅');
   exception
      when others then
         dbms_output.put_line('❌ Failed to grant privileges to app_admin:');
         dbms_output.put_line(substr(sqlerrm, 11) || ' (Error Code: ' || sqlcode || ')');
   end;
end;
/
