# Kong Hybrid Mode Setup (Docker)

This project demonstrates how to run Kong Gateway in Hybrid Mode using Docker Compose.

## Project Structure

kong-hybrid/
│── certs/
│── data/
│ └── postgres/
│── docker-compose.yml
│── README.md

## Prerequisites

- Docker Desktop installed
- Git Bash / Terminal
- Ports: 8000, 8001, 8005

## Step 1: Generate Certificates

cd /c/Abhinay/Code/Kong/kong-hybrid/certs

MSYS_NO_PATHCONV=1 openssl req -new -x509 -nodes -days 365
-subj "/CN=kong_clustering"
-keyout cluster.key
-out cluster.crt

## Step 2: Start PostgreSQL

docker compose up -d kong-db

Wait until logs show:
database system is ready to accept connections

## Step 3: Run Migrations (Only Once)

docker compose run --rm kong-migrations

## Step 4: Start Control Plane

docker compose up -d kong-cp

## Step 5: Start Data Plane

docker compose up -d kong-dp

## Step 6: Verify

curl http://localhost:8001
curl http://localhost:8000

## Step 7: Test

Create Service:
curl -i -X POST http://localhost:8001/services --data "name=httpbin" --data "url=http://httpbin.org"

Create Route:
curl -i -X POST http://localhost:8001/services/httpbin/routes --data "paths[]=/test"

Test:
curl http://localhost:8000/test

## Stop & Restart

docker compose down
docker compose up -d

## Full Reset

docker compose down -v

## Notes

- Run migrations only once
- Data plane does not use DB
- Ignore minor warnings in logs

## Sync Kong Configuration with decK

To validate, diff, and sync your configuration to Kong using decK, run:

```
deck gateway validate kong.yaml
deck gateway diff kong.yaml --kong-addr http://localhost:8001
deck gateway sync kong.yaml --kong-addr http://localhost:8001
```
