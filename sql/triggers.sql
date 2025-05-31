-- Trigger Function
CREATE OR REPLACE FUNCTION update_reorder_status()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.quantity < NEW.reorder_threshold THEN
    NEW.reorder_needed := TRUE;
  ELSE
    NEW.reorder_needed := FALSE;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- Create the trigger
CREATE TRIGGER trg_update_reorder_flag
BEFORE INSERT OR UPDATE ON products
FOR EACH ROW
EXECUTE FUNCTION update_reorder_status();


-- Test the trigger
-- Drop stock to test reorder_needed flag
UPDATE products
SET quantity = 5
WHERE id = 1;

SELECT id, name, quantity, reorder_threshold, reorder_needed
FROM products
WHERE id = 1;

-- Restore to test reset
UPDATE products
SET quantity = 50
WHERE id = 1;
