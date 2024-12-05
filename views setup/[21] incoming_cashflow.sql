/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/
 
SET SERVEROUTPUT ON;
 
DECLARE
    view_exists NUMBER;
BEGIN
    -- Check if the view exists
    SELECT COUNT(*)
    INTO view_exists
    FROM user_views
    WHERE view_name = 'INCOMING_CASHFLOW';
 
    -- Drop the view if it exists
    IF view_exists > 0 THEN
        EXECUTE IMMEDIATE 'DROP VIEW Incoming_Cashflow';
        DBMS_OUTPUT.PUT_LINE('View Incoming_Cashflow DROPPED SUCCESSFULLY ✅');
    END IF;
 
    -- Create the view
    EXECUTE IMMEDIATE '
        CREATE OR REPLACE VIEW Incoming_Cashflow AS
        WITH payment_data AS (
            SELECT
                payment_amount,
                payment_date,
                TRUNC(payment_date, ''IW'') AS week_start,
                TRUNC(payment_date, ''MM'') AS month_start,
                TRUNC(payment_date, ''Q'') AS quarter_start
            FROM payment
        )
        SELECT
            ''Weekly'' AS time_period,
            week_start AS period_start,
            week_start + 6 AS period_end,
            SUM(payment_amount) AS total_cashflow
        FROM payment_data
        GROUP BY week_start
 
        UNION ALL
 
        SELECT
            ''Monthly'' AS time_period,
            month_start AS period_start,
            LAST_DAY(month_start) AS period_end,
            SUM(payment_amount) AS total_cashflow
        FROM payment_data
        GROUP BY month_start
 
        UNION ALL
 
        SELECT
            ''Quarterly'' AS time_period,
            quarter_start AS period_start,
            ADD_MONTHS(quarter_start, 3) - 1 AS period_end,
            SUM(payment_amount) AS total_cashflow
        FROM payment_data
        GROUP BY quarter_start
 
        ORDER BY time_period, period_start';
 
    DBMS_OUTPUT.PUT_LINE('View Incoming_Cashflow CREATED SUCCESSFULLY ✅');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('FAILED TO CREATE VIEW Incoming_Cashflow ❌');
END;
/