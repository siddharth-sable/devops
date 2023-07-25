#Jenkins - Cleanup EC2 instances created by AWS BOTO3 Python script - manually, github Webhook, at particular time interval (10 PM)


from datetime import datetime
import boto3

client = boto3.client('ec2')

ec2 = boto3.resource('ec2')


def get_all_instance_ids():
    ec2_client = boto3.client('ec2')
    response = ec2_client.describe_instances()
    instance_ids = []
    
    for reservation in response['Reservations']:
        for instance in reservation['Instances']:
            instance_ids.append(instance['InstanceId'])
            
    return instance_ids


def terminate_instances(instance_ids):
    ec2_client = boto3.client('ec2')
    
    try:
        response = ec2_client.terminate_instances(InstanceIds=instance_ids)
        
        for instance in response['TerminatingInstances']:
            print(f"Terminating instance {instance['InstanceId']}: {instance['CurrentState']['Name']}")
        
    except Exception as e:
        print(f"Error terminating instances: {e}")



myobj = datetime.now()
if myobj.hour == 22:
    instances = get_all_instance_ids()
    responce = terminate_instances(instances)
    print(responce)




