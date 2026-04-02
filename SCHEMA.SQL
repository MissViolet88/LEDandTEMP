-- Traffic Control Table
CREATE TABLE
    IF NOT EXISTS traffic_control (
        id INT PRIMARY KEY DEFAULT 1,
        mode TEXT DEFAULT 'off',
        led_red BOOLEAN DEFAULT FALSE,
        led_yellow BOOLEAN DEFAULT FALSE,
        led_green BOOLEAN DEFAULT FALSE,
        led_builtin BOOLEAN DEFAULT FALSE,
        updated_at TIMESTAMPTZ DEFAULT NOW (),
        esp_heartbeat TIMESTAMPTZ
    );

INSERT INTO
    traffic_control (id)
VALUES
    (1) ON CONFLICT DO NOTHING;

-- Traffic Logs Table
CREATE TABLE
    IF NOT EXISTS traffic_logs (
        id SERIAL PRIMARY KEY,
        color TEXT,
        message TEXT,
        ts TIMESTAMPTZ DEFAULT NOW ()
    );

-- Sensor Data Table
CREATE TABLE
    IF NOT EXISTS sensor_data (
        id SERIAL PRIMARY KEY,
        temperature FLOAT,
        humidity FLOAT,
        created_at TIMESTAMPTZ DEFAULT NOW ()
    );

-- Enable Row Level Security (optional but recommended)
ALTER TABLE traffic_control ENABLE ROW LEVEL SECURITY;

ALTER TABLE traffic_logs ENABLE ROW LEVEL SECURITY;

ALTER TABLE sensor_data ENABLE ROW LEVEL SECURITY;

-- Allow all operations for anon key (adjust for production)
CREATE POLICY "Allow all" ON traffic_control FOR ALL USING (true)
WITH
    CHECK (true);

CREATE POLICY "Allow all" ON traffic_logs FOR ALL USING (true)
WITH
    CHECK (true);

CREATE POLICY "Allow all" ON sensor_data FOR ALL USING (true)
WITH
    CHECK (true);