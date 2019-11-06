#!/bin/bash

SHELL := /bin/bash
DOCKER_HUB_PROFILE := pedrogoncalves

run:
	export FLASK_APP='simple_api/simple_api.py';\
	flask run --host 0.0.0.0 --port 8081

release:
	echo "make release NOT IMPLEMENTED"

clean:
	find . -name '*.pyc' -exec rm --force {} +
	find . -name '*.pyo' -exec rm --force {} +
	find . | grep -E "__pycache__|.pyc|.DS_Store$$" | xargs rm -rf

clean-build:
	rm --force --recursive build/
	rm --force --recursive dist/
	rm --force --recursive *.egg-info

test:
	pytest

requirements:
	pip freeze > requirements.txt

docker-build:
	docker build -t simple-api .

docker-run:
	docker run --rm -p 8081:8081 --name simple-api simple-api

docker-test:
	docker run --rm --name simple-api simple-api pytest

docker-push:
ifdef TAG
	docker tag `docker images simple-api:latest -q` ${DOCKER_HUB_PROFILE}/simple-api:$(TAG)
	docker push ${DOCKER_HUB_PROFILE}/simple-api:${TAG}
else
	docker tag `docker images simple-api:latest -q` ${DOCKER_HUB_PROFILE}/simple-api:latest
	docker push ${DOCKER_HUB_PROFILE}/simple-api:latest
endif

k8s-deploy:
	helm package helm/simple-api -d helm/
	helm lint helm/simple-api
	helm install helm/simple-api --name simple-api


