CREATE OR REPLACE FUNCTION detect_overtemp_fault()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.max_temp_c > 55 THEN
        INSERT INTO battery_faults (
            vehicle_id,
            timestamp,
            fault_type,
            severity
        )
        VALUES (
            NEW.vehicle_id,
            NOW(),
            'overtemperature',
            'critical'
        );
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER overtemp_fault_trigger
AFTER INSERT ON charging_sessions
FOR EACH ROW
EXECUTE FUNCTION detect_overtemp_fault();
