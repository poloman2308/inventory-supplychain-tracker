-- summary: daily in/out inventory movements
CREATE OR REPLACE VIEW daily_inventory_summary AS
SELECT
    product_id,
    movement_date,
    SUM(CASE WHEN movement_type = 'IN' THEN quantity ELSE 0 END) AS total_stock_in,
    SUM(CASE WHEN movement_type = 'OUT' THEN quantity ELSE 0 END) AS total_stock_out
FROM inventory_movements
GROUP BY product_id, movement_date
ORDER BY movement_date DESC;

-- Test the view
SELECT * FROM daily_inventory_summary LIMIT 10;
