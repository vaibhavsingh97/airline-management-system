/* 
================================================
‼️ THIS FILE SHOULD BE RUN BY APP_ADMIN ONLY ‼️
================================================
*/

declare
   user_exists number;
   
   procedure create_user(username_data varchar2, password varchar2) is
   begin
      -- Check if the user already exists
      select count(*)
        into user_exists
        from all_users
       where lower(username) = lower(username_data);

      -- Drop the user if it exists
      if user_exists > 0 then
         begin
            execute immediate 'DROP USER ' || username_data || ' CASCADE';
            dbms_output.put_line('USER ' || username_data || ' DROPPED SUCCESSFULLY ✅');
         exception
            when others then
               dbms_output.put_line('❌ FAILED TO DROP USER ' || username_data || ':');
               dbms_output.put_line(substr(sqlerrm, 11) || ' (Error Code: ' || sqlcode || ')');
               raise; -- Stop execution if drop fails
         end;
      end if;

      -- Attempt to create the user
      begin
         execute immediate 'CREATE USER ' || username_data || ' IDENTIFIED BY ' || password;
         dbms_output.put_line('USER ' || username_data || ' CREATED SUCCESSFULLY ✅');
         dbms_output.put_line(' ');
      exception
         when others then
            dbms_output.put_line('❌ FAILED TO CREATE USER ' || username_data || ':');
            dbms_output.put_line(substr(sqlerrm, 11) || ' (Error Code: ' || sqlcode || ')');
            raise; -- Stop if user creation fails
      end;
   end;
   
begin
   -- Create users with specified roles
   create_user('DEVELOPER', 'NeuBoston2024#');
   create_user('PASSENGER', 'NeuBoston2024#');
   create_user('FLIGHT_OPERATION_MANAGER', 'NeuBoston2024#');
   create_user('INVENTORY_MANAGER', 'NeuBoston2024#');
   -- create_user('GROUND_OPERATION_MANAGER', 'NeuBoston2024#');
   create_user('CREW_MANAGER', 'NeuBoston2024#');
   create_user('MAINTENANCE_MANAGER', 'NeuBoston2024#');
   create_user('HR_MANAGER', 'NeuBoston2024#');
   create_user('DATA_ANALYST', 'NeuBoston2024#');

   dbms_output.put_line('All users created or updated successfully.');
   
exception
   when others then
      dbms_output.put_line('❌ An error occurred during user creation:');
      dbms_output.put_line(substr(sqlerrm, 11) || ' (Error Code: ' || sqlcode || ')');
end;
