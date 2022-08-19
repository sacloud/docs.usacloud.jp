default: lint

.PHONY: build preview lint
build:
	@docker run -it --rm \
           -v $$PWD:/workdir \
           -p 80:80 \
           sacloud/mkdocs:latest build --clean --quiet

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

generate:
	go run tools/*.go $(CURDIR)/scaffold
