# Makefile for Laravel Octane with Docker and Swagger Code Generation

# Get the current user's UID and GID
UID := $(shell id -u)
GID := $(shell id -g)

# Path to the Swagger specification file (relative to the Makefile)
SWAGGER_SPEC := ./swagger/storefront/main.yaml

# Initialize the project and install dependencies
init:
	# Create Laravel project in a temporary directory
	docker run --rm -v $(PWD):/app -w /app --user $(UID):$(GID) composer create-project --prefer-dist laravel/laravel temp_laravel
	# Move contents of the temporary directory to the current directory
	mv temp_laravel/* temp_laravel/.* ./ || true
	# Remove the temporary directory
	rm -rf temp_laravel
	# Install dependencies
	$(MAKE) install

# Docker Compose commands
up:
	docker-compose up -d

down:
	docker-compose down

logs:
	docker-compose logs -f

generate:
	docker-compose run --rm --user $(UID):$(GID) swagger generate -i $(SWAGGER_SPEC) -g php-laravel

install:
	docker-compose run --rm --user $(UID):$(GID) composer install

migrate:
	docker-compose run --rm --user $(UID):$(GID) app php artisan migrate

serve:
	docker-compose up app

tinker:
	docker-compose run --rm --user $(UID):$(GID) app php artisan tinker
