default: lint

.PHONY: build preview lint
build:
	@docker run -it --rm \
           -v $$PWD:/workdir \
           -w /workdir \
           --entrypoint mkdocs \
           sacloud/mkdocs:local build --clean --strict

preview:
	@echo "servind docs on http://localhost:8080"
	@docker run -it --rm \
           -v $$PWD:/workdir \
           -w /workdir \
           -p 8080:8080 \
           --entrypoint mkdocs \
           sacloud/mkdocs:local serve --dev-addr=0.0.0.0:8080

lint:
	@docker run -it --rm -v $$PWD:/work -w /work ghcr.io/sacloud/textlint-action:v0.0.3 .

clean:
	rm -rf site/*
