-- Below tables are independent
-- Aircraft table
SET SERVEROUTPUT ON
/
DECLARE
   TABLE_EXISTS NUMBER;
BEGIN
    SELECT COUNT(*) 
    INTO TABLE_EXISTS
    FROM USER_TABLES
    WHERE TABLE_NAME = 'aircraft';
    
    IF TABLE_EXISTS > 0
    THEN 
        EXECUTE IMMEDIATE 'DROP TABLE aircraft CASCADE';
        DBMS_OUTPUT.PUT_LINE('Table aircraft DROPPED SUCCESSFULLY');
    END IF;
    
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('FAILED TO DROP TABLE aircarft');
END;
/

CREATE TABLE aircraft (
    aircraft_id      INTEGER NOT NULL,
    aircraft_name    VARCHAR2(30) NOT NULL,
    aircraft_model   VARCHAR2(30) NOT NULL,
    seating_capacity INTEGER NOT NULL,
    fuel_capacity    INTEGER NOT NULL,
    created_at       DATE NOT NULL,
    updated_at       DATE NOT NULL
);

ALTER TABLE aircraft ADD CONSTRAINT aircraft_pk PRIMARY KEY ( aircraft_id );

-- Route Table
SET SERVEROUTPUT ON
/
DECLARE
   TABLE_EXISTS NUMBER;
BEGIN
    SELECT COUNT(*) 
    INTO TABLE_EXISTS
    FROM USER_TABLES
    WHERE TABLE_NAME = 'route';
    
    IF TABLE_EXISTS > 0
    THEN 
        EXECUTE IMMEDIATE 'DROP TABLE route CASCADE';
        DBMS_OUTPUT.PUT_LINE('Table route DROPPED SUCCESSFULLY');
    END IF;
    
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('FAILED TO DROP TABLE route');
END;
/

CREATE TABLE route (
    route_id            INTEGER NOT NULL,
    origin_airport      VARCHAR2(30) NOT NULL,
    destination_airport VARCHAR2(30) NOT NULL,
    distance            INTEGER NOT NULL,
    created_at          DATE NOT NULL,
    updated_at          DATE NOT NULL
);

ALTER TABLE route ADD CONSTRAINT route_pk PRIMARY KEY ( route_id );

-- Maintenance Schedule Table
SET SERVEROUTPUT ON
/
DECLARE
   TABLE_EXISTS NUMBER;
BEGIN
    SELECT COUNT(*) 
    INTO TABLE_EXISTS
    FROM USER_TABLES
    WHERE TABLE_NAME = 'maintenance_schedule';
    
    IF TABLE_EXISTS > 0
    THEN 
        EXECUTE IMMEDIATE 'DROP TABLE maintenance_schedule CASCADE';
        DBMS_OUTPUT.PUT_LINE('Table maintenance_schedule DROPPED SUCCESSFULLY');
    END IF;
    
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('FAILED TO DROP TABLE maintenance_schedule');
END;
/

CREATE TABLE maintenance_schedule (
    main_schedule_id INTEGER NOT NULL,
    main_type        VARCHAR2(20) CHECK (main_type IN ('scheduled', 'unscheduled', 'emergency', 'inspection')) NOT NULL ,
    schedule_date    DATE NOT NULL,
    created_at       DATE NOT NULL,
    updated_at       DATE NOT NULL
);

ALTER TABLE maintenance_schedule ADD CONSTRAINT ms_pk PRIMARY KEY ( main_schedule_id );

-- Inventory Table
SET SERVEROUTPUT ON
/
DECLARE
   TABLE_EXISTS NUMBER;
BEGIN
    SELECT COUNT(*) 
    INTO TABLE_EXISTS
    FROM USER_TABLES
    WHERE TABLE_NAME = 'inventory';
    
    IF TABLE_EXISTS > 0
    THEN 
        EXECUTE IMMEDIATE 'DROP TABLE inventory CASCADE';
        DBMS_OUTPUT.PUT_LINE('Table inventory DROPPED SUCCESSFULLY');
    END IF;
    
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('FAILED TO DROP TABLE inventory');
END;
/

CREATE TABLE inventory (
    inventory_id      INTEGER NOT NULL,
    item_name         VARCHAR2(30) NOT NULL,
    item_category     VARCHAR2(15) CHECK (item_category IN ('catering', 'cleaning', 'spare', 'tools')) NOT NULL,
    quantity_in_hand  INTEGER NOT NULL,
    reorder_threshold INTEGER NOT NULL,
    inv_last_updated  DATE NOT NULL,
    created_at        DATE NOT NULL,
    updated_at        DATE NOT NULL
);

ALTER TABLE inventory ADD CONSTRAINT inventory_pk PRIMARY KEY ( inventory_id );

-- Wallet Table
SET SERVEROUTPUT ON
/
DECLARE
   TABLE_EXISTS NUMBER;
BEGIN
    SELECT COUNT(*) 
    INTO TABLE_EXISTS
    FROM USER_TABLES
    WHERE TABLE_NAME = 'inventory';
    
    IF TABLE_EXISTS > 0
    THEN 
        EXECUTE IMMEDIATE 'DROP TABLE wallet CASCADE';
        DBMS_OUTPUT.PUT_LINE('Table wallet DROPPED SUCCESSFULLY');
    END IF;
    
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('FAILED TO DROP TABLE wallet');
END;
/

CREATE TABLE wallet (
    wallet_id          VARCHAR2(10) NOT NULL,
    program_tier       VARCHAR2(10),
    points_earned      INTEGER NOT NULL,
    points_redeemed    INTEGER NOT NULL,
    transaction_id     VARCHAR2(10) NOT NULL,
    transaction_reason VARCHAR2(50) NOT NULL,
    created_at         DATE NOT NULL,
    updated_at         DATE NOT NULL
);

ALTER TABLE wallet ADD CONSTRAINT lm_pk PRIMARY KEY ( wallet_id );

-- Employee Table
SET SERVEROUTPUT ON
/
DECLARE
   TABLE_EXISTS NUMBER;
BEGIN
    SELECT COUNT(*) 
    INTO TABLE_EXISTS
    FROM USER_TABLES
    WHERE TABLE_NAME = 'employee';
    
    IF TABLE_EXISTS > 0
    THEN 
        EXECUTE IMMEDIATE 'DROP TABLE employee CASCADE';
        DBMS_OUTPUT.PUT_LINE('Table employee DROPPED SUCCESSFULLY');
    END IF;
    
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('FAILED TO DROP TABLE employee');
END;
/

CREATE TABLE employee (
    employee_id    INTEGER NOT NULL,
    emp_first_name VARCHAR2(20) NOT NULL,
    emp_last_name  VARCHAR2(20) NOT NULL,
    emp_email      VARCHAR2(50) NOT NULL,
    emp_phone      NUMBER(10) NOT NULL,
    emp_type       VARCHAR2(15) CHECK (emp_type IN('pilot','crew','ground_staff','corporate' )) NOT NULL,
    emp_subtype    VARCHAR2(20),
    emp_salary     NUMBER(10, 2) NOT NULL,
    created_at     DATE NOT NULL,
    updated_at     DATE NOT NULL
);

ALTER TABLE employee ADD CONSTRAINT employee_pk PRIMARY KEY ( employee_id );
ALTER TABLE employee ADD CONSTRAINT chk_emp_email_format 
    CHECK (REGEXP_LIKE(emp_email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'));

-- Payment Table
SET SERVEROUTPUT ON
/
DECLARE
   TABLE_EXISTS NUMBER;
BEGIN
    SELECT COUNT(*) 
    INTO TABLE_EXISTS
    FROM USER_TABLES
    WHERE TABLE_NAME = 'payment';
    
    IF TABLE_EXISTS > 0
    THEN 
        EXECUTE IMMEDIATE 'DROP TABLE payment CASCADE';
        DBMS_OUTPUT.PUT_LINE('Table payment DROPPED SUCCESSFULLY');
    END IF;
    
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('FAILED TO DROP TABLE payment');
END;
/

CREATE TABLE payment (
    payment_id     INTEGER NOT NULL,
    payment_date   DATE NOT NULL,
    payment_amount NUMBER(10, 2) NOT NULL,
    payment_mode   VARCHAR2(5) CHECK (payment_mode IN ('cc','dc','bank','wallet')) NOT NULL,
    payment_type   VARCHAR2(10) CHECK (payment_type IN ('partial','full')) NOT NULL,
    created_at     DATE NOT NULL,
    updated_at     DATE NOT NULL
);

ALTER TABLE payment ADD CONSTRAINT payment_pk PRIMARY KEY ( payment_id );

