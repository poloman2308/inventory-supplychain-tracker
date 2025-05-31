-- Products table
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    quantity INT NOT NULL,
    reorder_threshold INT NOT NULL,
    reorder_needed BOOLEAN DEFAULT FALSE,
    supplier_id INT
);

-- Inventory Movements (IN/OUT)
CREATE TABLE inventory_movements (
    id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(id),
    movement_type VARCHAR(10) CHECK (movement_type IN ('IN', 'OUT')),
    quantity INT NOT NULL,
    movement_date DATE DEFAULT CURRENT_DATE
);

-- Suppliers table
CREATE TABLE suppliers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    lead_time_days INT
);
