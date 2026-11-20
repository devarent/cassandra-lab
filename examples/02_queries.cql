USE lab;

INSERT INTO devices (device, location, firmware) VALUES ('sensor-1', 'lab', '1.4.0');
INSERT INTO devices (device, location, firmware) VALUES ('sensor-2', 'warehouse', '1.3.9');

INSERT INTO events_by_day (day, event_time, device, metric)
VALUES ('2026-01-01', '2026-01-01 10:00:00', 'sensor-1', 21.5);
INSERT INTO events_by_day (day, event_time, device, metric)
VALUES ('2026-01-01', '2026-01-01 10:01:00', 'sensor-2', 19.8);

SELECT * FROM events_by_day WHERE day = '2026-01-01';

SELECT device, COUNT(*) AS readings, AVG(metric) AS avg_metric
FROM events_by_day
WHERE day = '2026-01-01'
GROUP BY device;

DESCRIBE TABLE events_by_day;
