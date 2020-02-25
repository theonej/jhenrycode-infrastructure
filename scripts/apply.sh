echo $env

cd ./env/${env}

terraform init
terraform plan

terraform apply -auto-approve