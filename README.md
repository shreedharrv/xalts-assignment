Steps Followed:

1. Created a flask api (app.py)
2. Created a Dockerfile to containerize the API and oushed it to my personal Dockerhub repository and made it public (docker pull sid75747docker/flask-api:latest).
3. Created a terraform script(Terraform.tf) to launch the instance and deploy the docker image which can be accessed from browser or any UI. 
(Note: Using access key & Secret key is not recommended but used it since it was mentioned the assignment that evaluator need to put in their keys to provision the instance)
