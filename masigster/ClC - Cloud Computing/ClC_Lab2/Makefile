build:
	export DOCKER_BUILDKIT=0
	docker-compose up --build

terminate:
	docker-compose down

rerun:
	make terminate
	make build

clear:
	make terminate
	docker system prune -a --volumes -f

rebuild:
	make terminate
	make clear
	make build
