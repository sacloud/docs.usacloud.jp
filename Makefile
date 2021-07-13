default: preview

TOP_DIR := src/top
USACLOUD_DIR := src/usacloud
USACON_DIR := src/usacon
TERRAFORM_V1_DIR := src/terraform-v1
TERRAFORM_V2_DIR := src/terraform
AUTOSCALER_DIR := src/autoscaler

.PHONY: build lint

build-textlint:
	@echo "building sacloud/textlint:local"
	@docker build -t sacloud/textlint:local .github/actions/textlint

build-mkdocs:
	@echo "building sacloud/mkdocs:local"
	@docker build -t sacloud/mkdocs:local .github/actions/mkdocs

lint: build-textlint
	@echo "running textlint in $(TOP_DIR)..."
	@(cd $(TOP_DIR); make lint)
	@echo "running textlint in $(TERRAFORM_V2_DIR)..."
	@(cd $(TERRAFORM_V2_DIR); make lint)
	@echo "running textlint in $(USACLOUD_DIR)..."
	@(cd $(USACLOUD_DIR); make lint)
	@echo "running textlint in $(USACON_DIR)..."
	@(cd $(USACON_DIR); make lint)
	@echo "running textlint in $(AUTOSCALER_DIR)..."
	@(cd $(AUTOSCALER_DIR); make lint)

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

.PHONY: preview-usacon
preview-usacon:
	@(cd $(USACON_DIR); make preview)

.PHONY: preview-autoscaler
preview-autoscaler:
	@(cd $(AUTOSCALER_DIR); make preview)


clean:
	@echo "cleaning in $(TOP_DIR)..."
	@(cd $(TOP_DIR); make clean)
	@echo "cleaning in $(TERRAFORM_V1_DIR)..."
	@(cd $(TERRAFORM_V1_DIR); make clean)
	@echo "cleaning in $(TERRAFORM_V2_DIR)..."
	@(cd $(TERRAFORM_V2_DIR); make clean)
	@echo "cleaning in $(USACLOUD_DIR)..."
	@(cd $(USACLOUD_DIR); make clean)
	@echo "cleaning in $(USACON_DIR)..."
	@(cd $(USACON_DIR); make clean)
	@echo "cleaning in $(AUTOSCALER_DIR)..."
	@(cd $(AUTOSCALER_DIR); make clean)
