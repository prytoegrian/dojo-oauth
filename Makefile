install:
	php composer.phar install

up:
	docker-compose up --build -d

down:
	docker-compose down


