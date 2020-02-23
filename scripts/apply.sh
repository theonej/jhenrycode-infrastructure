echo $env

cd ./env/stage

terraform init
terraform plan

terraform apply -auto-approve