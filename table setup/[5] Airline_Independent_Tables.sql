/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/

-- Aircraft table
   SET SERVEROUTPUT ON

declare
   table_exists number;
begin
    -- Check if the table exists
   select count(*)
     into table_exists
     from user_tables
    where lower(table_name) = 'aircraft';
    
     -- Drop table if it exists
   if table_exists > 0 then
      begin
         execute immediate 'DROP TABLE aircraft CASCADE constraints';
         dbms_output.put_line('Table aircraft DROPPED SUCCESSFULLY ✅');
      exception
         when others then
            dbms_output.put_line('FAILED TO DROP TABLE aircarft ❌');
      end;
   end if;

    -- create the table
   begin
      execute immediate '
        CREATE TABLE aircraft (
            aircraft_id      INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
            aircraft_name    VARCHAR2(30) NOT NULL,
            aircraft_model   VARCHAR2(30) NOT NULL,
            seating_capacity INTEGER NOT NULL,
            fuel_capacity    INTEGER NOT NULL,
            created_at       DATE DEFAULT SYSDATE NOT NULL,
            updated_at       DATE DEFAULT SYSDATE NOT NULL
        )';
      dbms_output.put_line('Table aircraft CREATED SUCCESSFULLY ✅');
   exception
      when others then
         dbms_output.put_line('FAILED TO CREATE TABLE aircraft or add primary key ❌');
   end;
end;

-- Route Table

/
declare
   table_exists number;
begin
    -- Check if the table exists
   select count(*)
     into table_exists
     from user_tables
    where lower(table_name) = 'route';
    
    -- Drop table if it exists
   if table_exists > 0 then
      begin
         execute immediate 'DROP TABLE route CASCADE constraints';
         dbms_output.put_line('Table route DROPPED SUCCESSFULLY ✅');
      exception
         when others then
            dbms_output.put_line('FAILED TO DROP TABLE route ❌');
      end;
   end if;
    -- Create the table
   begin
      execute immediate '
            CREATE TABLE route (
            route_id            INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
            origin_airport      VARCHAR2(30) NOT NULL,
            destination_airport VARCHAR2(30) NOT NULL,
            distance            INTEGER NOT NULL,
            created_at       DATE DEFAULT SYSDATE NOT NULL,
            updated_at       DATE DEFAULT SYSDATE NOT NULL
        )';
      dbms_output.put_line('Table route CREATED SUCCESSFULLY ✅');

   exception
      when others then
         dbms_output.put_line('FAILED TO CREATE TABLE route or add primary key ❌');
   end;
end;




-- Inventory Table


/
declare
   table_exists number;
begin
    -- Check if the table exists
   select count(*)
     into table_exists
     from user_tables
    where lower(table_name) = 'inventory';

    -- Drop table if it exists
   if table_exists > 0 then
      begin
         execute immediate 'DROP TABLE inventory CASCADE constraints';
         dbms_output.put_line('Table inventory DROPPED SUCCESSFULLY ✅');
      exception
         when others then
            dbms_output.put_line('FAILED TO DROP TABLE inventory ❌');
      end;
   end if;

     -- Create the table
   begin
      execute immediate '
            CREATE TABLE inventory (
                inventory_id      INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                item_name         VARCHAR2(30) NOT NULL,
                item_category     VARCHAR2(15) CHECK (item_category IN (''catering'', ''cleaning'', ''spare'', ''tools'')) NOT NULL,
                quantity_in_hand  INTEGER NOT NULL,
                reorder_threshold INTEGER NOT NULL,
                inv_last_updated  DATE NOT NULL,
                created_at       DATE DEFAULT SYSDATE NOT NULL,
                updated_at       DATE DEFAULT SYSDATE NOT NULL
            )';
      dbms_output.put_line('Table inventory CREATED SUCCESSFULLY ✅');  
   exception
      when others then
         dbms_output.put_line('FAILED TO CREATE TABLE inventory or add primary key ❌');
   end;

end;

-- Wallet Table


/
declare
   table_exists number;
begin
    -- Check if the table exists
   select count(*)
     into table_exists
     from user_tables
    where lower(table_name) = 'wallet';
    
    -- Drop table if it exists
   if table_exists > 0 then
      begin
         execute immediate 'DROP TABLE wallet CASCADE constraints';
         dbms_output.put_line('Table wallet DROPPED SUCCESSFULLY ✅');
      exception
         when others then
            dbms_output.put_line('FAILED TO DROP TABLE wallet ❌');
      end;
   end if;
    -- Create the table
   begin
      execute immediate '
            CREATE TABLE wallet (
                wallet_id         INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                program_tier       VARCHAR2(10) NOT NULL,
                points_earned      INTEGER NOT NULL,
                points_redeemed    INTEGER NOT NULL,
                transaction_id     VARCHAR2(10) NOT NULL,
                transaction_reason VARCHAR2(50) NOT NULL,
                created_at         DATE DEFAULT SYSDATE NOT NULL,
                updated_at         DATE DEFAULT SYSDATE NOT NULL
            )';
      dbms_output.put_line('Table wallet CREATED SUCCESSFULLY ✅');
   exception
      when others then
         dbms_output.put_line('FAILED TO CREATE TABLE wallet or add primary key ❌');
   end;

end;

-- Employee Table

/
declare
   table_exists number;
begin
    -- Check if the table exists
   select count(*)
     into table_exists
     from user_tables
    where lower(table_name) = 'employee';
    
    -- Drop table if it exists
   if table_exists > 0 then
      begin
         execute immediate 'DROP TABLE employee CASCADE constraints';
         dbms_output.put_line('Table employee DROPPED SUCCESSFULLY ✅');
      exception
         when others then
            dbms_output.put_line('FAILED TO DROP TABLE employee ❌');
      end;
   end if;
    
    -- Create the table
   begin
      execute immediate '
            CREATE TABLE employee (
                employee_id    INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                emp_first_name VARCHAR2(20) NOT NULL,
                emp_last_name  VARCHAR2(20) NOT NULL,
                emp_email      VARCHAR2(50) NOT NULL,
                emp_phone      NUMBER(10) NOT NULL,
                emp_type       VARCHAR2(15) CHECK (emp_type IN(''pilot'',''crew'',''ground_staff'',''corporate'' )) NOT NULL,
                emp_subtype    VARCHAR2(20),
                emp_salary     NUMBER(10, 2) NOT NULL,
                created_at     DATE DEFAULT SYSDATE NOT NULL,
                updated_at     DATE DEFAULT SYSDATE NOT NULL,
                CONSTRAINT chk_emp_subtype CHECK (
                    (emp_type = ''corporate'' AND emp_subtype IS NOT NULL) OR
                    (emp_type <> ''corporate'' AND emp_subtype IS NULL)
                )
            )';
      dbms_output.put_line('Table employee SUCCESSFULLY ✅');   

-- Add constraints
      execute immediate 'ALTER TABLE employee ADD CONSTRAINT chk_emp_email_format 
    CHECK (REGEXP_LIKE(emp_email, ''^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$''))';
      dbms_output.put_line('Email constraint chk_emp_email_format added successfully ✅');
      execute immediate 'ALTER TABLE employee ADD CONSTRAINT chk_emp_phone_format 
    CHECK (REGEXP_LIKE(emp_phone, ''^\d{10}$''))';
      dbms_output.put_line('Phone constraint chk_emp_phone_format added successfully ✅');
   exception
      when others then
         dbms_output.put_line('FAILED TO CREATE TABLE employee or any constraints ❌');
   end;
end;


-- Payment Table

/
declare
   table_exists number;
begin
    -- Check if the table exists
   select count(*)
     into table_exists
     from user_tables
    where lower(table_name) = 'payment';
    
    -- Drop table if it exists
   if table_exists > 0 then
      begin
         execute immediate 'DROP TABLE payment CASCADE constraints';
         dbms_output.put_line('Table payment DROPPED SUCCESSFULLY ✅');
      exception
         when others then
            dbms_output.put_line('FAILED TO DROP TABLE payment ❌');
      end;
   end if;
    
     -- Create the table
   begin
      execute immediate '
            CREATE TABLE payment (
                payment_id     INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                payment_date   DATE NOT NULL,
                payment_amount NUMBER(10, 2) NOT NULL,
                payment_mode   VARCHAR2(10) CHECK (payment_mode IN (''creditcard'',''debitcard'',''bank'',''wallet'')) NOT NULL,
                payment_type   VARCHAR2(10) CHECK (payment_type IN (''partial'',''full'')) NOT NULL,
                created_at       DATE DEFAULT SYSDATE NOT NULL,
                updated_at       DATE DEFAULT SYSDATE NOT NULL
            )';
      dbms_output.put_line('Table aircraft payment SUCCESSFULLY ✅');
   exception
      when others then
         dbms_output.put_line('FAILED TO CREATE TABLE payment or add primary key ❌');
   end;

end;
/
