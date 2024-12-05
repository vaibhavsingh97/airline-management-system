/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/
SET SERVEROUTPUT ON;
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';

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
      order_date,
      order_quantity,
      order_amount,
      order_status,
      supplier_name,
      created_at,
      updated_at,
      inventory_inventory_id
   ) VALUES ( 
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
         '❌ Failed to process inventory_order '
      );
END insert_inventory_order;
/

begin
    -- Inserting data into inventory_order table
   insert_inventory_order(
      '2024-10-05 12:26:31',
      90,
      316.8,
      'pending',
      'Mitchell and Sons',
      '2024-10-05 12:26:31',
      '2024-10-05 12:26:31',
      1
   );
   insert_inventory_order(
      '2023-05-17 21:09:40',
      62,
      2338.13,
      'fulfilled',
      'Wilkinson Inc',
      '2023-05-17 21:09:40',
      '2023-05-17 21:09:40',
      5
   );
   insert_inventory_order(
      '2023-10-15 20:17:41',
      34,
      65073.87,
      'fulfilled',
      'Labadie and Kunde',
      '2023-10-15 20:17:41',
      '2023-10-15 20:17:41',
      5
   );
   insert_inventory_order(
      '2023-04-29 17:29:54',
      8,
      87492.19,
      'fulfilled',
      'Collier-Zboncak',
      '2023-04-29 17:29:54',
      '2023-04-29 17:29:54',
      1
   );
   insert_inventory_order(
      '2024-02-15 15:02:44',
      94,
      69568.48,
      'pending',
      'Cronin and Mante',
      '2024-02-15 15:02:44',
      '2024-02-15 15:02:44',
      10
   );
   insert_inventory_order(
      '2022-10-23 02:31:52',
      73,
      79916.84,
      'fulfilled',
      'Hahn and Jaskolski',
      '2022-10-23 02:31:52',
      '2022-10-23 02:31:52',
      9
   );
   insert_inventory_order(
      '2023-10-15 19:40:56',
      57,
      7247.48,
      'failed',
      'Wolff and Hirthe',
      '2023-10-15 19:40:56',
      '2023-10-15 19:40:56',
      9
   );
   insert_inventory_order(
      '2024-04-01 09:58:24',
      81,
      24567.15,
      'pending',
      'Denesik Morissette',
      '2024-04-01 09:58:24',
      '2024-04-01 09:58:24',
      5
   );
   insert_inventory_order(
      '2022-04-02 15:38:48',
      24,
      3444.81,
      'fulfilled',
      'Beer LLC',
      '2022-04-02 15:38:48',
      '2022-04-02 15:38:48',
      9
   );
   insert_inventory_order(
      '2022-07-20 05:06:28',
      78,
      4545.98,
      'failed',
      'Jaskolski and Sons',
      '2022-07-20 05:06:28',
      '2022-07-20 05:06:28',
      7
   );
   commit;
end;
/
