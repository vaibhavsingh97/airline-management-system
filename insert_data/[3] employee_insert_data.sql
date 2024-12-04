/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/
SET SERVEROUTPUT ON;
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';

CREATE OR REPLACE PROCEDURE insert_employee (
   p_emp_first_name IN VARCHAR2,
   p_emp_last_name  IN VARCHAR2,
   p_emp_email      IN VARCHAR2,
   p_emp_phone      IN NUMBER,
   p_emp_type       IN VARCHAR2,
   p_emp_subtype    IN VARCHAR2,
   p_emp_salary     IN NUMBER,
   p_created_at     IN VARCHAR2,
   p_updated_at     IN VARCHAR2
) IS
   v_count NUMBER;
   v_employee_id NUMBER;
BEGIN
   -- Check if a record exists with the provided email (assuming email is unique)
   SELECT COUNT(*)
     INTO v_count
     FROM employee
    WHERE emp_email = p_emp_email;

   -- If a record exists, update it; otherwise, insert a new record
   IF v_count > 0 THEN
      UPDATE employee
         SET emp_first_name = p_emp_first_name,
             emp_last_name = p_emp_last_name,
             emp_phone = p_emp_phone,
             emp_type = p_emp_type,
             emp_subtype = p_emp_subtype,
             emp_salary = p_emp_salary,
             updated_at = TO_DATE(p_updated_at, 'YYYY-MM-DD HH24:MI:SS')
       WHERE emp_email = p_emp_email
      RETURNING employee_id INTO v_employee_id;

      DBMS_OUTPUT.PUT_LINE('✅ Successfully updated employee with ID: ' || v_employee_id);
   ELSE
      -- Perform the insertion into the employee table
      INSERT INTO employee (
         emp_first_name,
         emp_last_name,
         emp_email,
         emp_phone,
         emp_type,
         emp_subtype,
         emp_salary,
         created_at,
         updated_at
      ) VALUES ( 
         p_emp_first_name,
         p_emp_last_name,
         p_emp_email,
         p_emp_phone,
         p_emp_type,
         p_emp_subtype,
         p_emp_salary,
         TO_DATE(p_created_at, 'YYYY-MM-DD HH24:MI:SS'),
         TO_DATE(p_updated_at, 'YYYY-MM-DD HH24:MI:SS')
      ) RETURNING employee_id INTO v_employee_id;

      DBMS_OUTPUT.PUT_LINE('✅ Successfully inserted employee with ID: ' || v_employee_id);
   END IF;

   COMMIT; -- Commit the insertion or update

EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(
         '❌ Failed to process employee: ' || p_emp_first_name || ' ' || p_emp_last_name
      );
END insert_employee;
/

BEGIN
   -- Inserting data into employee table using the modified procedure
   insert_employee(
      'Kaia',
      'Golt',
      'kgolt0@jimdo.com',
      3736571734,
      'corporate',
      'sales',
      3909.15,
      '2024-04-12 16:13:46',
      '2024-04-12 16:13:46'
   );
   insert_employee(
      'Gilburt',
      'Granger',
      'ggranger1@shinystat.com',
      9692375908,
      'ground_staff',
      null,
      2787.6,
      '2023-11-22 08:20:20',
      '2023-11-22 08:20:20'
   );
   insert_employee(
      'Wendeline',
      'Quipp',
      'wquipp2@wordpress.com',
      6623746149,
      'ground_staff',
      null,
      3055.31,
      '2023-10-24 04:41:25',
      '2023-10-24 04:41:25'
   );
   insert_employee(
      'Valeda',
      'Jennaroy',
      'vjennaroy3@drupal.org',
      2237184426,
      'crew',
      null,
      8837.2,
      '2024-05-20 04:55:23',
      '2024-05-20 04:55:23'
   );
   insert_employee(
      'Dede',
      'Skerratt',
      'dskerratt4@shutterfly.com',
      5861040992,
      'ground_staff',
      null,
      5772.22,
      '2024-01-23 02:58:47',
      '2024-01-23 02:58:47'
   );
   insert_employee(
      'Lowrance',
      'Rickwood',
      'lrickwood5@gizmodo.com',
      1913031510,
      'pilot',
      null,
      8952.92,
      '2024-04-09 03:10:20',
      '2024-04-09 03:10:20'
   );
   insert_employee(
      'Reider',
      'Saunderson',
      'rsaunderson6@skyrock.com',
      2796682834,
      'pilot',
      null,
      8992.81,
      '2023-11-02 02:55:07',
      '2023-11-02 02:55:07'
   );
   insert_employee(
      'Christoforo',
      'Cristofor',
      'ccristofor7@vk.com',
      5367754920,
      'ground_staff',
      null,
      3222.39,
      '2024-03-24 11:08:33',
      '2024-03-24 11:08:33'
   );
   insert_employee(
      'Traci',
      'Jarvie',
      'tjarvie8@ycombinator.com',
      5166888493,
      'crew',
      null,
      9013.11,
      '2023-10-15 05:09:33',
      '2023-10-15 05:09:33'
   );
   insert_employee(
      'Stoddard',
      'Hamor',
      'shamor9@taobao.com',
      8842551259,
      'corporate',
      'hr',
      6806.49,
      '2024-01-08 00:02:41',
      '2024-01-08 00:02:41'
   );
   insert_employee(
      'Dorolice',
      'Bartolommeo',
      'Dorolice.Bartolommeo@indigo.com',
      9878675645,
      'crew',
      null,
      9013.11,
      '2023-10-15 05:09:33',
      '2023-10-15 05:09:33'
   );
   insert_employee(
      'Daniel',
      'Smith',
      'Dorolice.Smith@indigo.com',
      9988776655,
      'crew',
      null,
      10013.11,
      '2023-10-15 05:09:33',
      '2023-10-15 05:09:33'
   );
END;
/
