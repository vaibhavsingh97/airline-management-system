-- Below tables dependent on single table

-- Inventory_Order Table
SET SERVEROUTPUT ON
/
DECLARE
   TABLE_EXISTS NUMBER;
BEGIN
    SELECT COUNT(*) 
    INTO TABLE_EXISTS
    FROM USER_TABLES
    WHERE TABLE_NAME = 'inventory_order';
    
    IF TABLE_EXISTS > 0
    THEN 
        EXECUTE IMMEDIATE 'DROP TABLE inventory_order CASCADE';
        DBMS_OUTPUT.PUT_LINE('Table inventory_order DROPPED SUCCESSFULLY');
    END IF;
    
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('FAILED TO DROP TABLE inventory_order');
END;
/

CREATE TABLE inventory_order (
    order_id               INTEGER NOT NULL,
    order_date             DATE NOT NULL,
    order_quantity         INTEGER NOT NULL,
    order_amount           NUMBER(10, 2) NOT NULL,
    order_status           VARCHAR2(10) CHECK (order_status IN ('pending','fulfilled','failed')) NOT NULL,
    supplier_name          VARCHAR2(20) NOT NULL,
    inventory_inventory_id INTEGER,
    created_at             DATE NOT NULL,
    updated_at             DATE NOT NULL
);

ALTER TABLE inventory_order ADD CONSTRAINT io_pk PRIMARY KEY ( order_id );
ALTER TABLE inventory_order
    ADD CONSTRAINT io_inventory_fk FOREIGN KEY ( inventory_inventory_id )
        REFERENCES inventory ( inventory_id );

-- Passenger Table
SET SERVEROUTPUT ON
/
DECLARE
   TABLE_EXISTS NUMBER;
BEGIN
    SELECT COUNT(*) 
    INTO TABLE_EXISTS
    FROM USER_TABLES
    WHERE TABLE_NAME = 'passenger';
    
    IF TABLE_EXISTS > 0
    THEN 
        EXECUTE IMMEDIATE 'DROP TABLE passenger CASCADE';
        DBMS_OUTPUT.PUT_LINE('Table passenger DROPPED SUCCESSFULLY');
    END IF;
    
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('FAILED TO DROP TABLE passenger');
END;
/

CREATE TABLE passenger (
    passenger_id     INTEGER NOT NULL,
    pass_first_name  VARCHAR2(20) NOT NULL,
    pass_last_name   VARCHAR2(20) NOT NULL,
    pass_email       VARCHAR2(50) NOT NULL,
    pass_phone       NUMBER(10) NOT NULL,
    gender           VARCHAR2(10) CHECK (gender IN ('Male','Female','Others')) NOT NULL,
    dob              DATE NOT NULL,
    seat_preference  VARCHAR2(10) CHECK (seat_preference IN ('Window','Middle','Aisle')) NOT NULL,
    wallet_wallet_id VARCHAR2(10) ,
    created_at       DATE NOT NULL,
    updated_at       DATE
);
ALTER TABLE passenger ADD CONSTRAINT passenger_pk PRIMARY KEY ( passenger_id );
ALTER TABLE passenger ADD CONSTRAINT chk_pass_email_format 
    CHECK (REGEXP_LIKE(pass_email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'));
ALTER TABLE passenger
    ADD CONSTRAINT wallet_pass_fk FOREIGN KEY ( wallet_wallet_id )
        REFERENCES wallet ( wallet_id );

-- Refund Table
SET SERVEROUTPUT ON
/
DECLARE
   TABLE_EXISTS NUMBER;
BEGIN
    SELECT COUNT(*) 
    INTO TABLE_EXISTS
    FROM USER_TABLES
    WHERE TABLE_NAME = 'refund';
    
    IF TABLE_EXISTS > 0
    THEN 
        EXECUTE IMMEDIATE 'DROP TABLE refund CASCADE';
        DBMS_OUTPUT.PUT_LINE('Table refund DROPPED SUCCESSFULLY');
    END IF;
    
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('FAILED TO DROP TABLE refund');
END;
/

CREATE TABLE refund (
    refund_id          INTEGER NOT NULL,
    refund_amount      NUMBER(10, 2) NOT NULL,
    refund_reason      VARCHAR2(50),
    payment_payment_id INTEGER,
    created_at         DATE NOT NULL,
    updated_at         DATE NOT NULL
);

ALTER TABLE refund ADD CONSTRAINT refund_pk PRIMARY KEY ( refund_id );
ALTER TABLE refund
    ADD CONSTRAINT refund_payment_fk FOREIGN KEY ( payment_payment_id )
        REFERENCES payment ( payment_id );

-- Tables below depends on >=2 tables
-- Flight Schedule Table

SET SERVEROUTPUT ON
/
DECLARE
   TABLE_EXISTS NUMBER;
BEGIN
    SELECT COUNT(*) 
    INTO TABLE_EXISTS
    FROM USER_TABLES
    WHERE TABLE_NAME = 'flight_schedule';
    
    IF TABLE_EXISTS > 0
    THEN 
        EXECUTE IMMEDIATE 'DROP TABLE flight_schedule CASCADE';
        DBMS_OUTPUT.PUT_LINE('Table flight_schedule DROPPED SUCCESSFULLY');
    END IF;
    
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('FAILED TO DROP TABLE flight_schedule');
END;
/

CREATE TABLE flight_schedule (
    flight_schedule_id   INTEGER NOT NULL,
    departure_airport    VARCHAR2(30) NOT NULL,
    scheduled_dep_time   DATE NOT NULL,
    actual_dep_time      DATE NOT NULL,
    arrival_airport      VARCHAR2(30) NOT NULL,
    scheduled_arr_time   DATE NOT NULL,
    actual_arr_time      DATE NOT NULL,
    flight_status        VARCHAR2(15) CHECK (flight_status IN ('scheduled','ontime','delayed','cancelled'))NOT NULL,
    aircraft_aircraft_id INTEGER,
    routes_route_id      INTEGER,
    created_at           DATE NOT NULL,
    updated_at           DATE NOT NULL
);

ALTER TABLE flight_schedule ADD CONSTRAINT fs_pk PRIMARY KEY ( flight_schedule_id );
ALTER TABLE flight_schedule
    ADD CONSTRAINT fs_aircraft_fk FOREIGN KEY ( aircraft_aircraft_id )
        REFERENCES aircraft ( aircraft_id );

ALTER TABLE flight_schedule
    ADD CONSTRAINT fs_routes_fk FOREIGN KEY ( routes_route_id )
        REFERENCES routes ( route_id );

-- Baggage Table

SET SERVEROUTPUT ON
/
DECLARE
   TABLE_EXISTS NUMBER;
BEGIN
    SELECT COUNT(*) 
    INTO TABLE_EXISTS
    FROM USER_TABLES
    WHERE TABLE_NAME = 'baggage';
    
    IF TABLE_EXISTS > 0
    THEN 
        EXECUTE IMMEDIATE 'DROP TABLE baggage CASCADE';
        DBMS_OUTPUT.PUT_LINE('Table baggage DROPPED SUCCESSFULLY');
    END IF;
    
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('FAILED TO DROP TABLE baggage');
END;
/

CREATE TABLE baggage (
    baggage_id             INTEGER NOT NULL,
    baggage_weight         NUMBER(4, 2) NOT NULL,
    baggage_status         VARCHAR2(20) NOT NULL,
    passenger_passenger_id INTEGER,
    fs_flight_schedule_id  INTEGER,
    created_at             DATE NOT NULL,
    updated_at             DATE NOT NULL
);

ALTER TABLE baggage ADD CONSTRAINT baggage_pk PRIMARY KEY ( baggage_id );
ALTER TABLE baggage
    ADD CONSTRAINT baggage_fs_fk FOREIGN KEY ( fs_flight_schedule_id )
        REFERENCES flight_schedule ( flight_schedule_id );

ALTER TABLE baggage
    ADD CONSTRAINT baggage_passenger_fk FOREIGN KEY ( passenger_passenger_id )
        REFERENCES passenger ( passenger_id );

-- Maintenance Record Table

SET SERVEROUTPUT ON
/
DECLARE
   TABLE_EXISTS NUMBER;
BEGIN
    SELECT COUNT(*) 
    INTO TABLE_EXISTS
    FROM USER_TABLES
    WHERE TABLE_NAME = 'maintenance_record';
    
    IF TABLE_EXISTS > 0
    THEN 
        EXECUTE IMMEDIATE 'DROP TABLE maintenance_record CASCADE';
        DBMS_OUTPUT.PUT_LINE('Table maintenance_record DROPPED SUCCESSFULLY');
    END IF;
    
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('FAILED TO DROP TABLE maintenance_record');
END;
/

CREATE TABLE maintenance_record 
    (
    main_record_id   INTEGER NOT NULL,
    main_record_date DATE NOT NULL,
    main_record_type VARCHAR2(15) CHECK (main_record_type IN ('cleaning','routine','repairs','inspection')) NOT NULL,
    main_record_description VARCHAR2 (5)  NOT NULL,
    aircraft_aircraft_id INTEGER,
    employee_employee_id INTEGER,
    inventory_inventory_id INTEGER,
    ms_main_schedule_id INTEGER,
    created_at DATE NOT NULL,
    updated_at DATE NOT NULL
) 
;

ALTER TABLE maintenance_record ADD CONSTRAINT mr_pk PRIMARY KEY ( main_record_id );
ALTER TABLE maintenance_record
    ADD CONSTRAINT mr_aircraft_fk FOREIGN KEY ( aircraft_aircraft_id )
        REFERENCES aircraft ( aircraft_id );

ALTER TABLE maintenance_record
    ADD CONSTRAINT mr_employee_fk FOREIGN KEY ( employee_employee_id )
        REFERENCES employee ( employee_id );

ALTER TABLE maintenance_record
    ADD CONSTRAINT mr_inventory_fk FOREIGN KEY ( inventory_inventory_id )
        REFERENCES inventory ( inventory_id );

ALTER TABLE maintenance_record
    ADD CONSTRAINT mr_ms_fk FOREIGN KEY ( ms_main_schedule_id )
        REFERENCES maintenance_schedule ( main_schedule_id );

-- Ground Operation(Ops) Table
SET SERVEROUTPUT ON
/
DECLARE
   TABLE_EXISTS NUMBER;
BEGIN
    SELECT COUNT(*) 
    INTO TABLE_EXISTS
    FROM USER_TABLES
    WHERE TABLE_NAME = 'ground_ops_schedule';
    
    IF TABLE_EXISTS > 0
    THEN 
        EXECUTE IMMEDIATE 'DROP TABLE ground_ops_schedule CASCADE';
        DBMS_OUTPUT.PUT_LINE('Table ground_ops_schedule DROPPED SUCCESSFULLY');
    END IF;
    
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('FAILED TO DROP TABLE ground_ops_schedule');
END;
/

CREATE TABLE ground_ops_schedule (
    ops_schedule_id        INTEGER NOT NULL,
    employee_employee_id   INTEGER,
    mr_main_record_id      INTEGER,
    inventory_inventory_id INTEGER,
    created_at             DATE NOT NULL,
    updated_at             DATE NOT NULL
);

ALTER TABLE ground_ops_schedule ADD CONSTRAINT gos_pk PRIMARY KEY ( ops_schedule_id );

ALTER TABLE ground_ops_schedule
    ADD CONSTRAINT gos_employee_fk FOREIGN KEY ( employee_employee_id )
        REFERENCES employee ( employee_id );

ALTER TABLE ground_ops_schedule
    ADD CONSTRAINT gos_inventory_fk FOREIGN KEY ( inventory_inventory_id )
        REFERENCES inventory ( inventory_id );

ALTER TABLE ground_ops_schedule
    ADD CONSTRAINT gos_mr_fk FOREIGN KEY ( mr_main_record_id )
        REFERENCES maintenance_record ( main_record_id );

-- Passenger Flight Schedule Table
SET SERVEROUTPUT ON
/
DECLARE
   TABLE_EXISTS NUMBER;
BEGIN
    SELECT COUNT(*) 
    INTO TABLE_EXISTS
    FROM USER_TABLES
    WHERE TABLE_NAME = 'ground_ops_schedule';
    
    IF TABLE_EXISTS > 0
    THEN 
        EXECUTE IMMEDIATE 'DROP TABLE ground_ops_schedule CASCADE';
        DBMS_OUTPUT.PUT_LINE('Table ground_ops_schedule DROPPED SUCCESSFULLY');
    END IF;
    
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('FAILED TO DROP TABLE ground_ops_schedule');
END;
/

CREATE TABLE passenger_flight_schedule (
    pass_flight_status_id  INTEGER NOT NULL,
    pass_flight_status     VARCHAR2(15) NOT NULL,
    passenger_passenger_id INTEGER ,
    fs_flight_schedule_id  INTEGER ,
    created_at             DATE NOT NULL,
    updated_at             DATE NOT NULL
);

ALTER TABLE passenger_flight_schedule ADD CONSTRAINT pfs_pk PRIMARY KEY ( pass_flight_status_id );

ALTER TABLE passenger_flight_schedule
    ADD CONSTRAINT pfs_fs_fk FOREIGN KEY ( fs_flight_schedule_id )
        REFERENCES flight_schedule ( flight_schedule_id );

ALTER TABLE passenger_flight_schedule
    ADD CONSTRAINT pfs_passenger_fk FOREIGN KEY ( passenger_passenger_id )
        REFERENCES passenger ( passenger_id );

-- Seat Table
SET SERVEROUTPUT ON
/
DECLARE
   TABLE_EXISTS NUMBER;
BEGIN
    SELECT COUNT(*) 
    INTO TABLE_EXISTS
    FROM USER_TABLES
    WHERE TABLE_NAME = 'seat';
    
    IF TABLE_EXISTS > 0
    THEN 
        EXECUTE IMMEDIATE 'DROP TABLE seat CASCADE';
        DBMS_OUTPUT.PUT_LINE('Table seat DROPPED SUCCESSFULLY');
    END IF;
    
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('FAILED TO DROP TABLE seat');
END;
/

CREATE TABLE seat (
    seat_id               INTEGER NOT NULL,
    seat_type             VARCHAR2(10) NOT NULL,
    seat_class            VARCHAR2(20) NOT NULL,
    is_available          CHAR(1) NOT NULL,
    fs_flight_schedule_id INTEGER,
    created_at            DATE NOT NULL,
    updated_at            DATE NOT NULL
);

ALTER TABLE seat ADD CONSTRAINT seat_pk PRIMARY KEY ( seat_id );

ALTER TABLE seat
    ADD CONSTRAINT seat_fs_fk FOREIGN KEY ( fs_flight_schedule_id )
        REFERENCES flight_schedule ( flight_schedule_id );

-- Reservation Table
SET SERVEROUTPUT ON
/
DECLARE
   TABLE_EXISTS NUMBER;
BEGIN
    SELECT COUNT(*) 
    INTO TABLE_EXISTS
    FROM USER_TABLES
    WHERE TABLE_NAME = 'reservation';
    
    IF TABLE_EXISTS > 0
    THEN 
        EXECUTE IMMEDIATE 'DROP TABLE reservation CASCADE';
        DBMS_OUTPUT.PUT_LINE('Table reservation DROPPED SUCCESSFULLY');
    END IF;
    
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('FAILED TO DROP TABLE reservation');
END;
/

CREATE TABLE reservation (
    reservation_id         INTEGER NOT NULL,
    travel_date            DATE NOT NULL,
    reservation_status     VARCHAR2(15) CHECK (reservation_status IN ('pending','confirmed','partial','cancelled')) NOT NULL,
    created_at             DATE NOT NULL,
    updated_at             DATE NOT NULL,
    airfare                NUMBER(10, 2) NOT NULL,
    seat_number            VARCHAR2(5) NOT NULL,
    passenger_passenger_id INTEGER,
    fs_flight_schedule_id  INTEGER,
    pnr                    VARCHAR2(6) NOT NULL,
    start_date             DATE,
    end_date               DATE
);

ALTER TABLE reservation ADD CONSTRAINT reservation_pk PRIMARY KEY ( reservation_id );

ALTER TABLE reservation
    ADD CONSTRAINT reservation_fs_fk FOREIGN KEY ( fs_flight_schedule_id )
        REFERENCES flight_schedule ( flight_schedule_id );

ALTER TABLE reservation
    ADD CONSTRAINT reservation_passenger_fk FOREIGN KEY ( passenger_passenger_id )
        REFERENCES passenger ( passenger_id );

-- Crew Assignment Table
SET SERVEROUTPUT ON
/
DECLARE
   TABLE_EXISTS NUMBER;
BEGIN
    SELECT COUNT(*) 
    INTO TABLE_EXISTS
    FROM USER_TABLES
    WHERE TABLE_NAME = 'reservation';
    
    IF TABLE_EXISTS > 0
    THEN 
        EXECUTE IMMEDIATE 'DROP TABLE reservation CASCADE';
        DBMS_OUTPUT.PUT_LINE('Table reservation DROPPED SUCCESSFULLY');
    END IF;
    
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('FAILED TO DROP TABLE reservation');
END;
/

CREATE TABLE crew_assignment (
    assignment_id         INTEGER NOT NULL,
    assignment_date       DATE NOT NULL,
    assignment_role       VARCHAR2(15) NOT NULL,
    fs_flight_schedule_id INTEGER,
    employee_employee_id  INTEGER,
    created_at            DATE NOT NULL,
    updated_at            DATE NOT NULL
);

ALTER TABLE crew_assignment ADD CONSTRAINT ca_pk PRIMARY KEY ( assignment_id );

ALTER TABLE crew_assignment
    ADD CONSTRAINT ca_employee_fk FOREIGN KEY ( employee_employee_id )
        REFERENCES employee ( employee_id );

ALTER TABLE crew_assignment
    ADD CONSTRAINT ca_fs_fk FOREIGN KEY ( fs_flight_schedule_id )
        REFERENCES flight_schedule ( flight_schedule_id );

-- Reservation_Payment table (ManyToMany Relation)
SET SERVEROUTPUT ON
/
DECLARE
   TABLE_EXISTS NUMBER;
BEGIN
    SELECT COUNT(*) 
    INTO TABLE_EXISTS
    FROM USER_TABLES
    WHERE TABLE_NAME = 'reservation_payment';
    
    IF TABLE_EXISTS > 0
    THEN 
        EXECUTE IMMEDIATE 'DROP TABLE reservation_payment CASCADE';
        DBMS_OUTPUT.PUT_LINE('Table reservation_payment DROPPED SUCCESSFULLY');
    END IF;
    
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('FAILED TO DROP TABLE reservation_payment');
END;
/

CREATE TABLE reservation_payment (
    payment_payment_id         INTEGER NOT NULL,
    reservation_reservation_id INTEGER NOT NULL
);

ALTER TABLE reservation_payment ADD CONSTRAINT reservation_payment_pk PRIMARY KEY ( payment_payment_id,
                                                                                    reservation_reservation_id );

ALTER TABLE reservation_payment
    ADD CONSTRAINT res_pay_payment_fk FOREIGN KEY ( payment_payment_id )
        REFERENCES payment ( payment_id );

ALTER TABLE reservation_payment
    ADD CONSTRAINT res_pay_reservation_fk FOREIGN KEY ( reservation_reservation_id )
        REFERENCES reservation ( reservation_id );






