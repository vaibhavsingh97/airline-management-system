/*
================================================
‼️ THIS FILE SHOULD BE RUN BY APP_ADMIN ONLY ‼️
================================================
*/

declare
   unlimted_storage_sql varchar2(100);
begin
   unlimted_storage_sql := 'ALTER USER DEVELOPER QUOTA UNLIMITED ON DATA';
   execute immediate unlimted_storage_sql;
   grant_access_to_user('DEVELOPER', 'CONNECT, RESOURCE', null);
   dbms_output.put_line('User DEVELOPER granted access successfully. ✅');
exception
   when others then
      dbms_output.put_line('❌ Failed to grant access to user DEVELOPER:');
      dbms_output.put_line(substr(sqlerrm, 11) || ' (Error Code: ' || sqlcode || ')');
      raise; -- Stop execution if grant fails
end;
/
