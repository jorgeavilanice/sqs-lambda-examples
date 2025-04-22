using Amazon.SQS;
using Amazon.SQS.Model;

var config = new AmazonSQSConfig
{
    ServiceURL = "http://localhost:9324" // ElasticMQ endpoint
};

var client = new AmazonSQSClient("x", "x", config);

// Leer la cola si no existe
var queueUrl = (await client.GetQueueUrlAsync("jab")).QueueUrl;

Console.WriteLine("⏳ Esperando mensajes...");

// Simular Lambda escuchando la cola
while (true)
{
    var messages = await client.ReceiveMessageAsync(new ReceiveMessageRequest
    {
        QueueUrl = queueUrl,
        MaxNumberOfMessages = 1,
        WaitTimeSeconds = 10
    });

    foreach (var message in messages.Messages)
    {
        Console.WriteLine($"📩 Mensaje recibido: {message.Body}");

        // Simula la ejecución de la lógica de la Lambda
        await client.DeleteMessageAsync(queueUrl, message.ReceiptHandle);
    }
}
