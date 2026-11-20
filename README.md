<div align="center">
<img src="assets/brand-logo.svg" alt="Arya Fatthurahman" width="120" />
</div>

# Cassandra Lab

<sub>Run Apache Cassandra 5 in Docker, design a partition key, and practice CQL queries and clustering columns.</sub>

<p>
  <img src="https://img.shields.io/badge/Database-Apache%20Cassandra-1287B1?style=flat-square" alt="Database: Apache Cassandra" />
  <img src="https://img.shields.io/badge/Category-Wide--column%20%2F%20NoSQL-6366F1?style=flat-square" alt="Category: Wide-column / NoSQL" />
  <img src="https://img.shields.io/badge/Runs%20in-Docker-2496ED?style=flat-square&logo=docker&logoColor=white" alt="Runs in Docker" />
  <img src="https://img.shields.io/badge/License-MIT-22C55E?style=flat-square" alt="License: MIT" />
  <a href="https://github.com/devarent/cassandra-lab/actions/workflows/compose-check.yml"><img src="https://github.com/devarent/cassandra-lab/actions/workflows/compose-check.yml/badge.svg" alt="compose-check" /></a>
</p>

## What this lab is

Cassandra is a distributed wide-column store built for high write throughput and multi-region availability. This lab starts a single node, creates a keyspace with a deliberate partition key, and shows how clustering columns shape the queries you can run efficiently.

## Quickstart

```bash
docker compose up -d
docker compose cp examples/01_schema.cql cassandra:/tmp/01_schema.cql
docker compose cp examples/02_queries.cql cassandra:/tmp/02_queries.cql
docker compose exec cassandra cqlsh -f /tmp/01_schema.cql
docker compose exec cassandra cqlsh -f /tmp/02_queries.cql
```

## Connection details

| Field | Value |
| --- | --- |
| Host | `localhost` |
| CQL port | `9042` |
| Keyspace | `lab` |
| User | `cassandra` |
| Password | `cassandra (default; change it)` |
| cqlsh | `docker compose exec cassandra cqlsh` |

## Examples

| File | What it shows |
| --- | --- |
| [`docker-compose.yml`](docker-compose.yml) | Engine, ports, and persistent volume. |
| [`.github/workflows/compose-check.yml`](.github/workflows/compose-check.yml) | Validates the Compose file on every push. |
| [`examples/01_schema.cql`](examples/01_schema.cql) | Keyspace and a table partitioned by day, clustered by time. |
| [`examples/02_queries.cql`](examples/02_queries.cql) | Insert, query by partition, and inspect the schema. |

## Exercises

1. Add a `metrics_by_device` table partitioned by `device` and query the latest reading.
2. Insert a row with a TTL and verify it disappears after expiry.
3. Use `nodetool status` and `nodetool tablestats lab.events_by_day`.
4. Explain why `SELECT * FROM events_by_day WHERE device = 'sensor-1'` needs `ALLOW FILTERING`.

## Notes and limits

- The default `cassandra` superuser password is used here. Change it before exposing the port.
- A single node with `SimpleStrategy` is only appropriate for a local lab; production uses `NetworkTopologyStrategy`.
- Cassandra rewards query-first data modeling. The primary key in this lab is chosen for `WHERE day = ?` queries.
- First startup can take a minute; the healthcheck waits for CQL to become available.

## Run it from anywhere

This lab publishes its ports on `127.0.0.1` only. To use it from another country, do **not** open the database port to the internet. Pick one:

- **VPS + private tunnel:** run the lab on a small Ubuntu VPS, keep the port closed, and connect through WireGuard or `ssh -L`.
- **Managed service:** use a managed free tier for this engine and point the same examples at its connection string.
- **HTTP UI only:** if the engine has a web UI, put it behind Caddy with TLS and basic auth.

The shared checklist, provider map, and commands are in **[REMOTE-ACCESS.md](https://github.com/devarent/database-labs/blob/main/REMOTE-ACCESS.md)**.

## Cleanup

```bash
docker compose down -v
```

`-v` also removes the named volume, so the next start is a clean slate.

## References

- [Cassandra documentation](https://cassandra.apache.org/doc/latest/)
- [CQL reference](https://cassandra.apache.org/doc/latest/cassandra/developing/cql/cql-ref.html)
- [Cassandra Docker image](https://hub.docker.com/_/cassandra)

---

<sub>Part of the <a href="https://github.com/devarent/database-labs">database-labs</a> collection: 26 database engines, one index.</sub>

## License

MIT (c) 2026 Arya Fatthurahman. See [LICENSE](LICENSE).
