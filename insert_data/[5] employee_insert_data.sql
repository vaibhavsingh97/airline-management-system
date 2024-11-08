SET SERVEROUTPUT ON;

create or replace procedure insert_employee (
   p_employee_id    in integer,
   p_emp_first_name in varchar2,
   p_emp_last_name  in varchar2,
   p_emp_email      in varchar2,
   p_emp_phone      in number,
   p_emp_type       in varchar2,
   p_emp_subtype    in varchar2,
   p_emp_salary     in number,
   p_created_at     in varchar2,
   p_updated_at     in varchar2
) is
   v_count number;
begin
   -- Check if a record exists with the provided employee_id
   select count(*)
     into v_count
     from employee
    where employee_id = p_employee_id;

   -- If a record exists, update it
   if v_count > 0 then
      update employee
         set emp_first_name = p_emp_first_name,
             emp_last_name = p_emp_last_name,
             emp_email = p_emp_email,
             emp_phone = p_emp_phone,
             emp_type = p_emp_type,
             emp_subtype = p_emp_subtype,
             emp_salary = p_emp_salary,
             updated_at = to_date(p_updated_at, 'YYYY-MM-DD HH24:MI:SS')
       where employee_id = p_employee_id;
      
      dbms_output.put_line('✅ Successfully updated employee with ID: ' || p_employee_id);
      commit; -- Commit the update
   else
      -- If the record doesn't exist, perform the insertion
      begin
         insert into employee (
            employee_id,
            emp_first_name,
            emp_last_name,
            emp_email,
            emp_phone,
            emp_type,
            emp_subtype,
            emp_salary,
            created_at,
            updated_at
         ) values ( 
            p_employee_id,
            p_emp_first_name,
            p_emp_last_name,
            p_emp_email,
            p_emp_phone,
            p_emp_type,
            p_emp_subtype,
            p_emp_salary,
            to_date(p_created_at, 'YYYY-MM-DD HH24:MI:SS'),
            to_date(p_updated_at, 'YYYY-MM-DD HH24:MI:SS')
         );
         dbms_output.put_line('✅ Successfully inserted employee with ID: ' || p_employee_id);
         commit; -- Commit the insertion
      exception
         when others then
            -- If an error occurs during insertion, raise a custom error
            dbms_output.put_line('Error Code: ' || sqlcode);
            dbms_output.put_line('Error Message: ' || sqlerrm);
            raise_application_error(
               -20001,
               '❌ Failed to insert employee with ID: ' || p_employee_id
            );
      end;
   end if;
exception
   when others then
      -- If an error occurs during the procedure execution, raise a custom error
      dbms_output.put_line('Error Code: ' || sqlcode);
      dbms_output.put_line('Error Message: ' || sqlerrm);
      raise_application_error(
         -20002,
         '❌ Failed to process employee with ID: ' || p_employee_id
      );
end insert_employee;
/

begin
    -- Inserting data into employee table
   insert_employee(
      601,
      'Kaia',
      'Golt',
      'kgolt0@jimdo.com',
      '3736571734',
      'corporate',
      'sales',
      3909.15,
      '2024-04-12 16:13:46',
      '2024-04-12 16:13:46'
   );
   insert_employee(
      602,
      'Gilburt',
      'Granger',
      'ggranger1@shinystat.com',
      '9692375908',
      'ground_staff',
      'gate agent',
      2787.6,
      '2023-11-22 08:20:20',
      '2023-11-22 08:20:20'
   );
   insert_employee(
      603,
      'Wendeline',
      'Quipp',
      'wquipp2@wordpress.com',
      '6623746149',
      'ground_staff',
      'ramp agent',
      3055.31,
      '2023-10-24 04:41:25',
      '2023-10-24 04:41:25'
   );
   insert_employee(
      604,
      'Valeda',
      'Jennaroy',
      'vjennaroy3@drupal.org',
      '2237184426',
      'crew',
      null,
      8837.2,
      '2024-05-20 04:55:23',
      '2024-05-20 04:55:23'
   );
   insert_employee(
      605,
      'Dede',
      'Skerratt',
      'dskerratt4@shutterfly.com',
      '5861040992',
      'ground_staff',
      'ramp agent',
      5772.22,
      '2024-01-23 02:58:47',
      '2024-01-23 02:58:47'
   );
   insert_employee(
      606,
      'Lowrance',
      'Rickwood',
      'lrickwood5@gizmodo.com',
      '1913031510',
      'pilot',
      null,
      8952.92,
      '2024-04-09 03:10:20',
      '2024-04-09 03:10:20'
   );
   insert_employee(
      607,
      'Reider',
      'Saunderson',
      'rsaunderson6@skyrock.com',
      '2796682834',
      'pilot',
      null,
      8992.81,
      '2023-11-02 02:55:07',
      '2023-11-02 02:55:07'
   );
   insert_employee(
      608,
      'Christoforo',
      'Cristofor',
      'ccristofor7@vk.com',
      '5367754920',
      'ground_staff',
      'ramp agent',
      3222.39,
      '2024-03-24 11:08:33',
      '2024-03-24 11:08:33'
   );
   insert_employee(
      609,
      'Traci',
      'Jarvie',
      'tjarvie8@ycombinator.com',
      '5166888493',
      'crew',
      null,
      9013.11,
      '2023-10-15 05:09:33',
      '2023-10-15 05:09:33'
   );
   insert_employee(
      610,
      'Stoddard',
      'Hamor',
      'shamor9@taobao.com',
      '8842551259',
      'corporate',
      'hr',
      6806.49,
      '2024-01-08 00:02:41',
      '2024-01-08 00:02:41'
   );
   commit;
end;
/