# Awesome Project Build with TypeORM

Steps to run this project:

1. Run `docker-compose up -d` command
2. Check API inside container

* про клієнтів, які проживають у заданому номері
```
docker-compose exec app wget -qO - localhost:3000/api/v1/guests/rooms/1-3
docker-compose exec app wget -qO - localhost:3000/api/v2/guests/rooms/1-3
```
* про клієнтів, які які прибули із заданого міста
```
docker-compose exec app wget -qO - localhost:3000/api/v1/guests/from/Kharkiv
docker-compose exec app wget -qO - localhost:3000/api/v2/guests/from/Kharkiv
```
* про те, хто із службовців прибирав номер у заданий день
```
docker-compose exec app wget -qO - localhost:3000/api/v1/staff/rooms/2-2/2001-01-11
docker-compose exec app wget -qO - localhost:3000/api/v2/staff/rooms/2-2/2001-01-11
```
