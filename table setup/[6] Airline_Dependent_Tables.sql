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
                order_id               INTEGER NOT NULL,
                order_date             DATE NOT NULL,
                order_quantity         INTEGER NOT NULL,
                order_amount           NUMBER(10, 2) NOT NULL,
                order_status           VARCHAR2(10) CHECK (order_status IN (''pending'',''fulfilled'',''failed'')) NOT NULL,
                supplier_name          VARCHAR2(20) NOT NULL,
                inventory_inventory_id INTEGER NOT NULL,
                created_at             DATE NOT NULL,
                updated_at             DATE NOT NULL
            )';
      dbms_output.put_line('Table inventory_order CREATED SUCCESSFULLY ✅');
        
        -- Add primary key constraint
      execute immediate 'ALTER TABLE inventory_order ADD CONSTRAINT io_pk PRIMARY KEY ( order_id )';
      dbms_output.put_line('Primary key constraint aircraft_pk added successfully ✅');

        -- Add foreign key constraint
      execute immediate 'ALTER TABLE inventory_order ADD CONSTRAINT io_inventory_fk FOREIGN KEY ( inventory_inventory_id )
        REFERENCES inventory ( inventory_id )';
      dbms_output.put_line('Foreign key constraint io_inventory_fk added successfully ✅');
   exception
      when others then
         dbms_output.put_line('FAILED TO CREATE TABLE inventory_order or add primary key or foreign key ❌');
   end;
end;


-- Passenger Table

/
declare
   table_exists number;
begin
    -- Check if the table exists
   select count(*)
     into table_exists
     from user_tables
    where lower(table_name) = 'passenger';
    
    -- Drop table if it exists
   if table_exists > 0 then
      begin
         execute immediate 'DROP TABLE passenger CASCADE constraints';
         dbms_output.put_line('Table passenger DROPPED SUCCESSFULLY ✅');
      exception
         when others then
            dbms_output.put_line('FAILED TO DROP TABLE passenger ❌');
      end;
   end if;

    -- Create the table
   begin
      execute immediate '
            CREATE TABLE passenger (
                passenger_id     INTEGER NOT NULL,
                pass_first_name  VARCHAR2(20) NOT NULL,
                pass_last_name   VARCHAR2(20) NOT NULL,
                pass_email       VARCHAR2(50) NOT NULL,
                pass_phone       NUMBER(10) NOT NULL,
                gender           VARCHAR2(10) CHECK (gender IN (''male'',''female'',''others'')) NOT NULL,
                dob              DATE NOT NULL,
                seat_preference  VARCHAR2(10) CHECK (seat_preference IN (''window'',''middle'',''aisle'')) NOT NULL,
                wallet_wallet_id INTEGER,
                created_at       DATE NOT NULL,
                updated_at       DATE NOT NULL
            )';
      dbms_output.put_line('Table passenger CREATED SUCCESSFULLY ✅ ');
        
     -- Add primary key constraint
      execute immediate 'ALTER TABLE passenger ADD CONSTRAINT passenger_pk PRIMARY KEY ( passenger_id )';
      dbms_output.put_line('Primary key constraint passenger_pk added successfully ✅');

    -- Add passenger email constraint
      execute immediate 'ALTER TABLE passenger ADD CONSTRAINT chk_pass_email_format 
    CHECK (REGEXP_LIKE(pass_email, ''^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$''))';
      dbms_output.put_line('Email constraint chk_pass_email_format added successfully ✅');

    -- Add passenger phone constraint
      execute immediate 'ALTER TABLE passenger ADD CONSTRAINT chk_pass_phone_format 
    CHECK (REGEXP_LIKE(pass_phone, ''^\d{10}$''))';
      dbms_output.put_line('Phone constraint chk_pass_phone_format added successfully ✅');

    -- Add foreign key constraint
      execute immediate 'ALTER TABLE passenger ADD CONSTRAINT wallet_pass_fk FOREIGN KEY ( wallet_wallet_id )
    REFERENCES wallet ( wallet_id )';
      dbms_output.put_line('Foreign key wallet_id added successfully ✅');
   exception
      when others then
         dbms_output.put_line('FAILED TO CREATE TABLE aircraft or add primary key or phone or email or foreign key constraint ❌'
         );
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
                refund_id          INTEGER NOT NULL,
                refund_amount      NUMBER(10, 2) NOT NULL,
                refund_reason      VARCHAR2(50) NOT NULL,
                payment_payment_id INTEGER NOT NULL,
                created_at         DATE NOT NULL,
                updated_at         DATE NOT NULL
            )';
      dbms_output.put_line('Table refund CREATED SUCCESSFULLY ✅');
        
    -- Add primary key constraint
      execute immediate 'ALTER TABLE refund ADD CONSTRAINT refund_pk PRIMARY KEY ( refund_id )';
      dbms_output.put_line('Primary key constraint refund_pk added successfully ✅');
        
    -- Add foreign key constraint
      execute immediate 'ALTER TABLE refund ADD CONSTRAINT refund_payment_fk FOREIGN KEY ( payment_payment_id )
        REFERENCES payment ( payment_id )';
      dbms_output.put_line('Foreign key constraint refund_payment_fk added successfully ✅');
   exception
      when others then
         dbms_output.put_line('FAILED TO CREATE TABLE aircraft or add primary key or foreign key ❌');
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
                flight_schedule_id   INTEGER NOT NULL,
                departure_airport    VARCHAR2(30) NOT NULL,
                scheduled_dep_time   DATE NOT NULL,
                actual_dep_time      DATE NOT NULL,
                arrival_airport      VARCHAR2(30) NOT NULL,
                scheduled_arr_time   DATE NOT NULL,
                actual_arr_time      DATE NOT NULL,
                flight_status        VARCHAR2(15) CHECK (flight_status IN (''scheduled'',''ontime'',''delayed'',''cancelled''))NOT NULL,
                aircraft_aircraft_id INTEGER NOT NULL,
                routes_route_id      INTEGER NOT NULL,
                created_at           DATE NOT NULL,
                updated_at           DATE NOT NULL
            )';
      dbms_output.put_line('Table flight_schedule CREATED SUCCESSFULLY ✅');
        
        -- Add primary key constraint
      execute immediate 'ALTER TABLE flight_schedule ADD CONSTRAINT fs_pk PRIMARY KEY ( flight_schedule_id )';
      dbms_output.put_line('Primary key constraint fs_pk added successfully ✅');

        -- Add foreign key constraint
      execute immediate 'ALTER TABLE flight_schedule ADD CONSTRAINT fs_aircraft_fk FOREIGN KEY ( aircraft_aircraft_id )
        REFERENCES aircraft ( aircraft_id )';
      dbms_output.put_line('Foreign key constraint fs_aircraft_fk added successfully ✅');
      execute immediate 'ALTER TABLE flight_schedule ADD CONSTRAINT fs_routes_fk FOREIGN KEY ( routes_route_id )
        REFERENCES route ( route_id )';
      dbms_output.put_line('Foreign key constraint fs_routes_fk added successfully ✅');
   exception
      when others then
         dbms_output.put_line('FAILED TO CREATE TABLE flight_schedule or add primary key or foreign key ❌');
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
                main_record_id   INTEGER NOT NULL,
                main_record_date DATE NOT NULL,
                main_record_type VARCHAR2(15) CHECK (main_record_type IN (''cleaning'',''routine'',''repairs'',''inspection'')) NOT NULL,
                main_record_description VARCHAR2 (5)  NOT NULL,
                aircraft_aircraft_id INTEGER NOT NULL,
                employee_employee_id INTEGER NOT NULL,
                inventory_inventory_id INTEGER NOT NULL,
                ms_main_schedule_id INTEGER NOT NULL,
                created_at DATE NOT NULL,
                updated_at DATE NOT NULL
            )';
      dbms_output.put_line('Table maintenance_record CREATED SUCCESSFULLY ✅');
        
        -- Add primary key constraint
      execute immediate 'ALTER TABLE maintenance_record ADD CONSTRAINT mr_pk PRIMARY KEY ( main_record_id )';
      dbms_output.put_line('Primary key constraint mr_pk added successfully ✅');

        -- Add foreign key constraint
      execute immediate 'ALTER TABLE maintenance_record ADD CONSTRAINT mr_aircraft_fk FOREIGN KEY ( aircraft_aircraft_id )
        REFERENCES aircraft ( aircraft_id )';
      dbms_output.put_line('Foreign key constraint mr_aircraft_fk added successfully ✅');
      execute immediate 'ALTER TABLE maintenance_record ADD CONSTRAINT mr_employee_fk FOREIGN KEY ( employee_employee_id )
        REFERENCES employee ( employee_id )';
      dbms_output.put_line('Foreign key constraint mr_employee_fk added successfully ✅');
      execute immediate 'ALTER TABLE maintenance_record ADD CONSTRAINT mr_inventory_fk FOREIGN KEY ( inventory_inventory_id )
        REFERENCES inventory ( inventory_id )';
      dbms_output.put_line('Foreign key constraint mr_inventory_fk added successfully ✅');
      execute immediate 'ALTER TABLE maintenance_record ADD CONSTRAINT mr_ms_fk FOREIGN KEY ( ms_main_schedule_id )
        REFERENCES maintenance_schedule ( main_schedule_id )';
      dbms_output.put_line('Foreign key constraint mr_pk added successfully ✅');
   exception
      when others then
         dbms_output.put_line('FAILED TO CREATE TABLE maintenance_record or add primary key or foreign key ❌');
   end;

end;

-- Ground Operation(Ops) Table


/
declare
   table_exists number;
begin
     -- Check if the table exists
   select count(*)
     into table_exists
     from user_tables
    where lower(table_name) = 'ground_ops_schedule';

   if table_exists > 0 then
      begin
         execute immediate 'DROP TABLE ground_ops_schedule CASCADE constraints';
         dbms_output.put_line('Table ground_ops_schedule DROPPED SUCCESSFULLY ✅');
      exception
         when others then
            dbms_output.put_line('FAILED TO DROP TABLE ground_ops_schedule ❌');
      end;
   end if;

    -- Create the table
   begin
      execute immediate '
            CREATE TABLE ground_ops_schedule (
                ops_schedule_id        INTEGER NOT NULL,
                employee_employee_id   INTEGER NOT NULL,
                mr_main_record_id      INTEGER NOT NULL,
                inventory_inventory_id INTEGER NOT NULL,
                created_at             DATE NOT NULL,
                updated_at             DATE NOT NULL
            )';
      dbms_output.put_line('Table ground_ops_schedule CREATED SUCCESSFULLY ✅');
        
        -- Add primary key constraint
      execute immediate 'ALTER TABLE ground_ops_schedule ADD CONSTRAINT gos_pk PRIMARY KEY ( ops_schedule_id )';
      dbms_output.put_line('Primary key constraint gos_pk added successfully ✅');
        
        -- Add foreign key constraint
      execute immediate 'ALTER TABLE ground_ops_schedule ADD CONSTRAINT gos_employee_fk FOREIGN KEY ( employee_employee_id )
        REFERENCES employee ( employee_id )';
      dbms_output.put_line('Foreign key constraint gos_employee_fk added successfully ✅');
      execute immediate 'ALTER TABLE ground_ops_schedule ADD CONSTRAINT gos_inventory_fk FOREIGN KEY ( inventory_inventory_id )
        REFERENCES inventory ( inventory_id )';
      dbms_output.put_line('Foreign key constraint gos_inventory_fk added successfully ✅');
      execute immediate 'ALTER TABLE ground_ops_schedule ADD CONSTRAINT gos_mr_fk FOREIGN KEY ( mr_main_record_id )
        REFERENCES maintenance_record ( main_record_id )';
      dbms_output.put_line('Foreign key constraint gos_mr_fk added successfully ✅');
   exception
      when others then
         dbms_output.put_line('FAILED TO CREATE TABLE ground_ops_schedule or add primary key or foreign key ❌');
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
                    seat_id               INTEGER NOT NULL,
                    seat_type             VARCHAR2(10) NOT NULL,
                    seat_class            VARCHAR2(20) NOT NULL,
                    is_available          CHAR(1) NOT NULL,
                    fs_flight_schedule_id INTEGER NOT NULL,
                    created_at            DATE NOT NULL,
                    updated_at            DATE NOT NULL
            )';
      dbms_output.put_line('Table seat CREATED SUCCESSFULLY ✅');
        
        -- Add primary key constraint
      execute immediate 'ALTER TABLE seat ADD CONSTRAINT seat_pk PRIMARY KEY ( seat_id )';
      dbms_output.put_line('Primary key constraint seat_pk added successfully ✅');
      execute immediate 'ALTER TABLE seat ADD CONSTRAINT seat_fs_fk FOREIGN KEY ( fs_flight_schedule_id )
        REFERENCES flight_schedule ( flight_schedule_id )';
      dbms_output.put_line('Foreign key constraint seat_fs_fk added successfully ✅');
   exception
      when others then
         dbms_output.put_line('FAILED TO CREATE TABLE seat or add primary key or foreign key ❌');
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
                reservation_id         INTEGER NOT NULL,
                travel_date            DATE NOT NULL,
                reservation_status     VARCHAR2(15) CHECK (reservation_status IN (''pending'',''confirmed'',''partial'',''cancelled'')) NOT NULL,
                created_at             DATE NOT NULL,
                updated_at             DATE NOT NULL,
                airfare                NUMBER(10, 2) NOT NULL,
                seat_number            VARCHAR2(5) NOT NULL,
                passenger_passenger_id INTEGER NOT NULL,
                seat_seat_id           INTEGER NOT NULL,
                pnr                    VARCHAR2(6) NOT NULL,
                start_date             DATE NOT NULL,
                end_date               DATE NOT NULL
            )';
      dbms_output.put_line('Table reservation CREATED SUCCESSFULLY ✅');
        
    -- Add primary key constraint
      execute immediate 'ALTER TABLE reservation ADD CONSTRAINT reservation_pk PRIMARY KEY ( reservation_id )';
      dbms_output.put_line('Primary key constraint reservation_pk added successfully ✅');
    
    -- Add foreign key constraint
      execute immediate 'ALTER TABLE reservation ADD CONSTRAINT reservation_seat_fk FOREIGN KEY ( seat_seat_id )
        REFERENCES seat ( seat_id )';
      dbms_output.put_line('Foreign key constraint reservation_seat_fk added successfully ✅');
      execute immediate 'ALTER TABLE reservation ADD CONSTRAINT reservation_passenger_fk FOREIGN KEY ( passenger_passenger_id )
        REFERENCES passenger ( passenger_id )';
      dbms_output.put_line('Foreign key constraint reservation_passenger_fk added successfully ✅');
   exception
      when others then
         dbms_output.put_line('FAILED TO CREATE TABLE reservation or add primary key or foreign key ❌');
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
                baggage_id             INTEGER NOT NULL,
                baggage_weight         NUMBER(4, 2) NOT NULL,
                baggage_status         VARCHAR2(20) NOT NULL,
                reservation_reservation_id INTEGER NOT NULL,
                created_at             DATE NOT NULL,
                updated_at             DATE NOT NULL
            )';
      dbms_output.put_line('Table baggage CREATED SUCCESSFULLY ✅');
        
        -- Add primary key constraint
      execute immediate 'ALTER TABLE baggage ADD CONSTRAINT baggage_pk PRIMARY KEY ( baggage_id )';
      dbms_output.put_line('Primary key constraint baggage_pk added successfully ✅');
      execute immediate 'ALTER TABLE baggage ADD CONSTRAINT bag_reservation_fk FOREIGN KEY ( reservation_reservation_id )
        REFERENCES reservation ( reservation_id )';
      dbms_output.put_line('Foreign key constraint bag_reservation_fk added successfully ✅');
   exception
      when others then
         dbms_output.put_line('FAILED TO CREATE TABLE baggage or add primary key or foreign key ❌');
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
                    assignment_id         INTEGER NOT NULL,
                    assignment_date       DATE NOT NULL,
                    assignment_role       VARCHAR2(15) NOT NULL,
                    fs_flight_schedule_id INTEGER NOT NULL,
                    employee_employee_id  INTEGER NOT NULL,
                    created_at            DATE NOT NULL,
                    updated_at            DATE NOT NULL
                )';
      dbms_output.put_line('Table crew_assignment CREATED SUCCESSFULLY ✅');
        
        -- Add primary key constraint
      execute immediate 'ALTER TABLE crew_assignment ADD CONSTRAINT ca_pk PRIMARY KEY ( assignment_id )';
      dbms_output.put_line('Primary key constraint ca_pk added successfully ✅');

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
                payment_payment_id         INTEGER NOT NULL,
                reservation_reservation_id INTEGER NOT NULL,
                created_at            DATE NOT NULL,
                updated_at            DATE NOT NULL
            )';
      dbms_output.put_line('Table reservation_payment CREATED SUCCESSFULLY ✅');
        
        -- Add primary key constraint
      execute immediate 'ALTER TABLE reservation_payment ADD CONSTRAINT reservation_payment_pk PRIMARY KEY 
        ( payment_payment_id,reservation_reservation_id )';
      dbms_output.put_line('Primary key constraint reservation_payment_pk added successfully ✅'); 

        -- Add foreign key constraint
      execute immediate 'ALTER TABLE reservation_payment ADD CONSTRAINT res_pay_payment_fk FOREIGN KEY ( payment_payment_id )
        REFERENCES payment ( payment_id )';
      dbms_output.put_line('Foreign key constraint res_pay_payment_fk added successfully ✅');
      execute immediate 'ALTER TABLE reservation_payment ADD CONSTRAINT res_pay_reservation_fk FOREIGN KEY ( reservation_reservation_id )
        REFERENCES reservation ( reservation_id )';
      dbms_output.put_line('Foreign key constraint res_pay_reservation_fk added successfully ✅');
   exception
      when others then
         dbms_output.put_line('FAILED TO CREATE TABLE reservation_payment or add primary key or foreign key ❌');
   end;
end;
/
