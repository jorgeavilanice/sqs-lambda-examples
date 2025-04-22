$ENDPOINT = "http://localhost:4566"

# Create queue
aws --endpoint-url=$ENDPOINT sqs create-queue --queue-name demo-queue

# Create Lambda
aws --endpoint-url=$ENDPOINT lambda create-function --function-name demo-lambda --runtime dotnet6 --handler LambdaDemo::LambdaDemo.Function::Handler --zip-file fileb://lambda.zip --role arn:aws:iam::000000000000:role/lambda-role

# Create trigger SQS → Lambda
aws --endpoint-url=$ENDPOINT lambda create-event-source-mapping --function-name demo-lambda --batch-size 1 --event-source-arn arn:aws:sqs:us-west-2:000000000000:demo-queue
