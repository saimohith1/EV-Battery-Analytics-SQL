INSERT INTO vehicles (model, battery_capacity_kwh, manufacture_date)
SELECT
    'EV-' || chr(65 + gs),
    (40 + (random() * 40))::NUMERIC(5,2),
    DATE '2020-01-01' + (random() * 1000)::INT
FROM generate_series(1, 10) gs;

-- Generate charging sessions (6 months)

INSERT INTO charging_sessions (
    vehicle_id,
    charger_type,
    start_time,
    end_time,
    energy_added_kwh,
    avg_current_a,
    max_temp_c
)
SELECT
    v.vehicle_id,

    CASE
        WHEN random() < 0.3 THEN 'fast'
        ELSE 'slow'
    END,

    ts,
    ts + INTERVAL '1 hour',

    (10 + random() * 40)::NUMERIC(5,2),

    CASE
        WHEN random() < 0.3 THEN (150 + random() * 80)
        ELSE (40 + random() * 40)
    END::NUMERIC(6,2),

    CASE
        WHEN random() < 0.3 THEN (45 + random() * 15)
        ELSE (30 + random() * 10)
    END::NUMERIC(5,2)

FROM vehicles v,
     generate_series(
         NOW() - INTERVAL '180 days',
         NOW(),
         INTERVAL '2 days'
     ) ts;

-- Generate telemetry data

INSERT INTO battery_telemetry (
    vehicle_id,
    timestamp,
    soc_percent,
    battery_temp_c,
    voltage_v,
    current_a
)
SELECT
    cs.vehicle_id,
    cs.start_time + (random() * INTERVAL '1 hour'),
    (20 + random() * 80)::NUMERIC(5,2),
    (cs.max_temp_c - random() * 5)::NUMERIC(5,2),
    (350 + random() * 70)::NUMERIC(6,2),
    cs.avg_current_a + (random() * 10)
FROM charging_sessions cs;
