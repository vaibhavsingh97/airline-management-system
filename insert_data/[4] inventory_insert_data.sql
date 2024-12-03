/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE insert_inventory (
   p_item_name         IN VARCHAR2,
   p_item_category     IN VARCHAR2,
   p_quantity_in_hand  IN INTEGER,
   p_reorder_threshold IN INTEGER,
   p_inv_last_updated  IN VARCHAR2,
   p_created_at        IN VARCHAR2,
   p_updated_at        IN VARCHAR2
) IS
   v_count NUMBER;
   v_inventory_id NUMBER;
BEGIN
   -- Check if a record exists with the provided item_name and item_category
   SELECT COUNT(*)
     INTO v_count
     FROM inventory
    WHERE item_name = p_item_name
      AND item_category = p_item_category;

   -- If a record exists, update it; otherwise, insert a new record
   IF v_count > 0 THEN
      UPDATE inventory
         SET quantity_in_hand = p_quantity_in_hand,
             reorder_threshold = p_reorder_threshold,
             inv_last_updated = TO_DATE(p_inv_last_updated, 'YYYY-MM-DD HH24:MI:SS'),
             updated_at = TO_DATE(p_updated_at, 'YYYY-MM-DD HH24:MI:SS')
       WHERE item_name = p_item_name
         AND item_category = p_item_category
      RETURNING inventory_id INTO v_inventory_id;

      DBMS_OUTPUT.PUT_LINE('✅ Successfully updated inventory with ID: ' || v_inventory_id);
   ELSE
      -- Perform the insertion into the inventory table
      INSERT INTO inventory (
         item_name,
         item_category,
         quantity_in_hand,
         reorder_threshold,
         inv_last_updated,
         created_at,
         updated_at
      ) VALUES ( 
         p_item_name,
         p_item_category,
         p_quantity_in_hand,
         p_reorder_threshold,
         TO_DATE(p_inv_last_updated, 'YYYY-MM-DD HH24:MI:SS'),
         TO_DATE(p_created_at, 'YYYY-MM-DD HH24:MI:SS'),
         TO_DATE(p_updated_at, 'YYYY-MM-DD HH24:MI:SS') 
      ) RETURNING inventory_id INTO v_inventory_id;

      DBMS_OUTPUT.PUT_LINE('✅ Successfully inserted inventory with ID: ' || v_inventory_id);
   END IF;

   COMMIT; -- Commit the insertion or update

EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error Code: ' || SQLCODE);
      DBMS_OUTPUT.PUT_LINE('Error Message: ' || SQLERRM);
      -- If an error occurs, raise a custom error
      RAISE_APPLICATION_ERROR(
         -20002,
         '❌ Failed to process inventory: ' || p_item_name || ' in category ' || p_item_category
      );
END insert_inventory;
/

BEGIN
   -- Inserting data into inventory table using the modified procedure
   insert_inventory(
      'oil filter',
      'spare',
      62,
      6,
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14'
   );
   insert_inventory(
      'spark plugs',
      'spare',
      86,
      9,
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14'
   );
   insert_inventory(
      'tire pressure gauge',
      'spare',
      60,
      10,
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14'
   );
   insert_inventory(
      'fuel pump',
      'tools',
      80,
      6,
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14'
   );
   insert_inventory(
      'air filter',
      'spare',
      34,
      10,
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14'
   );
   insert_inventory(
      'engine oil',
      'spare',
      30,
      5,
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14'
   );
   insert_inventory(
      'brake pads',
      'tools',
      62,
      10,
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14'
   );
   insert_inventory(
      'battery',
      'spare',
      36,
      1,
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14'
   );
   insert_inventory(
      'antifreeze',
      'spare',
      97,
      6,
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14'
   );
   insert_inventory(
      'windshield wipers',
      'spare',
      17,
      9,
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14',
      '2024-11-05 15:47:14'
   );
END;
/