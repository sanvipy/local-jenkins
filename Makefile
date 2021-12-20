deploy: app ## Deploy landing zone cluster and jenkins in order

teardown: cluster-delete ## Teardown, just the reverse order.

init:
	echo "Start init"

app: cluster	## Dependendent on cluster
	echo "Start deploying jenkins"
	terraform init
	terraform apply -auto-approve -var-file="dev.tfvars"

cluster:
	echo "Start deploying cluster"
	kind create cluster --name terraform-learn --config kind/config.yaml
	kubectl cluster-info --context kind-terraform-learn 
	echo "Cluster deployed"

app-delete: 
	echo "Start deleting jenkins"
	terraform destroy -auto-approve -var-file="dev.tfvars"
	echo "jenkins deleted"

cluster-delete: app-delete 
	echo "Start deleting cluster"
	kind delete cluster --name terraform-learn
	echo "Cluster deleted"	

