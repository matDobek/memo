build:
	docker-compose build

test: down build
	./bin/test.sh

serve:
	docker-compose up -d

down:
	docker-compose down

ash: down build
	docker-compose run --rm app ash

## In case we have files witch such names, make them out-of-date
.PHONY: build test serve down ash
