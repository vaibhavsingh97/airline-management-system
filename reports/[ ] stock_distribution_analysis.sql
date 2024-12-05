/*================================================
‼️ THIS FILE SHOULD BE RUN BY INVENTORY MANAGER ONLY ‼️
================================================*/

WITH stock_ranges AS (
    SELECT item_category,
           CASE 
               WHEN current_stock = 0 THEN 'Out of Stock'
               WHEN current_stock BETWEEN 1 AND 10 THEN 'Low Stock'
               WHEN current_stock BETWEEN 11 AND 50 THEN 'Moderate Stock'
               ELSE 'High Stock'
           END AS stock_status
    FROM Current_Inventory_Status
)
SELECT item_category, stock_status, COUNT(*) AS item_count
FROM stock_ranges
GROUP BY item_category, stock_status
ORDER BY item_category, 
    CASE stock_status
        WHEN 'Out of Stock' THEN 1
        WHEN 'Low Stock' THEN 2
        WHEN 'Moderate Stock' THEN 3
        WHEN 'High Stock' THEN 4
    END;