import json
import boto3
import hashlib as h
#from natsort import natsorted

def lambda_handler(event, context):
    bucket_name = event["Records"][0]["s3"]["bucket"]["name"]
    s3 = boto3.resource('s3')
    #itemname = "test_text_files/text9.txt"
    prefix = "test_text_files/"
    #obj = s3.Object(bucket_name, itemname)
    file_paths = []
    md5_values = []
    for file in s3.Bucket(bucket_name).objects.filter(Prefix=prefix):
        if file.key.endswith(".txt"):
            print(file.key.split("/")[-1])
            file_path = f"s3://{bucket_name}/{file.key}"
            file_paths.append(file_path)
            data = file.get()['Body'].read()
            md5_value = h.md5(data).hexdigest()
            md5_values.append(md5_value)
            print("md5_value :",md5_value)
    with open ("/tmp/md5_file.dat",'wb') as temp_file:
        for i in range(len(file_paths)):
            temp_file.write((file_paths[i]+"|"+md5_values[i]+"\n").encode("UTF-8"))
    print("Done Successfuly.......")
    s3.Bucket(bucket_name).upload_file("/tmp/md5_file.dat","md5_result/md5_file.dat")
    return {
        'statusCode': 200,
        'body': json.dumps('MD5 HASH FILE GENERATED')
    }