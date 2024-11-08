SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE insert_passenger (
   p_passenger_id    IN INTEGER,
   p_pass_first_name IN VARCHAR2,
   p_pass_last_name  IN VARCHAR2,
   p_pass_email      IN VARCHAR2,
   p_pass_phone      IN NUMBER,
   p_gender          IN VARCHAR2,
   p_dob             IN VARCHAR2,
   p_seat_preference IN VARCHAR2,
   p_created_at      IN VARCHAR2,
   p_updated_at      IN VARCHAR2,
   p_wallet_wallet_id IN VARCHAR2
) IS
   v_count NUMBER;
BEGIN
   -- Check if a record exists with the provided passenger_id
   SELECT COUNT(*)
   INTO v_count
   FROM passenger
   WHERE passenger_id = p_passenger_id;

   IF v_count > 0 THEN
      -- Update existing passenger record
      UPDATE passenger
      SET pass_first_name = p_pass_first_name,
          pass_last_name = p_pass_last_name,
          pass_email = p_pass_email,
          pass_phone = p_pass_phone,
          gender = p_gender,
          dob = p_dob,
          seat_preference = p_seat_preference,
          updated_at = TO_DATE(p_updated_at, 'YYYY-MM-DD HH24:MI:SS'),
          wallet_wallet_id = p_wallet_wallet_id
      WHERE passenger_id = p_passenger_id;
      DBMS_OUTPUT.PUT_LINE('✅ Successfully updated passenger with ID: ' || p_passenger_id);
   ELSE
      -- Insert new passenger record
      INSERT INTO passenger (
         passenger_id,
         pass_first_name,
         pass_last_name,
         pass_email,
         pass_phone,
         gender,
         dob,
         seat_preference,
         created_at,
         updated_at,
         wallet_wallet_id
      ) VALUES (
         p_passenger_id,
         p_pass_first_name,
         p_pass_last_name,
         p_pass_email,
         p_pass_phone,
         p_gender,
         p_dob,
         p_seat_preference,
         TO_DATE(p_created_at, 'YYYY-MM-DD HH24:MI:SS'),
         TO_DATE(p_updated_at, 'YYYY-MM-DD HH24:MI:SS'),
         p_wallet_wallet_id
      );
      DBMS_OUTPUT.PUT_LINE('✅ Successfully inserted passenger with ID: ' || p_passenger_id);
   END IF;

   COMMIT; -- Commit the transaction
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error Code: ' || SQLCODE);
      DBMS_OUTPUT.PUT_LINE('Error Message: ' || SQLERRM);
      RAISE_APPLICATION_ERROR(-20001, '❌ Failed to insert or update passenger with ID: ' || p_passenger_id);
END insert_passenger;
/


begin
    -- Inserting data into passenger table
   insert_passenger(
      801,
      'Catina',
      'Mellers',
      'cmellers0@tuttocitta.it',
      '8865882514',
      'female',
      '10-05-1931',
      'aisle',
      '2022-09-23 00:53:23',
      '2022-09-23 00:53:23',
      null
   );
   insert_passenger(
      802,
      'Tabby',
      'Pegg',
      'tpegg1@google.de',
      '5778897044',
      'female',
      '15-05-1957',
      'middle',
      '2023-07-16 03:07:23',
      '2023-07-16 03:07:23',
      502
   );
   insert_passenger(
      803,
      'Kitty',
      'Warlawe',
      'kwarlawe2@ibm.com',
      '9827571789',
      'female',
      '10-01-1989',
      'aisle',
      '2023-03-25 04:11:48',
      '2023-03-25 04:11:48',
      503
   );
   insert_passenger(
      804,
      'Eda',
      'Borham',
      'eborham3@jiathis.com',
      '3082546537',
      'female',
      '31-07-1964',
      'middle',
      '2024-07-02 13:08:56',
      '2024-07-02 13:08:56',
      504
   );
   insert_passenger(
      805,
      'Pennie',
      'Jouandet',
      'pjouandet4@sphinn.com',
      '1877433374',
      'female',
      '08-08-1982',
      'window',
      '2024-06-11 05:39:51',
      '2024-06-11 05:39:51',
      505
   );
   insert_passenger(
      806,
      'Daven',
      'Krollman',
      'dkrollman5@chronoengine.com',
      '2117070929',
      'male',
      '25-08-1996',
      'window',
      '2024-07-03 00:27:07',
      '2024-07-03 00:27:07',
      null
   );
   insert_passenger(
      807,
      'Sigismondo',
      'Marnane',
      'smarnane6@multiply.com',
      '4906837346',
      'male',
      '13-09-2003',
      'window',
      '2023-08-06 00:35:55',
      '2023-08-06 00:35:55',
      507
   );
   insert_passenger(
      808,
      'Jessalyn',
      'Underdown',
      'junderdown7@liveinternet.ru',
      '1091457252',
      'female',
      '03-01-1984',
      'middle',
      '2022-12-21 08:43:43',
      '2022-12-21 08:43:43',
      508
   );
   insert_passenger(
      809,
      'Brucie',
      'Heersema',
      'bheersema8@nhs.uk',
      '2506837379',
      'male',
      '03-12-1943',
      'aisle',
      '2024-04-21 22:05:36',
      '2024-04-21 22:05:36',
      509
   );
   insert_passenger(
      810,
      'Ebeneser',
      'Gravet',
      'egravet9@furl.net',
      '5616473517',
      'male',
      '15-01-1947',
      'aisle',
      '2024-04-10 20:30:02',
      '2024-04-10 20:30:02',
      null
   );
   commit;
end;
/