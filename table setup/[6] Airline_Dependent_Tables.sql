/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/

-- Inventory_Order Table
   SET SERVEROUTPUT ON
/
declare
   table_exists number;
begin
    -- Check if the table exists
   select count(*)
     into table_exists
     from user_tables
    where lower(table_name) = 'inventory_order';
    
    -- Drop table if it exists
   if table_exists > 0 then
      begin
         execute immediate 'DROP TABLE inventory_order CASCADE constraints';
         dbms_output.put_line('Table inventory_order DROPPED SUCCESSFULLY ✅ ');
      exception
         when others then
            dbms_output.put_line('FAILED TO DROP TABLE inventory_order ❌');
      end;
   end if;
    
    -- Create the table
   begin
      execute immediate '
            CREATE TABLE inventory_order (
                order_id               INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                order_date             DATE NOT NULL,
                order_quantity         INTEGER NOT NULL,
                order_amount           NUMBER(10, 2) NOT NULL,
                order_status           VARCHAR2(10) CHECK (order_status IN (''pending'',''fulfilled'',''failed'')) NOT NULL,
                supplier_name          VARCHAR2(20) NOT NULL,
                inventory_inventory_id INTEGER NOT NULL,
                created_at       DATE DEFAULT SYSDATE NOT NULL,
                updated_at       DATE DEFAULT SYSDATE NOT NULL
            )';
      dbms_output.put_line('Table inventory_order CREATED SUCCESSFULLY ✅');

        -- Add foreign key constraint
      execute immediate 'ALTER TABLE inventory_order ADD CONSTRAINT io_inventory_fk FOREIGN KEY ( inventory_inventory_id )
        REFERENCES inventory ( inventory_id )';
      dbms_output.put_line('Foreign key constraint io_inventory_fk added successfully ✅');
   exception
      when others then
         dbms_output.put_line('FAILED TO CREATE TABLE inventory_order or foreign key ❌');
   end;
end;

-- Maintenance Schedule Table

/
declare
   table_exists number;
begin
    -- Check if the table exists
   select count(*)
     into table_exists
     from user_tables
    where lower(table_name) = 'maintenance_schedule';
    

   -- Drop table if it exists
   if table_exists > 0 then
      begin
         execute immediate 'DROP TABLE maintenance_schedule CASCADE constraints';
         dbms_output.put_line('Table maintenance_schedule DROPPED SUCCESSFULLY ✅');
      exception
         when others then
            dbms_output.put_line('FAILED TO DROP TABLE maintenance_schedule ❌');
      end;
   end if;
    
    -- Create the table
   begin
      execute immediate '
            CREATE TABLE maintenance_schedule (
                main_schedule_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                main_type        VARCHAR2(20) CHECK (main_type IN (''scheduled'', ''unscheduled'', ''emergency'', ''inspection'')) NOT NULL ,
                schedule_date    DATE NOT NULL,
                aircraft_aircraft_id INTEGER NOT NULL,
                created_at       DATE DEFAULT SYSDATE NOT NULL,
                updated_at       DATE DEFAULT SYSDATE NOT NULL
            )';
      dbms_output.put_line('Table maintenance_schedule CREATED SUCCESSFULLY ✅');

      -- Add foreign key constraint
      execute immediate 'ALTER TABLE maintenance_schedule ADD CONSTRAINT ms_aircraft_fk FOREIGN KEY ( aircraft_aircraft_id )
        REFERENCES aircraft ( aircraft_id )';
         dbms_output.put_line('Foreign key constraint ms_aircraft_fk added successfully ✅');
      
   exception
      when others then
         dbms_output.put_line('FAILED TO CREATE TABLE maintenance_schedule ❌');
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
                wallet_id                 INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                membership_id             VARCHAR2(5) NOT NULL,
                program_tier              VARCHAR2(10) NOT NULL,
                points_earned             INTEGER NOT NULL,
                points_redeemed           INTEGER NOT NULL,
                transaction_id            VARCHAR2(10) NOT NULL,
                transaction_reason        VARCHAR2(50) NOT NULL,
                passenger_passenger_id    INTEGER,
                created_at                DATE DEFAULT SYSDATE NOT NULL,
                updated_at                DATE DEFAULT SYSDATE NOT NULL
            )';
      dbms_output.put_line('Table wallet CREATED SUCCESSFULLY ✅');

    -- Wallet unique constraint
    EXECUTE IMMEDIATE 'ALTER TABLE wallet ADD CONSTRAINT uq_wallet_transaction UNIQUE (transaction_id)';
    DBMS_OUTPUT.PUT_LINE('✅ Added unique constraint on wallet transaction_id');
    -- Add foreign key constraint
      execute immediate 'ALTER TABLE wallet ADD CONSTRAINT pass_wallet_fk FOREIGN KEY ( passenger_passenger_id )
    REFERENCES passenger ( passenger_id )';
      dbms_output.put_line('Foreign key passenger_id added successfully ✅');
   exception
      when others then
         dbms_output.put_line('FAILED TO CREATE TABLE wallet or add primary key or foreign key constraint ❌');
   end;

end;


-- Refund Table

/
declare
   table_exists number;
begin
    -- Check if the table exists
   select count(*)
     into table_exists
     from user_tables
    where lower(table_name) = 'refund';
    
    -- Drop table if it exists
   if table_exists > 0 then
      begin
         execute immediate 'DROP TABLE refund CASCADE constraints';
         dbms_output.put_line('Table refund DROPPED SUCCESSFULLY ✅');
      exception
         when others then
            dbms_output.put_line('FAILED TO DROP TABLE refund ❌');
      end;
   end if;
    
    -- Create the table
   begin
      execute immediate '
             CREATE TABLE refund (
                refund_id          INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                refund_amount      NUMBER(10, 2) NOT NULL,
                refund_reason      VARCHAR2(50) NOT NULL,
                payment_payment_id INTEGER NOT NULL,
                created_at       DATE DEFAULT SYSDATE NOT NULL,
                updated_at       DATE DEFAULT SYSDATE NOT NULL
            )';
      dbms_output.put_line('Table refund CREATED SUCCESSFULLY ✅');
        
    -- Add foreign key constraint
      execute immediate 'ALTER TABLE refund ADD CONSTRAINT refund_payment_fk FOREIGN KEY ( payment_payment_id )
        REFERENCES payment ( payment_id )';
      dbms_output.put_line('Foreign key constraint refund_payment_fk added successfully ✅');
   exception
      when others then
         dbms_output.put_line('FAILED TO CREATE TABLE aircraft or foreign key ❌');
   end;

end;


-- Tables below depends on >=2 tables
-- Flight Schedule Table


/
declare
   table_exists number;
begin
    -- Check if the table exists
   select count(*)
     into table_exists
     from user_tables
    where lower(table_name) = 'flight_schedule';
    
    -- Drop table if it exists
   if table_exists > 0 then
      begin
         execute immediate 'DROP TABLE flight_schedule CASCADE constraints';
         dbms_output.put_line('Table flight_schedule DROPPED SUCCESSFULLY ✅');
      exception
         when others then
            dbms_output.put_line('FAILED TO DROP TABLE flight_schedule ❌');
      end;
   end if;
    
     -- Create the table
   begin
      execute immediate '
            CREATE TABLE flight_schedule (
                flight_schedule_id   INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                departure_airport    VARCHAR2(30) NOT NULL,
                scheduled_dep_time   DATE NOT NULL,
                actual_dep_time      DATE NOT NULL,
                arrival_airport      VARCHAR2(30) NOT NULL,
                scheduled_arr_time   DATE NOT NULL,
                actual_arr_time      DATE NOT NULL,
                flight_status        VARCHAR2(15) CHECK (flight_status IN (''scheduled'',''ontime'', ''departed'' ,''delayed'',''cancelled'', ''landed''))NOT NULL,
                aircraft_aircraft_id INTEGER NOT NULL,
                routes_route_id      INTEGER NOT NULL,
                created_at       DATE DEFAULT SYSDATE NOT NULL,
                updated_at       DATE DEFAULT SYSDATE NOT NULL
            )';
      dbms_output.put_line('Table flight_schedule CREATED SUCCESSFULLY ✅');
        
      -- Add foreign key constraint
      execute immediate 'ALTER TABLE flight_schedule ADD CONSTRAINT fs_aircraft_fk FOREIGN KEY ( aircraft_aircraft_id )
        REFERENCES aircraft ( aircraft_id )';
      dbms_output.put_line('Foreign key constraint fs_aircraft_fk added successfully ✅');
      execute immediate 'ALTER TABLE flight_schedule ADD CONSTRAINT fs_routes_fk FOREIGN KEY ( routes_route_id )
        REFERENCES route ( route_id )';
      dbms_output.put_line('Foreign key constraint fs_routes_fk added successfully ✅');
   exception
      when others then
         dbms_output.put_line('FAILED TO CREATE TABLE flight_schedule or foreign key ❌');
   end;

end;


-- Maintenance Record Table


/
declare
   table_exists number;
begin
    -- Check if the table exists
   select count(*)
     into table_exists
     from user_tables
    where lower(table_name) = 'maintenance_record';
    
    -- Drop table if it exists
   if table_exists > 0 then
      begin
         execute immediate 'DROP TABLE maintenance_record CASCADE constraints';
         dbms_output.put_line('Table maintenance_record DROPPED SUCCESSFULLY ✅');
      exception
         when others then
            dbms_output.put_line('FAILED TO DROP TABLE maintenance_record ❌');
      end;
   end if;
    
    -- Create the table
   begin
      execute immediate '
            CREATE TABLE maintenance_record (
                main_record_id   INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                main_record_date DATE NOT NULL,
                main_record_type VARCHAR2(15) CHECK (main_record_type IN (''cleaning'',''routine'',''repairs'',''inspection'')) NOT NULL,
                main_record_description VARCHAR2 (50)  NOT NULL,
                employee_employee_id INTEGER NOT NULL,
                inventory_inventory_id INTEGER NOT NULL,
                ms_main_schedule_id INTEGER NOT NULL,
                created_at       DATE DEFAULT SYSDATE NOT NULL,
                updated_at       DATE DEFAULT SYSDATE NOT NULL
            )';
      dbms_output.put_line('Table maintenance_record CREATED SUCCESSFULLY ✅');
        
        -- Add foreign key constraint
      execute immediate 'ALTER TABLE maintenance_record ADD CONSTRAINT mr_employee_fk FOREIGN KEY ( employee_employee_id )
        REFERENCES employee ( employee_id )';
      dbms_output.put_line('Foreign key constraint mr_employee_fk added successfully ✅');
      execute immediate 'ALTER TABLE maintenance_record ADD CONSTRAINT mr_inventory_fk FOREIGN KEY ( inventory_inventory_id )
        REFERENCES inventory ( inventory_id )';
      dbms_output.put_line('Foreign key constraint mr_inventory_fk added successfully ✅');
      execute immediate 'ALTER TABLE maintenance_record ADD CONSTRAINT mr_ms_fk FOREIGN KEY ( ms_main_schedule_id )
        REFERENCES maintenance_schedule ( main_schedule_id )';
      dbms_output.put_line('Foreign key constraint mr_ms_fk added successfully ✅');
   exception
      when others then
         dbms_output.put_line('FAILED TO CREATE TABLE maintenance_record or foreign key ❌');
   end;

end;

-- Seat Table

/
declare
   table_exists number;
begin
    -- Check if the table exists
   select count(*)
     into table_exists
     from user_tables
    where lower(table_name) = 'seat';
    
    -- Drop table if it exists
   if table_exists > 0 then
      begin
         execute immediate 'DROP TABLE seat CASCADE constraints';
         dbms_output.put_line('Table seat DROPPED SUCCESSFULLY ✅');
      exception
         when others then
            dbms_output.put_line('FAILED TO DROP TABLE seat ❌');
      end;
   end if;

    -- Create the table
   begin
      execute immediate '
            CREATE TABLE seat (
                    seat_id               INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                    seat_number           VARCHAR2(5) NOT NULL,
                    seat_type             VARCHAR2(10) NOT NULL,
                    seat_class            VARCHAR2(20) NOT NULL,
                    is_available          CHAR(1) NOT NULL,
                    fs_flight_schedule_id INTEGER NOT NULL,
                    created_at       DATE DEFAULT SYSDATE NOT NULL,
                    updated_at       DATE DEFAULT SYSDATE NOT NULL
            )';
      dbms_output.put_line('Table seat CREATED SUCCESSFULLY ✅');
        
      -- Add foreign key constraint
      execute immediate 'ALTER TABLE seat ADD CONSTRAINT seat_fs_fk FOREIGN KEY ( fs_flight_schedule_id )
        REFERENCES flight_schedule ( flight_schedule_id )';
      dbms_output.put_line('Foreign key constraint seat_fs_fk added successfully ✅');
   exception
      when others then
         dbms_output.put_line('FAILED TO CREATE TABLE seat or foreign key ❌');
   end;

end;


-- Reservation Table


/
declare
   table_exists number;
begin
    -- Check if the table exists
   select count(*)
     into table_exists
     from user_tables
    where lower(table_name) = 'reservation';
    
    -- Drop table if it exists
   if table_exists > 0 then
      begin
         execute immediate 'DROP TABLE reservation CASCADE constraints';
         dbms_output.put_line('Table reservation DROPPED SUCCESSFULLY ✅');
      exception
         when others then
            dbms_output.put_line('FAILED TO DROP TABLE reservation ❌');
      end;
   end if;

    -- Create the table
   begin
      execute immediate '
            CREATE TABLE reservation (
                reservation_id         INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                travel_date            DATE NOT NULL,
                reservation_status     VARCHAR2(15) CHECK (reservation_status IN (''pending'',''confirmed'',''partial'',''cancelled'')) NOT NULL,
                created_at             DATE DEFAULT SYSDATE NOT NULL,
                updated_at             DATE DEFAULT SYSDATE NOT NULL,
                airfare                NUMBER(10, 2) NOT NULL,
                passenger_passenger_id INTEGER NOT NULL,
                seat_seat_id           INTEGER NOT NULL,
                pnr                    VARCHAR2(6) NOT NULL,
                start_date             DATE,
                end_date               DATE
            )';
      dbms_output.put_line('Table reservation CREATED SUCCESSFULLY ✅');
        
   
    -- Add foreign key constraint
      execute immediate 'ALTER TABLE reservation ADD CONSTRAINT reservation_seat_fk FOREIGN KEY ( seat_seat_id )
        REFERENCES seat ( seat_id )';
      dbms_output.put_line('Foreign key constraint reservation_seat_fk added successfully ✅');
          -- Reservation PNR unique constraint
    EXECUTE IMMEDIATE 'ALTER TABLE reservation ADD CONSTRAINT uq_reservation_pnr UNIQUE (pnr)';
    DBMS_OUTPUT.PUT_LINE('✅ Added unique constraint on reservation PNR');
      execute immediate 'ALTER TABLE reservation ADD CONSTRAINT reservation_passenger_fk FOREIGN KEY ( passenger_passenger_id )
        REFERENCES passenger ( passenger_id )';
      dbms_output.put_line('Foreign key constraint reservation_passenger_fk added successfully ✅');
   exception
      when others then
         dbms_output.put_line('FAILED TO CREATE TABLE reservation or foreign key ❌');
   end;
end;


-- Baggage Table

/
declare
   table_exists number;
begin
    -- Check if the table exists
   select count(*)
     into table_exists
     from user_tables
    where lower(table_name) = 'baggage';

    -- Drop table if it exists
   if table_exists > 0 then
      begin
         execute immediate 'DROP TABLE baggage CASCADE constraints';
         dbms_output.put_line('Table baggage DROPPED SUCCESSFULLY ✅');
      exception
         when others then
            dbms_output.put_line('FAILED TO DROP TABLE baggage ❌');
      end;
   end if;

    -- Create the table
   begin
      execute immediate '
            CREATE TABLE baggage (
                baggage_id             INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                baggage_weight         NUMBER(4, 2) NOT NULL,
                baggage_status         VARCHAR2(20) CHECK (baggage_status IN (''checkin'',''loaded'',''lost'',''unloaded'',''damaged'',''delivered'',''awaiting_transfer'',''claimed'')) NOT NULL,
                reservation_reservation_id INTEGER NOT NULL,
                created_at       DATE DEFAULT SYSDATE NOT NULL,
                updated_at       DATE DEFAULT SYSDATE NOT NULL
            )';
      dbms_output.put_line('Table baggage CREATED SUCCESSFULLY ✅');
        
      -- Add foreign key constraint
      execute immediate 'ALTER TABLE baggage ADD CONSTRAINT bag_reservation_fk FOREIGN KEY ( reservation_reservation_id )
        REFERENCES reservation ( reservation_id )';
      dbms_output.put_line('Foreign key constraint bag_reservation_fk added successfully ✅');
   exception
      when others then
         dbms_output.put_line('FAILED TO CREATE TABLE baggage or foreign key ❌');
   end;

end;


-- Crew Assignment Table


/
declare
   table_exists number;
begin
    -- Check if the table exists
   select count(*)
     into table_exists
     from user_tables
    where lower(table_name) = 'crew_assignment';
    
    -- Drop table if it exists
   if table_exists > 0 then
      begin
         execute immediate 'DROP TABLE crew_assignment CASCADE constraints';
         dbms_output.put_line('Table crew_assignment DROPPED SUCCESSFULLY ✅');
      exception
         when others then
            dbms_output.put_line('FAILED TO DROP TABLE crew_assignment ❌');
      end;
   end if;

    -- Create the table
   begin
      execute immediate '
                CREATE TABLE crew_assignment (
                    assignment_id         INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                    assignment_date       DATE NOT NULL,
                    assignment_role       VARCHAR2(15) NOT NULL,
                    fs_flight_schedule_id INTEGER NOT NULL,
                    employee_employee_id  INTEGER NOT NULL,
                    created_at       DATE DEFAULT SYSDATE NOT NULL,
                    updated_at       DATE DEFAULT SYSDATE NOT NULL
                )';
      dbms_output.put_line('Table crew_assignment CREATED SUCCESSFULLY ✅');
        
         -- Add foreign key constraint
      execute immediate 'ALTER TABLE crew_assignment ADD CONSTRAINT ca_employee_fk FOREIGN KEY ( employee_employee_id )
        REFERENCES employee ( employee_id )';
      dbms_output.put_line('Foreign key constraint ca_employee_fk added successfully ✅');
      execute immediate 'ALTER TABLE crew_assignment ADD CONSTRAINT ca_fs_fk FOREIGN KEY ( fs_flight_schedule_id )
        REFERENCES flight_schedule ( flight_schedule_id )';
      dbms_output.put_line('Foreign key constraint ca_fs_fk added successfully ✅');
   exception
      when others then
         dbms_output.put_line('FAILED TO CREATE TABLE crew_assignment or add primary key or foreign key ❌');
   end;

end;


-- Reservation_Payment table (ManyToMany Relation)


/
declare
   table_exists number;
begin
    -- Check if the table exists
   select count(*)
     into table_exists
     from user_tables
    where lower(table_name) = 'reservation_payment';
    
     -- Drop table if it exists
   if table_exists > 0 then
      begin
         execute immediate 'DROP TABLE reservation_payment CASCADE constraints';
         dbms_output.put_line('Table reservation_payment DROPPED SUCCESSFULLY ✅');
      exception
         when others then
            dbms_output.put_line('FAILED TO DROP TABLE reservation_payment ❌');
      end;
   end if;
    
    -- Create the table
   begin
      execute immediate '
             CREATE TABLE reservation_payment (
                res_pay_id       INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                payment_payment_id         INTEGER NOT NULL,
                reservation_reservation_id INTEGER NOT NULL,
                created_at       DATE DEFAULT SYSDATE NOT NULL,
                updated_at       DATE DEFAULT SYSDATE NOT NULL
            )';
      dbms_output.put_line('Table reservation_payment CREATED SUCCESSFULLY ✅');
        
        -- Add foreign key constraint
      execute immediate 'ALTER TABLE reservation_payment ADD CONSTRAINT res_pay_payment_fk FOREIGN KEY ( payment_payment_id )
        REFERENCES payment ( payment_id )';
      dbms_output.put_line('Foreign key constraint res_pay_payment_fk added successfully ✅');
      execute immediate 'ALTER TABLE reservation_payment ADD CONSTRAINT res_pay_reservation_fk FOREIGN KEY ( reservation_reservation_id )
        REFERENCES reservation ( reservation_id )';
      dbms_output.put_line('Foreign key constraint res_pay_reservation_fk added successfully ✅');
   exception
      when others then
         dbms_output.put_line('FAILED TO CREATE TABLE reservation_payment or foreign key ❌');
   end;
end;
/
