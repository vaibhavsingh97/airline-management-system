/*
================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================
*/

begin
   -- Grant access to procedures
   grant_access_to_user('PASSENGER', 'EXECUTE', 'insert_reservation');
   grant_access_to_user('PASSENGER', 'EXECUTE', 'insert_payment');
   grant_access_to_user('PASSENGER', 'EXECUTE', 'insert_reservation_payment');
   grant_access_to_user('PASSENGER', 'EXECUTE', 'insert_baggage');
   grant_access_to_user('PASSENGER', 'EXECUTE', 'insert_passenger');

end;
/
