install:
	php composer.phar install

up:
	docker-compose up --build -d

down:
	docker-compose down

start:
	docker-compose start

stop:
	docker-compose stop

attach-web:
	docker exec -ti oauth-web bash

attach-mysql:
	docker exec -ti oauth-mysql mysql -u root -proot
