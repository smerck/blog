
TF_DIR := infra/tf

build:
	docker build . --tag hugo-server

dev-server:
	cd hugo; hugo server -D --config content/_default/config.toml

tf-init:
	@cd $(TF_DIR) && terraform init -input=false

plan: tf-init
	cd $(TF_DIR) && terraform plan

deploy: tf-init
	cd $(TF_DIR) && terraform apply -auto-approve

destroy: tf-init
	cd $(TF_DIR) && terraform destroy -auto-approve
