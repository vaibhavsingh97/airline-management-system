/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/

DECLARE
    v_wallet_exists NUMBER;
    v_view_exists NUMBER;
BEGIN
    -- Check if the 'wallet' table exists
    SELECT COUNT(*)
    INTO v_wallet_exists
    FROM all_tables
    WHERE table_name = 'WALLET' and owner = 'DEVELOPER';
 
    -- Check if the view already exists
    SELECT COUNT(*)
    INTO v_view_exists
    FROM all_views
    WHERE view_name = 'MOST_WALLET_POINTS_REDEEMED' and owner = 'DEVELOPER';
 
    -- Only proceed if the wallet table exists
    IF v_wallet_exists > 0 THEN
        -- If the view exists, drop it
        IF v_view_exists > 0 THEN
            EXECUTE IMMEDIATE 'DROP VIEW Most_Wallet_Points_Redeemed';
            DBMS_OUTPUT.PUT_LINE('Existing view Most_Wallet_Points_Redeemed dropped.');
        END IF;
 
        -- Create the new view
        EXECUTE IMMEDIATE 'CREATE VIEW developer.Most_Wallet_Points_Redeemed AS
            SELECT
                DENSE_RANK() OVER (ORDER BY MAX(wt.points_redeemed) DESC) AS rank,
                pass.passenger_id,
                MAX(wt.points_redeemed) AS max_points_redeemed
            FROM
                developer.passenger pass
            JOIN
                developer.wallet wt
            ON
                wt.passenger_passenger_id = pass.passenger_id
            GROUP BY
                pass.passenger_id
            ORDER BY
                rank';
 
        DBMS_OUTPUT.PUT_LINE('View Most_Wallet_Points_Redeemed created successfully.');
    ELSE
        -- Display a message if the table does not exist
        DBMS_OUTPUT.PUT_LINE('Required table wallet does not exist. View creation aborted.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error creating view Most_Wallet_Points_Redeemed ');
END;
