/*
================================================
‼️ THIS FILE SHOULD BE RUN BY APP_ADMIN ONLY ‼️
================================================
*/

begin
   -- GRANT ACCESS TO PASSENGER
   grant_access_to_user('PASSENGER', 'SELECT', 'FLIGHT_SCHEDULE');
   grant_access_to_user('PASSENGER', 'SELECT', 'PAYMENT');
   grant_access_to_user('PASSENGER', 'SELECT', 'REFUND');
   grant_access_to_user('PASSENGER', 'SELECT, INSERT, UPDATE', 'PASSENGER');
   grant_access_to_user('PASSENGER', 'SELECT', 'BAGGAGE');
   grant_access_to_user('PASSENGER', 'SELECT', 'WALLET');

   -- GRANT ACCESS TO FLIGHT_OPERATION_MANAGER
   grant_access_to_user('FLIGHT_OPERATION_MANAGER', 'SELECT', 'AIRCRAFT');
   grant_access_to_user('FLIGHT_OPERATION_MANAGER', 'SELECT, INSERT, UPDATE DELETE', 'FLIGHT_SCHEDULE');
   grant_access_to_user('FLIGHT_OPERATION_MANAGER', 'SELECT, INSERT, UPDATE DELETE', 'ROUTE');
   grant_access_to_user('FLIGHT_OPERATION_MANAGER', 'SELECT', 'EMPLOYEE');
   grant_access_to_user('FLIGHT_OPERATION_MANAGER', 'SELECT, INSERT, UPDATE DELETE', 'CREW_ASSIGNMENT');
   grant_access_to_user('FLIGHT_OPERATION_MANAGER', 'SELECT', 'MAINTENANCE_SCHEDULE');
   grant_access_to_user('FLIGHT_OPERATION_MANAGER', 'SELECT', 'MAINTEANCE_RECORD');
   grant_access_to_user('FLIGHT_OPERATION_MANAGER', 'SELECT', 'GROUND_OPS_SCHEDULE');

   -- GRANT ACCESS TO INVENTORY_MANAGER
   grant_access_to_user('INVENTORY_MANAGER', 'SELECT', 'AIRCRAFT');
   grant_access_to_user('INVENTORY_MANAGER', 'SELECT, INSERT, UPDATE DELETE', 'INVENTORY');
   grant_access_to_user('INVENTORY_MANAGER', 'SELECT, INSERT, UPDATE DELETE', 'INVENTORY_ORDER');
   grant_access_to_user('INVENTORY_MANAGER', 'SELECT', 'MAINTEANCE_SCHEDULE');
   grant_access_to_user('INVENTORY_MANAGER', 'SELECT', 'MAINTEANCE_RECORD');
   grant_access_to_user('INVENTORY_MANAGER', 'SELECT', 'GROUND_OPS_SCHEDULE');

   -- GRANT ACCESS TO GROUND_OPERATION_MANAGER
   grant_access_to_user('GROUND_OPERATION_MANAGER', 'SELECT', 'INVENTORY');
   grant_access_to_user('GROUND_OPERATION_MANAGER', 'SELECT', 'MAINTEANCE_SCHEDULE');
   grant_access_to_user('GROUND_OPERATION_MANAGER', 'SELECT, INSERT, UPDATE', 'MAINTEANCE_RECORD');
   grant_access_to_user('GROUND_OPERATION_MANAGER', 'SELECT, INSERT, UPDATE, DELETE', 'GROUND_OPS_SCHEDULE');
   grant_access_to_user('GROUND_OPERATION_MANAGER', 'SELECT, UPDATE', 'BAGGAGE');

   -- GRANT ACCESS TO CREW_MANAGER
   grant_access_to_user('CREW_MANAGER', 'SELECT', 'FLIGHT_SCHEDULE');
   grant_access_to_user('CREW_MANAGER', 'SELECT', 'ROUTE');
   grant_access_to_user('CREW_MANAGER', 'SELECT', 'EMPLOYEE');
   grant_access_to_user('CREW_MANAGER', 'SELECT, INSERT, UPDATE, DELETE', 'CREW_ASSIGNMENT');

   -- GRANT ACCESS TO MAINTENANCE_MANAGER
   grant_access_to_user('MAINTENANCE_MANAGER', 'SELECT', 'AIRCRAFT');
   grant_access_to_user('MAINTENANCE_MANAGER', 'SELECT', 'FLIGHT_SCHEDULE');
   grant_access_to_user('MAINTENANCE_MANAGER', 'SELECT', 'EMPLOYEE');
   grant_access_to_user('MAINTENANCE_MANAGER', 'SELECT', 'INVENTORY');
   grant_access_to_user('MAINTENANCE_MANAGER', 'SELECT', 'INVETORY_ORDER');
   grant_access_to_user('MAINTENANCE_MANAGER', 'SELECT, INSERT, UPDATE, DELETE', 'MAINTEANCE_SCHEDULE');
   grant_access_to_user('MAINTENANCE_MANAGER', 'SELECT, INSERT, UPDATE, DELETE', 'MAINTEANCE_RECORD');
   grant_access_to_user('MAINTENANCE_MANAGER', 'SELECT', 'GROUND_OPS_SCHEDULE');

   -- GRANT ACCESS TO HR_MANAGER
   grant_access_to_user('HR_MANAGER', 'SELECT, INSERT, UPDATE, DELETE', 'EMPLOYEE');

   -- GRANT ACCESS TO DATA_ANALYST
   grant_access_to_user('DATA_ANALYST', 'SELECT', null);
end;
/
