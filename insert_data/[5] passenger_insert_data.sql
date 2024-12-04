/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/
SET SERVEROUTPUT ON;
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';

CREATE OR REPLACE PROCEDURE insert_passenger (
   p_pass_first_name          IN VARCHAR2,
   p_pass_last_name           IN VARCHAR2,
   p_pass_email               IN VARCHAR2,
   p_pass_phone               IN NUMBER,
   p_gender                   IN VARCHAR2,
   p_dob                      IN VARCHAR2,
   p_seat_preference          IN VARCHAR2,
   p_created_at               IN VARCHAR2,
   p_updated_at               IN VARCHAR2
) IS
   v_count NUMBER;
   v_passenger_id INTEGER;
BEGIN
   -- Check if a record exists with the provided email (assuming email is unique)
   SELECT COUNT(*)
   INTO v_count
   FROM passenger
   WHERE pass_email = p_pass_email;

   IF v_count > 0 THEN
      -- Update existing passenger record
      UPDATE passenger
      SET pass_first_name = p_pass_first_name,
          pass_last_name = p_pass_last_name,
          pass_phone = p_pass_phone,
          gender = p_gender,
          dob = TO_DATE(p_dob,'DD-MM-YYYY'),
          seat_preference = p_seat_preference,
          updated_at = TO_DATE(p_updated_at, 'YYYY-MM-DD HH24:MI:SS')
      WHERE pass_email = p_pass_email
      RETURNING passenger_id INTO v_passenger_id;
      
      DBMS_OUTPUT.PUT_LINE('✅ Successfully updated passenger with ID: ' || v_passenger_id);
   ELSE
      -- Insert new passenger record
      INSERT INTO passenger (
         pass_first_name,
         pass_last_name,
         pass_email,
         pass_phone,
         gender,
         dob,
         seat_preference,
         created_at,
         updated_at
      ) VALUES (
         p_pass_first_name,
         p_pass_last_name,
         p_pass_email,
         p_pass_phone,
         p_gender,
         TO_DATE(p_dob,'DD-MM-YYYY'),
         p_seat_preference,
         TO_DATE(p_created_at, 'YYYY-MM-DD HH24:MI:SS'),
         TO_DATE(p_updated_at, 'YYYY-MM-DD HH24:MI:SS')
      ) RETURNING passenger_id INTO v_passenger_id;
      
      DBMS_OUTPUT.PUT_LINE('✅ Successfully inserted passenger with ID: ' || v_passenger_id);
   END IF;

   COMMIT; -- Commit the transaction
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('❌ Failed to insert or update passenger: ' || p_pass_email);
END insert_passenger;
/


begin
    -- Inserting data into passenger table
   insert_passenger(
      'Catina',
      'Mellers',
      'cmellers0@tuttocitta.it',
      '8865882514',
      'female',
      '10-05-1931',
      'aisle',
      '2022-09-23 00:53:23',
      '2022-09-23 00:53:23'
   );
   insert_passenger(
      'Tabby',
      'Pegg',
      'tpegg1@google.de',
      '5778897044',
      'female',
      '15-05-1957',
      'middle',
      '2023-07-16 03:07:23',
      '2023-07-16 03:07:23'
   );
   insert_passenger(
      'Kitty',
      'Warlawe',
      'kwarlawe2@ibm.com',
      '9827571789',
      'female',
      '10-01-1989',
      'aisle',
      '2023-03-25 04:11:48',
      '2023-03-25 04:11:48'
   );
   insert_passenger(
      'Eda',
      'Borham',
      'eborham3@jiathis.com',
      '3082546537',
      'female',
      '31-07-1964',
      'middle',
      '2024-07-02 13:08:56',
      '2024-07-02 13:08:56'
   );
   insert_passenger(
      'Pennie',
      'Jouandet',
      'pjouandet4@sphinn.com',
      '1877433374',
      'female',
      '08-08-1982',
      'window',
      '2024-06-11 05:39:51',
      '2024-06-11 05:39:51'
   );
   commit;
end;
/
