# 🚀 Kong Traditional Mode - Run Steps

## 1. Clean environment

docker stop $(docker ps -q)
docker rm -f $(docker ps -aq)
docker volume prune -f
docker network prune -f
docker system prune -a --volumes -f

## 2. Remove old database

Delete folder:
C:\Abhinay\Code\Kong\kong-traditional\data\postgres

Recreate:
mkdir C:\Abhinay\Code\Kong\kong-traditional\data\postgres

## 3. Start PostgreSQL

docker compose up -d kong-db

## 4. Wait for DB to be ready

docker logs -f kong-db

Wait for:
database system is ready to accept connections

## 5. Run migrations (only once)

docker compose run --rm kong kong migrations bootstrap

## 6. Start Kong

docker compose up -d kong

## 7. Verify

docker compose ps

## 8. Test Kong

curl http://localhost:8001

## 9. Create Service

curl -i -X POST http://localhost:8001/services --data name=example-service --data url=https://httpbin.org

## 10. Create Route

curl -i -X POST http://localhost:8001/services/example-service/routes --data paths[]=/test

## 11. Test via Proxy

http://localhost:8000/test

## 12. Restart (next time)

docker compose up -d kong-db kong
