using Amazon.Lambda.SQSEvents;
using Amazon.Lambda.Core;

[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.SystemTextJson.DefaultLambdaJsonSerializer))]

namespace LambdaDemo;

public class Function
{
    public async Task Handler(SQSEvent evnt, ILambdaContext context)
    {
        foreach (var record in evnt.Records)
        {
            Console.WriteLine($"Mensaje recibido: {record.Body}");
        }
    }
}
