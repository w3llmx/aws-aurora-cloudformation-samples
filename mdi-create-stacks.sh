aws cloudformation create-stack \
--template-body file:///Users/acissera/Development/wellcome/aws-aurora-cloudformation-samples/cftemplates/VPC-3AZs.yml \
--stack-name mdi-db-networking-stack

aws cloudformation create-stack \
--template-body file:///Users/acissera/Development/wellcome/aws-aurora-cloudformation-samples/cftemplates/VPC-SSH-Bastion.yml \
--stack-name mdi-db-bastionhost-stack --parameters \
ParameterKey=KeyPairName,ParameterValue=mdi-db-bastion \
ParameterKey=ParentVPCStack,ParameterValue=mdi-db-networking-stack \
ParameterKey=NotificationList,ParameterValue=acisser@gmail.com \
ParameterKey=RemoteAccessCIDR,ParameterValue=0.0.0.0/0 --capabilities CAPABILITY_NAMED_IAM

aws cloudformation update-stack \
--template-body file:///Users/acissera/Development/wellcome/aws-aurora-cloudformation-samples/cftemplates/Aurora-Postgres-DB-Cluster.yml \
--stack-name mdi-db-aurorapostgres-stack --parameters \
ParameterKey=ParentVPCStack,ParameterValue=mdi-db-networking-stack \
ParameterKey=ParentSSHBastionStack,ParameterValue=mdi-db-bastionhost-stack \
ParameterKey=DBName,ParameterValue=mdi \
ParameterKey=DBUsername,ParameterValue=postgres \
ParameterKey=DBEngineVersion,ParameterValue=11.6 \
ParameterKey=DBInstanceClass,ParameterValue=db.t3.medium \
ParameterKey=ServiceOwnersEmailContact,ParameterValue=vvt@smgeeks.com \
ParameterKey=Compliance,ParameterValue=other \
ParameterKey=ProjectCostCenter,ParameterValue=0000 \
ParameterKey=NotificationList,ParameterValue=acisser@gmail.com \
ParameterKey=Confidentiality,ParameterValue=confidential \
ParameterKey=Application,ParameterValue=MdiApp --capabilities CAPABILITY_NAMED_IAM

aws cloudformation create-stack --template-body file:///Users/acissera/Development/wellcome/s3-trigger-lambda.yml \
--stack-name mdi-s3-notifications-stack  --parameters \
ParameterKey=NotificationBucket,ParameterValue=mdicmstorage01356-dev --capabilities CAPABILITY_NAMED_IAM
