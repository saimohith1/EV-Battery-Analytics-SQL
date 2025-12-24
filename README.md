# EV Battery Health & Charging Abuse Analytics (SQL)

## Introduction

This project implements a **PostgreSQL-based analytics system** to monitor **electric vehicle (EV) battery health, charging behavior, and safety risks using only SQL**. It simulates how backend **telematics platforms** and **Battery Management Systems (BMS)** analyze battery degradation, charging abuse, and thermal stress—without relying on external processing layers.
All analytics logic is executed **entirely inside PostgreSQL** using relational modeling, triggers, views, CTEs, and time-series analysis.

---

## Table of Contents

- [Problem Statement](#problem-statement)
- [System Overview](#system-overview)
- [Database Schema](#database-schema)
- [Key Features](#key-features)
- [Example Insights](#example-insights)
- [Tech Stack](#tech-stack)
- [How to Run](#how-to-run)
- [Performance Optimization](#performance-optimization)
- [Possible Extensions](#possible-extensions)

---

## Problem Statement

Electric vehicle batteries degrade faster due to:
- Frequent **DC fast charging**
- **Thermal stress** during charging
- **Unsafe charging behaviors**

Most real-world analytics pipelines rely on external services or data processing frameworks. This project demonstrates that **core battery intelligence can be implemented directly at the database layer using SQL alone**.
The system shows how SQL can be used to:
- Track charging behavior and battery telemetry
- Detect unsafe charging conditions automatically
- Quantify battery abuse using composite metrics
- Classify vehicles by degradation risk

---

## System Overview

The system stores EV data in a relational schema consisting of:

- Vehicle metadata
- Charging sessions
- Battery telemetry (time-series data)
- Battery fault events

Key analytics are implemented using:

- **SQL views** for continuous analysis
- **Triggers** for real-time fault detection
- **Synthetic data generation** inside PostgreSQL to simulate months of usage

No external services, scripts, or processing engines are required.

---

## Database Schema

### Entities

- **vehicles**
- **charging_sessions**
- **battery_telemetry**
- **battery_faults**

### Relationships

- One vehicle → many charging sessions
- One vehicle → many telemetry records
- One vehicle → many fault events

Battery faults are **event-driven** and automatically generated when unsafe charging conditions are detected.

---

## Key Features

### Relational EV Data Model

The schema cleanly separates:
- Vehicle metadata
- Charging behavior
- Sensor telemetry
- Fault events

This enables scalable analytics, clean joins, and efficient querying.

---

### Automated Fault Detection

A **PostgreSQL trigger** simulates Battery Management System logic by automatically logging a fault when:
- Battery temperature exceeds safe thresholds during charging

This allows real-time detection of unsafe conditions directly at the database level.

---

### Battery Abuse Score

A composite **Battery Abuse Score** is calculated per vehicle using:
- Fast charging frequency
- Overheating event count
- Battery fault occurrence rate

Vehicles are classified into risk categories:
- **LOW**
- **MEDIUM**
- **HIGH**

This mirrors how fleet-level EV health monitoring systems prioritize vehicles for inspection.

---

### Synthetic Data Generation

Realistic EV usage data is generated using SQL functions:
- Mixed fast and slow charging sessions
- Temperature and current correlated with charger type
- Multiple vehicles over several months of simulated operation

This enables meaningful analytics without requiring real vehicle data.

---

## Example Insights

The system enables analysis such as:
- Vehicles with a high proportion of fast charging sessions exhibit higher thermal stress
- Overheating events strongly correlate with fault frequency
- A small subset of vehicles accounts for the majority of critical battery faults

---

## Tech Stack

- **PostgreSQL**
- **pgAdmin 4**
- **SQL**
  - CTEs
  - Views
  - Triggers
  - Indexes
  - Time-series queries

---

## How to Run

1. Create a PostgreSQL database
2. Execute the schema creation SQL scripts
3. Insert synthetic data using the provided SQL generators
4. Query analytical views to inspect:
   - Battery abuse scores
   - Risk classifications
   - Fault statistics

All logic runs **entirely inside PostgreSQL**.

---

## Performance Optimization

- Indexes are created on foreign keys for faster joins
- `EXPLAIN ANALYZE` is used to validate query performance
- Views are designed for efficient aggregation on time-series data

---

## Possible Extensions

- Battery chemistry comparison (e.g., **LFP vs NMC**)
- Dashboard integration using **Power BI** or **Metabase**
- Machine learning–based **remaining useful life (RUL)** prediction
- Real-time streaming integration (logical replication / CDC)

---

## License

This project is provided for educational and analytical demonstration purposes.
