create or replace procedure insert_inventory_order (
   p_order_id       in integer,
   p_order_date     in varchar2,
   p_order_quantity in integer,
   p_order_amount   in number,
   p_order_status   in varchar2,
   p_supplier_name  in varchar2,
   p_created_at     in varchar2,
   p_updated_at     in varchar2,
   p_inventory_id   in integer
) is
   v_count number;
begin
    -- Try to delete the existing order record if it exists
    -- Check if a record exists with the provided order_id
   select count(*)
     into v_count
     from inventory_order
    where order_id = p_order_id;

    -- If a record exists, delete it
   if v_count > 0 then
      delete from inventory_order
       where order_id = p_order_id;
      commit; -- Commit the deletion
      null;
   end if;

    -- Perform the insertion into the inventory_order table
   begin
      insert into inventory_order (
         order_id,
         order_date,
         order_quantity,
         order_amount,
         order_status,
         supplier_name,
         created_at,
         updated_at,
         inventory_inventory_id
      ) values ( p_order_id,
                 to_date(p_order_date,
                         'YYYY-MM-DD HH24:MI:SS'),
                 p_order_quantity,
                 p_order_amount,
                 p_order_status,
                 p_supplier_name,
                 to_date(p_created_at,
                         'YYYY-MM-DD HH24:MI:SS'),
                 to_date(p_updated_at,
                         'YYYY-MM-DD HH24:MI:SS'),
                 p_inventory_id );
      dbms_output.put_line('✅ Successfully inserted inventory_order with ID: ' || p_order_id);
      commit; -- Commit the insertion
   exception
      when others then
            -- If an error occurs during insertion, raise a custom error
         DBMS_OUTPUT.PUT_LINE('Error Code: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('Error Message: ' || SQLERRM);
         raise_application_error(
            -20001,
            '❌ Failed to insert inventory_order with ID: ' || p_order_id
         );
   end;

end insert_inventory_order;
/

begin
    -- Inserting data into inventory_order table
   insert_inventory_order(
      901,
      '2024-10-05 12:26:31',
      90,
      316.8,
      'fulfilled',
      'Mitchell and Sons',
      '2024-10-05 12:26:31',
      '2024-10-05 12:26:31',
      406
   );
   insert_inventory_order(
      902,
      '2023-05-17 21:09:40',
      62,
      2338.13,
      'fulfilled',
      'Wilkinson Inc',
      '2023-05-17 21:09:40',
      '2023-05-17 21:09:40',
      405
   );
   insert_inventory_order(
      903,
      '2023-10-15 20:17:41',
      34,
      65073.87,
      'fulfilled',
      'Labadie and Kunde',
      '2023-10-15 20:17:41',
      '2023-10-15 20:17:41',
      405
   );
   insert_inventory_order(
      904,
      '2023-04-29 17:29:54',
      8,
      87492.19,
      'fulfilled',
      'Collier-Zboncak',
      '2023-04-29 17:29:54',
      '2023-04-29 17:29:54',
      401
   );
   insert_inventory_order(
      905,
      '2024-02-15 15:02:44',
      94,
      69568.48,
      'pending',
      'Cronin and Mante',
      '2024-02-15 15:02:44',
      '2024-02-15 15:02:44',
      410
   );
   insert_inventory_order(
      906,
      '2022-10-23 02:31:52',
      73,
      79916.84,
      'fulfilled',
      'Hahn and Jaskolski',
      '2022-10-23 02:31:52',
      '2022-10-23 02:31:52',
      409
   );
   insert_inventory_order(
      907,
      '2023-10-15 19:40:56',
      57,
      7247.48,
      'failed',
      'Wolff and Hirthe',
      '2023-10-15 19:40:56',
      '2023-10-15 19:40:56',
      409
   );
   insert_inventory_order(
      908,
      '2024-04-01 09:58:24',
      81,
      24567.15,
      'pending',
      'Denesik Morissette',
      '2024-04-01 09:58:24',
      '2024-04-01 09:58:24',
      405
   );
   insert_inventory_order(
      909,
      '2022-04-02 15:38:48',
      24,
      3444.81,
      'fulfilled',
      'Beer LLC',
      '2022-04-02 15:38:48',
      '2022-04-02 15:38:48',
      409
   );
   insert_inventory_order(
      910,
      '2022-07-20 05:06:28',
      78,
      4545.98,
      'failed',
      'Jaskolski and Sons',
      '2022-07-20 05:06:28',
      '2022-07-20 05:06:28',
      407
   );

   commit;
end;
/