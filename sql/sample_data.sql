-- Suppliers table
INSERT INTO suppliers (name, lead_time_days) VALUES
  ('Acme Supplies', 5),
  ('Global Parts Inc.', 7),
  ('NextGen Materials', 3),
  ('Reliable Vendors', 10),
  ('SuperStock Ltd.', 6),
  ('LogiTrade Corp.', 4),
  ('United Components', 8),
  ('Alpha Distributors', 9),
  ('Quantum Supply Co.', 2),
  ('Delta Hardware', 5);


-- Products distrubution to suppliers 
DO $$
BEGIN
  FOR i IN 1..50 LOOP
    INSERT INTO products (
      name, quantity, reorder_threshold, supplier_id
    )
    VALUES (
      'Product ' || i,
      (RANDOM() * 100)::INT,
      (RANDOM() * 30 + 10)::INT,
      ((RANDOM() * 10)::INT % 10) + 1
    );
  END LOOP;
END;
$$;

-- Inventory Movements (IN/OUT)
DO $$
DECLARE
  i INT;
BEGIN
  FOR i IN 1..200 LOOP
    INSERT INTO inventory_movements (
      product_id,
      movement_type,
      quantity,
      movement_date
    )
    VALUES (
      ((RANDOM() * 50)::INT % 50) + 1,
      CASE WHEN RANDOM() > 0.5 THEN 'IN' ELSE 'OUT' END,
      (RANDOM() * 20 + 1)::INT,
      CURRENT_DATE - (RANDOM() * 30)::INT
    );
  END LOOP;
END;
$$;


-- Validate the data
SELECT COUNT(*) FROM suppliers;           -- Expect 10
SELECT COUNT(*) FROM products;            -- Expect 50
SELECT COUNT(*) FROM inventory_movements; -- Expect ~200

-- Example: Low inventory products
SELECT name, quantity, reorder_threshold
FROM products
WHERE quantity < reorder_threshold;
