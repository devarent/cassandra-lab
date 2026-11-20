CREATE KEYSPACE IF NOT EXISTS lab
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

USE lab;

CREATE TABLE IF NOT EXISTS events_by_day (
    day date,
    event_time timestamp,
    device text,
    metric double,
    PRIMARY KEY ((day), event_time, device)
) WITH CLUSTERING ORDER BY (event_time DESC);

CREATE TABLE IF NOT EXISTS devices (
    device text PRIMARY KEY,
    location text,
    firmware text
);
