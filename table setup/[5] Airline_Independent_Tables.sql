/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/

-- Aircraft table
SET SERVEROUTPUT ON

DECLARE
   TABLE_EXISTS NUMBER;
BEGIN
    -- Check if the table exists
    SELECT COUNT(*) 
    INTO TABLE_EXISTS
    FROM USER_TABLES
    WHERE LOWER(TABLE_NAME) = 'aircraft';
    
     -- Drop table if it exists
    IF TABLE_EXISTS > 0 THEN
        BEGIN 
            EXECUTE IMMEDIATE 'DROP TABLE aircraft CASCADE constraints';
            DBMS_OUTPUT.PUT_LINE('Table aircraft DROPPED SUCCESSFULLY ✅');
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('FAILED TO DROP TABLE aircarft ❌');
        END;
    END IF;

    -- create the table
BEGIN
    EXECUTE IMMEDIATE '
        CREATE TABLE aircraft (
            aircraft_id      INTEGER NOT NULL,
            aircraft_name    VARCHAR2(30) NOT NULL,
            aircraft_model   VARCHAR2(30) NOT NULL,
            seating_capacity INTEGER NOT NULL,
            fuel_capacity    INTEGER NOT NULL,
            created_at       DATE NOT NULL,
            updated_at       DATE NOT NULL
        )';
 
 DBMS_OUTPUT.PUT_LINE('Table aircraft CREATED SUCCESSFULLY ✅');

-- Add primary key constraint
    EXECUTE IMMEDIATE 'ALTER TABLE aircraft ADD CONSTRAINT aircraft_pk PRIMARY KEY (aircraft_id)';
        DBMS_OUTPUT.PUT_LINE('Primary key constraint aircraft_pk added successfully ✅');
    
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('FAILED TO CREATE TABLE aircraft or add primary key ❌');
    END;
END;

-- Route Table
/
DECLARE
   TABLE_EXISTS NUMBER;
BEGIN
    -- Check if the table exists
    SELECT COUNT(*) 
    INTO TABLE_EXISTS
    FROM USER_TABLES
    WHERE LOWER(TABLE_NAME) = 'route';
    
    -- Drop table if it exists
    IF TABLE_EXISTS > 0 THEN
        BEGIN 
            EXECUTE IMMEDIATE 'DROP TABLE route CASCADE constraints';
            DBMS_OUTPUT.PUT_LINE('Table route DROPPED SUCCESSFULLY ✅');
        EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('FAILED TO DROP TABLE route ❌');
        END;
    END IF;
    -- Create the table
    BEGIN
        EXECUTE IMMEDIATE '
            CREATE TABLE route (
            route_id            INTEGER NOT NULL,
            origin_airport      VARCHAR2(30) NOT NULL,
            destination_airport VARCHAR2(30) NOT NULL,
            distance            INTEGER NOT NULL,
            created_at          DATE NOT NULL,
            updated_at          DATE NOT NULL
        )';
    DBMS_OUTPUT.PUT_LINE('Table route CREATED SUCCESSFULLY ✅');

-- Add primary key constraint
        EXECUTE IMMEDIATE 'ALTER TABLE route ADD CONSTRAINT route_pk PRIMARY KEY ( route_id )';
            DBMS_OUTPUT.PUT_LINE('Primary key constraint route_pk added successfully ✅');
    
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('FAILED TO CREATE TABLE route or add primary key ❌');
    END;
END;


-- Maintenance Schedule Table

/
DECLARE
   TABLE_EXISTS NUMBER;
BEGIN
    -- Check if the table exists
    SELECT COUNT(*) 
    INTO TABLE_EXISTS
    FROM USER_TABLES
    WHERE LOWER(TABLE_NAME) = 'maintenance_schedule';
    

   -- Drop table if it exists
    IF TABLE_EXISTS > 0 THEN
        BEGIN 
            EXECUTE IMMEDIATE 'DROP TABLE maintenance_schedule CASCADE constraints';
            DBMS_OUTPUT.PUT_LINE('Table maintenance_schedule DROPPED SUCCESSFULLY ✅');
        EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('FAILED TO DROP TABLE maintenance_schedule ❌');
        END;
    END IF;
    
    -- Create the table
    BEGIN
        EXECUTE IMMEDIATE '
            CREATE TABLE maintenance_schedule (
                main_schedule_id INTEGER NOT NULL,
                main_type        VARCHAR2(20) CHECK (main_type IN (''scheduled'', ''unscheduled'', ''emergency'', ''inspection'')) NOT NULL ,
                schedule_date    DATE NOT NULL,
                created_at       DATE NOT NULL,
                updated_at       DATE NOT NULL
            )';
    DBMS_OUTPUT.PUT_LINE('Table aircraft CREATED SUCCESSFULLY ✅');

    -- Add primary key constraint
        EXECUTE IMMEDIATE 'ALTER TABLE maintenance_schedule ADD CONSTRAINT ms_pk PRIMARY KEY ( main_schedule_id )';
            DBMS_OUTPUT.PUT_LINE('Primary key constraint ms_pk added successfully ✅');
    
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('FAILED TO CREATE TABLE maintenance_schedule or add primary key ❌');
    END;

END;




-- Inventory Table

/
DECLARE
   TABLE_EXISTS NUMBER;
BEGIN
    -- Check if the table exists
    SELECT COUNT(*) 
    INTO TABLE_EXISTS
    FROM USER_TABLES
    WHERE LOWER(TABLE_NAME) = 'inventory';

    -- Drop table if it exists
    IF TABLE_EXISTS > 0 THEN
        BEGIN 
            EXECUTE IMMEDIATE 'DROP TABLE inventory CASCADE constraints';
            DBMS_OUTPUT.PUT_LINE('Table inventory DROPPED SUCCESSFULLY ✅');
        EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('FAILED TO DROP TABLE inventory ❌');
        END;
    END IF;

     -- Create the table
    BEGIN
        EXECUTE IMMEDIATE '
            CREATE TABLE inventory (
                inventory_id      INTEGER NOT NULL,
                item_name         VARCHAR2(30) NOT NULL,
                item_category     VARCHAR2(15) CHECK (item_category IN (''catering'', ''cleaning'', ''spare'', ''tools'')) NOT NULL,
                quantity_in_hand  INTEGER NOT NULL,
                reorder_threshold INTEGER NOT NULL,
                inv_last_updated  DATE NOT NULL,
                created_at        DATE NOT NULL,
                updated_at        DATE NOT NULL
            )';
  DBMS_OUTPUT.PUT_LINE('Table inventory CREATED SUCCESSFULLY ✅');  

  -- Add primary key constraint
        EXECUTE IMMEDIATE 'ALTER TABLE inventory ADD CONSTRAINT inventory_pk PRIMARY KEY ( inventory_id )';
            DBMS_OUTPUT.PUT_LINE('Primary key constraint inventory_pk added successfully ✅');
    
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('FAILED TO CREATE TABLE inventory or add primary key ❌');
    END;

END;

-- Wallet Table

/
DECLARE
   TABLE_EXISTS NUMBER;
BEGIN
    -- Check if the table exists
    SELECT COUNT(*) 
    INTO TABLE_EXISTS
    FROM USER_TABLES
    WHERE LOWER(TABLE_NAME) = 'inventory';
    
    -- Drop table if it exists
    IF TABLE_EXISTS > 0 THEN
        BEGIN 
            EXECUTE IMMEDIATE 'DROP TABLE wallet CASCADE constraints';
            DBMS_OUTPUT.PUT_LINE('Table wallet DROPPED SUCCESSFULLY ✅');
        EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('FAILED TO DROP TABLE wallet ❌');
        END;
    END IF;
    -- Create the table
    BEGIN
        EXECUTE IMMEDIATE '
            CREATE TABLE wallet (
                wallet_id          VARCHAR2(10) NOT NULL,
                program_tier       VARCHAR2(10) NOT NULL,
                points_earned      INTEGER NOT NULL,
                points_redeemed    INTEGER NOT NULL,
                transaction_id     VARCHAR2(10) NOT NULL,
                transaction_reason VARCHAR2(50) NOT NULL,
                created_at         DATE NOT NULL,
                updated_at         DATE NOT NULL
            )';
DBMS_OUTPUT.PUT_LINE('Table wallet CREATED SUCCESSFULLY ✅');
    -- Add primary key constraint
        EXECUTE IMMEDIATE 'ALTER TABLE wallet ADD CONSTRAINT lm_pk PRIMARY KEY ( wallet_id )';
            DBMS_OUTPUT.PUT_LINE('Primary key constraint lm_pk added successfully ✅');
    
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('FAILED TO CREATE TABLE wallet or add primary key ❌');
    END;

END;


-- Employee Table

/
DECLARE
   TABLE_EXISTS NUMBER;
BEGIN
    -- Check if the table exists
    SELECT COUNT(*) 
    INTO TABLE_EXISTS
    FROM USER_TABLES
    WHERE LOWER(TABLE_NAME) = 'employee';
    
    -- Drop table if it exists
    IF TABLE_EXISTS > 0 THEN
        BEGIN 
            EXECUTE IMMEDIATE 'DROP TABLE employee CASCADE constraints';
            DBMS_OUTPUT.PUT_LINE('Table employee DROPPED SUCCESSFULLY ✅');
        EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('FAILED TO DROP TABLE employee ❌');
        END;
    END IF;
    
    -- Create the table
    BEGIN
        EXECUTE IMMEDIATE '
            CREATE TABLE employee (
                employee_id    INTEGER NOT NULL,
                emp_first_name VARCHAR2(20) NOT NULL,
                emp_last_name  VARCHAR2(20) NOT NULL,
                emp_email      VARCHAR2(50) NOT NULL,
                emp_phone      NUMBER(10) NOT NULL,
                emp_type       VARCHAR2(15) CHECK (emp_type IN(''pilot'',''crew'',''ground_staff'',''corporate'' )) NOT NULL,
                emp_subtype    VARCHAR2(20),
                emp_salary     NUMBER(10, 2) NOT NULL,
                created_at     DATE NOT NULL,
                updated_at     DATE NOT NULL
            )';
   DBMS_OUTPUT.PUT_LINE('Table employee SUCCESSFULLY ✅');   

-- Add primary key constraint
        EXECUTE IMMEDIATE 'ALTER TABLE employee ADD CONSTRAINT employee_pk PRIMARY KEY ( employee_id )';
            DBMS_OUTPUT.PUT_LINE('Primary key constraint employee_pk added successfully ✅');

        EXECUTE IMMEDIATE 'ALTER TABLE employee ADD CONSTRAINT chk_emp_email_format 
    CHECK (REGEXP_LIKE(emp_email, ''^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$''))';
         DBMS_OUTPUT.PUT_LINE('Email constraint chk_emp_email_format added successfully ✅');

        EXECUTE IMMEDIATE 'ALTER TABLE employee ADD CONSTRAINT chk_emp_phone_format 
    CHECK (REGEXP_LIKE(emp_phone, ''^\d{10}$''))';
         DBMS_OUTPUT.PUT_LINE('Phone constraint chk_emp_phone_format added successfully ✅');
   
    
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('FAILED TO CREATE TABLE employee or add primary key or any constraints ❌');
    END;
END;


-- Payment Table

/
DECLARE
   TABLE_EXISTS NUMBER;
BEGIN
    -- Check if the table exists
    SELECT COUNT(*) 
    INTO TABLE_EXISTS
    FROM USER_TABLES
    WHERE LOWER(TABLE_NAME) = 'payment';
    
    -- Drop table if it exists
    IF TABLE_EXISTS > 0 THEN
        BEGIN 
            EXECUTE IMMEDIATE 'DROP TABLE payment CASCADE constraints';
            DBMS_OUTPUT.PUT_LINE('Table payment DROPPED SUCCESSFULLY ✅');
        EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('FAILED TO DROP TABLE payment ❌');
        END;
    END IF;
    
     -- Create the table
    BEGIN
        EXECUTE IMMEDIATE '
            CREATE TABLE payment (
                payment_id     INTEGER NOT NULL,
                payment_date   DATE NOT NULL,
                payment_amount NUMBER(10, 2) NOT NULL,
                payment_mode   VARCHAR2(5) CHECK (payment_mode IN (''creditcard'',''debitcard'',''bank'',''wallet'')) NOT NULL,
                payment_type   VARCHAR2(10) CHECK (payment_type IN (''partial'',''full'')) NOT NULL,
                created_at     DATE NOT NULL,
                updated_at     DATE NOT NULL
            )';

DBMS_OUTPUT.PUT_LINE('Table aircraft payment SUCCESSFULLY ✅');
        
        -- Add primary key constraint
        EXECUTE IMMEDIATE 'ALTER TABLE payment ADD CONSTRAINT payment_pk PRIMARY KEY ( payment_id )';
            DBMS_OUTPUT.PUT_LINE('Primary key constraint payment_pk added successfully ✅');
    
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('FAILED TO CREATE TABLE payment or add primary key ❌');
    END;

END;
/