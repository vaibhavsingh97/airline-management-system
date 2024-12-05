CREATE OR REPLACE PROCEDURE kill_all_user_sessions (
    p_username IN VARCHAR2
) IS
    CURSOR c_sessions IS
        SELECT sid, serial#
        FROM v$session
        WHERE username = UPPER(p_username);
    
    v_kill_count NUMBER := 0;
BEGIN
    -- Loop through all sessions for the user
    FOR sess IN c_sessions LOOP
        BEGIN
            -- Kill each session
            EXECUTE IMMEDIATE 'ALTER SYSTEM KILL SESSION ''' || 
                sess.sid || ',' || sess.serial# || ''' IMMEDIATE';
            v_kill_count := v_kill_count + 1;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Failed to kill session [' || 
                    sess.sid || ',' || sess.serial# || ']: ' || SQLERRM);
        END;
    END LOOP;
    
    IF v_kill_count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Killed ' || v_kill_count || 
            ' session(s) for user ' || UPPER(p_username));
    ELSE
        DBMS_OUTPUT.PUT_LINE('No active sessions found for user ' || 
            UPPER(p_username));
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/

-- Execute example:
BEGIN
    kill_all_user_sessions('app_admin');
    kill_all_user_sessions('developer');
    kill_all_user_sessions('passenger');
    kill_all_user_sessions('flight_operation_manager');
    kill_all_user_sessions('inventory_manager');
    -- kill_all_user_sessions('ground_operation_manager');
    kill_all_user_sessions('crew_manager');
    kill_all_user_sessions('maintenance_manager');
    kill_all_user_sessions('hr_manager');
    kill_all_user_sessions('data_analyst');
END;
/
