CREATE TABLE vehicles (
    vehicle_id SERIAL PRIMARY KEY,
    model VARCHAR(50),
    battery_capacity_kwh NUMERIC(5,2),
    manufacture_date DATE
);

CREATE TABLE charging_sessions (
    session_id SERIAL PRIMARY KEY,
    vehicle_id INT REFERENCES vehicles(vehicle_id),
    charger_type VARCHAR(20),
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    energy_added_kwh NUMERIC(5,2),
    avg_current_a NUMERIC(6,2),
    max_temp_c NUMERIC(5,2)
);

CREATE TABLE battery_telemetry (
    telemetry_id SERIAL PRIMARY KEY,
    vehicle_id INT REFERENCES vehicles(vehicle_id),
    timestamp TIMESTAMP,
    soc_percent NUMERIC(5,2),
    battery_temp_c NUMERIC(5,2),
    voltage_v NUMERIC(6,2),
    current_a NUMERIC(6,2)
);

CREATE TABLE battery_faults (
    fault_id SERIAL PRIMARY KEY,
    vehicle_id INT REFERENCES vehicles(vehicle_id),
    timestamp TIMESTAMP,
    fault_type VARCHAR(30),
    severity VARCHAR(10)
);
