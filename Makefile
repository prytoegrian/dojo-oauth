install:
	php composer.phar install

up:
	docker-compose up --build -d

down:
	docker-compose down

attach-web:
	docker exec -ti web bash

attach-mysql:
	docker exec -ti mysql mysql -u root -proot
