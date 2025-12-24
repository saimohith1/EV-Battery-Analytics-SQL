CREATE OR REPLACE VIEW battery_abuse_score AS
SELECT
    cs.vehicle_id,

    COUNT(*) FILTER (WHERE charger_type = 'fast')::FLOAT / COUNT(*) 
        AS fast_charge_ratio,

    COUNT(*) FILTER (WHERE max_temp_c > 50)::FLOAT / COUNT(*) 
        AS overheat_ratio,

    COUNT(bf.fault_id)::FLOAT / COUNT(DISTINCT cs.session_id)
        AS fault_ratio,

    (
      0.4 * (COUNT(*) FILTER (WHERE charger_type = 'fast')::FLOAT / COUNT(*)) +
      0.3 * (COUNT(*) FILTER (WHERE max_temp_c > 50)::FLOAT / COUNT(*)) +
      0.3 * (COUNT(bf.fault_id)::FLOAT / COUNT(DISTINCT cs.session_id))
    ) AS abuse_score

FROM charging_sessions cs
LEFT JOIN battery_faults bf
  ON cs.vehicle_id = bf.vehicle_id
GROUP BY cs.vehicle_id;

-- Final system summary view

CREATE OR REPLACE VIEW ev_battery_system_summary AS
SELECT
    v.vehicle_id,
    v.model,
    v.battery_capacity_kwh,
    AVG(bt.battery_temp_c) AS avg_temp,
    a.abuse_score,
    CASE
        WHEN a.abuse_score > 0.6 THEN 'HIGH RISK'
        WHEN a.abuse_score > 0.3 THEN 'MEDIUM RISK'
        ELSE 'LOW RISK'
    END AS risk_level
FROM vehicles v
LEFT JOIN battery_telemetry bt USING(vehicle_id)
LEFT JOIN battery_abuse_score a USING(vehicle_id)
GROUP BY v.vehicle_id, v.model, v.battery_capacity_kwh, a.abuse_score;
