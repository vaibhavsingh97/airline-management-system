/*
================================================
‼️ THIS FILE SHOULD BE RUN BY APP_ADMIN (1) / DEVELOPER (2) ONLY ‼️
================================================
*/

create or replace procedure grant_access_to_user (username in varchar2, privileges in VARCHAR2, table_name in varchar2) as
begin
    if table_name is null then
        execute immediate 'grant ' || grant_access_to_user.privileges || ' to ' || grant_access_to_user.username;
    else
        execute immediate 'grant ' || grant_access_to_user.privileges || ' on ' || 'DEVELOPER' || '.' || grant_access_to_user.table_name || ' to ' || grant_access_to_user.username;
    end if;
    
    dbms_output.put_line('Privileges granted to ' || grant_access_to_user.username || ' successfully. ✅');
exception
    when others then
        dbms_output.put_line('❌ Failed to grant privileges to ' || grant_access_to_user.username || ':');
        dbms_output.put_line(substr(sqlerrm, 11) || ' (Error Code: ' || sqlcode || ')');
end;
