create queue:
aws --endpoint-url=http://localhost:4566 sqs create-queue --queue-name jab

list queues:
aws --endpoint-url=http://localhost:4566 sqs list-queues

delete queue:
aws --endpoint-url=http://sqs.us-west-2.localhost.localstack.cloud:4566/000000000000/jab sqs delete-queue --queue-url http://localhost:4566/000000000000/jab

send message to queue:
aws --endpoint-url=http://localhost:4566 sqs send-message --queue-url http://sqs.us-west-2.localhost.localstack.cloud:4566/000000000000/jab --message-body "Hello, World!"

generate lambda:
dotnet lambda package --configuration Release --framework net6.0 --output-package ./lambda.zip
dotnet lambda package --output-package ../lambda.zip

create lambda:
aws --endpoint-url=http://localhost:4566 lambda create-function --function-name demo-lambda --runtime dotnet6 --handler LambdaDemo::LambdaDemo.Function::Handler --zip-file fileb://lambda.zip --role arn:aws:iam::000000000000:role/lambda-role

update-lambda:
aws --endpoint-url=http://localhost:4566 lambda update-function-code --function-name demo-lambda --zip-file fileb://lambda.zip

delete lambda:
aws --endpoint-url=http://localhost:4566 lambda delete-function --function-name demo-lambda

associate queue with lambda:
aws --endpoint-url=http://localhost:4566 lambda create-event-source-mapping --function-name demo-lambda --batch-size 1 --event-source-arn arn:aws:sqs:us-west-2:000000000000:jab

disassociate queue with lambda:
aws --endpoint-url=http://localhost:4566 lambda delete-event-source-mapping --uuid 734588f7-8001-4d4b-abbf-cdaded4f4826

view logs:
aws --endpoint-url=http://localhost:4566 logs describe-log-groups

get streams:
aws --endpoint-url=http://localhost:4566 logs describe-log-streams --log-group-name /aws/lambda/demo-lambda

view events:
aws --endpoint-url=http://localhost:4566 logs get-log-events --log-group-name /aws/lambda/demo-lambda --log-stream-name recibido

aws --endpoint-url=http://localhost:4566 cloudwatch put-metric-data --namespace "LambdaMetrics" --metric-name "EjecucionesExitosas" --dimensions FunctionName=demo-lambda --value 1 --unit Count
