/*
================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================
*/

begin
   -- GRANT ACCESS TO PASSENGER
   grant_access_to_user('PASSENGER','CONNECT, CREATE ANY VIEW, CREATE ANY PROCEDURE', null);
   -- Grant access to tables
   grant_access_to_user('PASSENGER', 'SELECT', 'FLIGHT_SCHEDULE');
   grant_access_to_user('PASSENGER', 'SELECT, UPDATE', 'SEAT');
   grant_access_to_user('PASSENGER', 'SELECT', 'ROUTE');
   grant_access_to_user('PASSENGER', 'SELECT, INSERT', 'PAYMENT');
   grant_access_to_user('PASSENGER', 'SELECT, INSERT', 'REFUND');
   grant_access_to_user('PASSENGER', 'SELECT, INSERT, UPDATE', 'RESERVATION');
   grant_access_to_user('PASSENGER', 'SELECT, INSERT', 'RESERVATION_PAYMENT');
   grant_access_to_user('PASSENGER', 'SELECT, INSERT, UPDATE', 'PASSENGER');
   grant_access_to_user('PASSENGER', 'SELECT, INSERT', 'BAGGAGE');
   grant_access_to_user('PASSENGER', 'SELECT', 'WALLET');

   -- GRANT ACCESS TO FLIGHT_OPERATION_MANAGER
   grant_access_to_user('FLIGHT_OPERATION_MANAGER','CONNECT, CREATE ANY VIEW, CREATE ANY PROCEDURE', null);
   grant_access_to_user('FLIGHT_OPERATION_MANAGER', 'SELECT', 'AIRCRAFT');
   grant_access_to_user('FLIGHT_OPERATION_MANAGER', 'SELECT, INSERT, UPDATE, DELETE', 'FLIGHT_SCHEDULE');
   grant_access_to_user('FLIGHT_OPERATION_MANAGER', 'SELECT, INSERT, UPDATE, DELETE', 'ROUTE');
   grant_access_to_user('FLIGHT_OPERATION_MANAGER', 'SELECT', 'EMPLOYEE');
   grant_access_to_user('FLIGHT_OPERATION_MANAGER', 'SELECT, INSERT, UPDATE, DELETE', 'CREW_ASSIGNMENT');
   grant_access_to_user('FLIGHT_OPERATION_MANAGER', 'SELECT', 'MAINTENANCE_SCHEDULE');
   grant_access_to_user('FLIGHT_OPERATION_MANAGER', 'SELECT', 'MAINTENANCE_RECORD');
   grant_access_to_user('FLIGHT_OPERATION_MANAGER', 'SELECT', 'RESERVATION');
   grant_access_to_user('FLIGHT_OPERATION_MANAGER', 'SELECT', 'SEAT');
   -- grant_access_to_user('FLIGHT_OPERATION_MANAGER', 'SELECT', 'GROUND_OPS_SCHEDULE');

   -- GRANT ACCESS TO INVENTORY_MANAGER
   grant_access_to_user('INVENTORY_MANAGER','CONNECT, CREATE ANY VIEW, CREATE ANY PROCEDURE', null);
   grant_access_to_user('INVENTORY_MANAGER', 'SELECT', 'AIRCRAFT');
   grant_access_to_user('INVENTORY_MANAGER', 'SELECT, INSERT, UPDATE, DELETE', 'INVENTORY');
   grant_access_to_user('INVENTORY_MANAGER', 'SELECT, INSERT, UPDATE, DELETE', 'INVENTORY_ORDER');
   grant_access_to_user('INVENTORY_MANAGER', 'SELECT', 'MAINTENANCE_SCHEDULE');
   grant_access_to_user('INVENTORY_MANAGER', 'SELECT', 'MAINTENANCE_RECORD');
   -- grant_access_to_user('INVENTORY_MANAGER', 'SELECT', 'GROUND_OPS_SCHEDULE');

   -- GRANT ACCESS TO GROUND_OPERATION_MANAGER
   grant_access_to_user('GROUND_OPERATION_MANAGER','CONNECT, CREATE ANY VIEW, CREATE ANY PROCEDURE', null);
   grant_access_to_user('GROUND_OPERATION_MANAGER', 'SELECT', 'INVENTORY');
   grant_access_to_user('GROUND_OPERATION_MANAGER', 'SELECT', 'RESERVATION');
   grant_access_to_user('GROUND_OPERATION_MANAGER', 'SELECT', 'SEAT');
   grant_access_to_user('GROUND_OPERATION_MANAGER', 'SELECT, UPDATE', 'FLIGHT_SCHEDULE');
   grant_access_to_user('GROUND_OPERATION_MANAGER', 'SELECT', 'MAINTENANCE_SCHEDULE');
   grant_access_to_user('GROUND_OPERATION_MANAGER', 'SELECT, INSERT, UPDATE', 'MAINTENANCE_RECORD');
   -- grant_access_to_user('GROUND_OPERATION_MANAGER', 'SELECT, INSERT, UPDATE, DELETE', 'GROUND_OPS_SCHEDULE');
   grant_access_to_user('GROUND_OPERATION_MANAGER', 'SELECT, UPDATE', 'BAGGAGE');
   grant_access_to_user('GROUND_OPERATION_MANAGER', 'SELECT', 'SEAT');

   -- GRANT ACCESS TO CREW_MANAGER
   grant_access_to_user('CREW_MANAGER','CONNECT, CREATE ANY VIEW, CREATE ANY PROCEDURE', null);
   grant_access_to_user('CREW_MANAGER', 'SELECT', 'FLIGHT_SCHEDULE');
   grant_access_to_user('CREW_MANAGER', 'SELECT', 'ROUTE');
   grant_access_to_user('CREW_MANAGER', 'SELECT', 'EMPLOYEE');
   grant_access_to_user('CREW_MANAGER', 'SELECT, INSERT, UPDATE, DELETE', 'CREW_ASSIGNMENT');

   -- GRANT ACCESS TO MAINTENANCE_MANAGER
   grant_access_to_user('MAINTENANCE_MANAGER','CONNECT, CREATE ANY VIEW, CREATE ANY PROCEDURE', null);
   grant_access_to_user('MAINTENANCE_MANAGER', 'SELECT', 'AIRCRAFT');
   grant_access_to_user('MAINTENANCE_MANAGER', 'SELECT', 'FLIGHT_SCHEDULE');
   grant_access_to_user('MAINTENANCE_MANAGER', 'SELECT', 'EMPLOYEE');
   grant_access_to_user('MAINTENANCE_MANAGER', 'SELECT', 'INVENTORY');
   grant_access_to_user('MAINTENANCE_MANAGER', 'SELECT, INSERT, UPDATE, DELETE', 'INVENTORY_ORDER');
   grant_access_to_user('MAINTENANCE_MANAGER', 'SELECT, INSERT, UPDATE, DELETE', 'MAINTENANCE_SCHEDULE');
   grant_access_to_user('MAINTENANCE_MANAGER', 'SELECT, INSERT, UPDATE, DELETE', 'MAINTENANCE_RECORD');
   -- grant_access_to_user('MAINTENANCE_MANAGER', 'SELECT', 'GROUND_OPS_SCHEDULE');

   -- GRANT ACCESS TO HR_MANAGER
   grant_access_to_user('HR_MANAGER','CONNECT, CREATE ANY VIEW, CREATE ANY PROCEDURE', null);
   grant_access_to_user('HR_MANAGER', 'SELECT, INSERT, UPDATE, DELETE', 'EMPLOYEE');

   -- GRANT ACCESS TO DATA_ANALYST
   grant_access_to_user('DATA_ANALYST','CONNECT, CREATE ANY VIEW', null);
   grant_access_to_user('DATA_ANALYST', 'SELECT', 'AIRCRAFT');
   grant_access_to_user('DATA_ANALYST', 'SELECT', 'BAGGAGE');
   grant_access_to_user('DATA_ANALYST', 'SELECT', 'CREW_ASSIGNMENT');
   grant_access_to_user('DATA_ANALYST', 'SELECT', 'EMPLOYEE');
   grant_access_to_user('DATA_ANALYST', 'SELECT', 'FLIGHT_SCHEDULE');
   -- grant_access_to_user('DATA_ANALYST', 'SELECT', 'GROUND_OPS_SCHEDULE');
   grant_access_to_user('DATA_ANALYST', 'SELECT', 'INVENTORY');
   grant_access_to_user('DATA_ANALYST', 'SELECT', 'INVENTORY_ORDER');
   grant_access_to_user('DATA_ANALYST', 'SELECT', 'MAINTENANCE_RECORD');
   grant_access_to_user('DATA_ANALYST', 'SELECT', 'MAINTENANCE_SCHEDULE');
   grant_access_to_user('DATA_ANALYST', 'SELECT', 'PASSENGER');
   grant_access_to_user('DATA_ANALYST', 'SELECT', 'PAYMENT');
   grant_access_to_user('DATA_ANALYST', 'SELECT', 'REFUND');
   grant_access_to_user('DATA_ANALYST', 'SELECT', 'RESERVATION');
   grant_access_to_user('DATA_ANALYST', 'SELECT', 'RESERVATION_PAYMENT');
   grant_access_to_user('DATA_ANALYST', 'SELECT', 'ROUTE');
   grant_access_to_user('DATA_ANALYST', 'SELECT', 'SEAT');
   grant_access_to_user('DATA_ANALYST', 'SELECT', 'WALLET');
end;
/
