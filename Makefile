# Makefile for Laravel Octane with Docker and Swagger Code Generation

# Initialize the project and install dependencies
init:
	docker run --rm -v $(PWD):/app -w /app composer create-project --prefer-dist laravel/laravel .
	$(MAKE) install

# Docker Compose commands
up:
	docker-compose up -d

down:
	docker-compose down

logs:
	docker-compose logs -f

generate:
	docker-compose run --rm swagger generate

install:
	docker-compose run --rm composer install

migrate:
	docker-compose run --rm app php artisan migrate

serve:
	docker-compose up app

tinker:
	docker-compose run --rm app php artisan tinker
