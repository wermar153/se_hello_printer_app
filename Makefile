SERVICE_NAME=hello-world-printer
MY_DOCKER_NAME=$(SERVICE_NAME)

deps:
	pip install -r requirements.txt; \
	pip install -r test_requirements.txt

lint:
	flake8 hello_world test

run:
	python main.py

.PHONY: test
test:
	PYTHONPATH=. py.test

test_smoke:
	curl -I --fail 127.0.0.1:5000

docker_build:
	docker build -t $(MY_DOCKER_NAME) .

docker_run: docker_build
	docker run \
	--name hello-wold-printer-dev \
	-p 5000:5000 \
	-d $(MY_DOCKER_NAME)

USERNAME=wermar153
TAG=$(USERNAME)/$(MY_DOCKER_NAME)

docker_push:
	@docker login --username $(USERNAME) --password $${DOCKER_PASSWORD};\
	docker tag $(MY_DOCKER_NAME) $(TAG); \
		docker push $(TAG); \
		docker logout;
