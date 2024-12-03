/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE insert_inventory_order (
   p_order_date     IN VARCHAR2,
   p_order_quantity IN INTEGER,
   p_order_amount   IN NUMBER,
   p_order_status   IN VARCHAR2,
   p_supplier_name  IN VARCHAR2,
   p_created_at     IN VARCHAR2,
   p_updated_at     IN VARCHAR2,
   p_inventory_id   IN INTEGER
) IS
   v_order_id INTEGER;
BEGIN
   -- Generate a new order_id
   SELECT NVL(MAX(order_id), 0) + 1 INTO v_order_id FROM inventory_order;

   -- Perform the insertion into the inventory_order table
   INSERT INTO inventory_order (
      order_id,
      order_date,
      order_quantity,
      order_amount,
      order_status,
      supplier_name,
      created_at,
      updated_at,
      inventory_inventory_id
   ) VALUES ( 
      v_order_id,
      TO_DATE(p_order_date, 'YYYY-MM-DD HH24:MI:SS'),
      p_order_quantity,
      p_order_amount,
      p_order_status,
      p_supplier_name,
      TO_DATE(p_created_at, 'YYYY-MM-DD HH24:MI:SS'),
      TO_DATE(p_updated_at, 'YYYY-MM-DD HH24:MI:SS'),
      p_inventory_id 
   );

   DBMS_OUTPUT.PUT_LINE('✅ Successfully inserted inventory_order with ID: ' || v_order_id);
   COMMIT; -- Commit the insertion

EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(
         '❌ Failed to process inventory_order: ' || SQLERRM
      );
END insert_inventory_order;
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
