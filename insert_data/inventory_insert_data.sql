create or replace procedure insert_inventory (
   p_inventory_id      in integer,
   p_item_name         in varchar2,
   p_item_category     in varchar2,
   p_quantity_in_hand  in integer,
   p_reorder_threshold in integer,
   p_inv_last_updated  in date,
   p_created_at        in date,
   p_updated_at        in date
) is
   v_count number;
begin
    -- Try to delete the existing inventory record if it exists
    -- Check if a record exists with the provided inventory_id
   select count(*)
     into v_count
     from inventory
    where inventory_id = p_inventory_id;

    -- If a record exists, delete it
   if v_count > 0 then
      delete from inventory
       where inventory_id = p_inventory_id;
      commit; -- Commit the deletion
      null;
   end if;

    -- Perform the insertion into the inventory table
   begin
      insert into inventory (
         inventory_id,
         item_name,
         item_category,
         quantity_in_hand,
         reorder_threshold,
         inv_last_updated,
         created_at,
         updated_at
      ) values ( p_inventory_id,
                 p_item_name,
                 p_item_category,
                 p_quantity_in_hand,
                 p_reorder_threshold,
                 to_date(p_inv_last_updated,
                         'DD-MM-YYYY HH24:MI:SS'),
                 to_date(p_created_at,
                         'DD-MM-YYYY HH24:MI:SS'),
                 to_date(p_updated_at,
                         'DD-MM-YYYY HH24:MI:SS') );
      dbms_output.put_line('✅ Successfully inserted inventory with ID: ' || p_inventory_id);
      commit; -- Commit the insertion
   exception
      when others then
            -- If an error occurs during insertion, raise a custom error
         raise_application_error(
            -20001,
            '❌ Failed to insert inventory with ID: ' || p_inventory_id
         );
   end;

end insert_inventory;
/


begin
    -- Inserting data into inventory table using the procedure
   insert_inventory(
      401,
      'oil filter',
      'spare',
      62,
      6,
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14'
   );
   insert_inventory(
      402,
      'spark plugs',
      'spare',
      86,
      9,
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14'
   );
   insert_inventory(
      403,
      'tire pressure gauge',
      'spare',
      60,
      10,
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14'
   );
   insert_inventory(
      404,
      'fuel pump',
      'tools',
      80,
      6,
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14'
   );
   insert_inventory(
      405,
      'air filter',
      'spare',
      34,
      10,
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14'
   );
   insert_inventory(
      406,
      'engine oil',
      'spare',
      30,
      5,
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14'
   );
   insert_inventory(
      407,
      'brake pads',
      'tools',
      62,
      10,
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14'
   );
   insert_inventory(
      408,
      'battery',
      'spare',
      36,
      1,
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14'
   );
   insert_inventory(
      409,
      'antifreeze',
      'spare',
      97,
      6,
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14'
   );
   insert_inventory(
      410,
      'windshield wipers',
      'spare',
      17,
      9,
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14'
   );

   commit;
end;
/