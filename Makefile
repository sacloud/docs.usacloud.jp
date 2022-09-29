default: preview

TOP_DIR := src/top
USACLOUD_DIR := src/usacloud
TERRAFORM_V1_DIR := src/terraform-v1
TERRAFORM_V2_DIR := src/terraform
AUTOSCALER_DIR := src/autoscaler
PROMETHEUS_DIR := src/prometheus

.PHONY: build lint

build-mkdocs:
	@echo "building sacloud/mkdocs:local"
	@docker build -t sacloud/mkdocs:local .github/actions/mkdocs

build-all:
	@echo "running mkdocs in $(TOP_DIR)..."
	@(cd $(TOP_DIR); make build)
	@echo "running mkdocs in $(TERRAFORM_V2_DIR)..."
	@(cd $(TERRAFORM_V2_DIR); make build)
	@echo "running mkdocs in $(USACLOUD_DIR)..."
	@(cd $(USACLOUD_DIR); make build)
	@echo "running mkdocs in $(AUTOSCALER_DIR)..."
	@(cd $(AUTOSCALER_DIR); make build)
	@echo "running mkdocs in $(PROMETHEUS_DIR)..."
	@(cd $(PROMETHEUS_DIR); make build)

lint:
	@echo "running textlint in $(TOP_DIR)..."
	@(cd $(TOP_DIR); make lint)
	@echo "running textlint in $(TERRAFORM_V2_DIR)..."
	@(cd $(TERRAFORM_V2_DIR); make lint)
	@echo "running textlint in $(USACLOUD_DIR)..."
	@(cd $(USACLOUD_DIR); make lint)
	@echo "running textlint in $(AUTOSCALER_DIR)..."
	@(cd $(AUTOSCALER_DIR); make lint)
	@echo "running textlint in $(PROMETHEUS_DIR)..."
	@(cd $(PROMETHEUS_DIR); make lint)


.PHONY: preview-top
preview-top:
	@(cd $(TOP_DIR); make preview)

.PHONY: preview-terraform-v1
preview-terraform-v1:
	@(cd $(TERRAFORM_V1_DIR); make preview)

.PHONY: preview-terraform
preview-terraform:
	@(cd $(TERRAFORM_V2_DIR); make preview)

.PHONY: preview-usacloud
preview-usacloud:
	@(cd $(USACLOUD_DIR); make preview)

.PHONY: preview-autoscaler
preview-autoscaler:
	@(cd $(AUTOSCALER_DIR); make preview)

.PHONY: preview-prometheus
preview-prometheus:
	@(cd $(PROMETHEUS_DIR); make preview)


clean:
	@echo "cleaning in $(TOP_DIR)..."
	@(cd $(TOP_DIR); make clean)
	@echo "cleaning in $(TERRAFORM_V1_DIR)..."
	@(cd $(TERRAFORM_V1_DIR); make clean)
	@echo "cleaning in $(TERRAFORM_V2_DIR)..."
	@(cd $(TERRAFORM_V2_DIR); make clean)
	@echo "cleaning in $(USACLOUD_DIR)..."
	@(cd $(USACLOUD_DIR); make clean)
	@echo "cleaning in $(AUTOSCALER_DIR)..."
	@(cd $(AUTOSCALER_DIR); make clean)
	@echo "cleaning in $(PROMETHEUS_DIR)..."
	@(cd $(PROMETHEUS_DIR); make clean)
