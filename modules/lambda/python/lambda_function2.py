import json
import boto3
import hashlib as h

def lambda_handler2(event,context):
    bucket_name = event["Records"][0]["s3"]["bucket"]["name"]
    s3 = boto3.resource('s3')
    prefix = "md5_result/"
    #obj = s3.Object(bucket_name, itemname)
    file_paths = []
    md5_values = []
    print("Validating the results ......")
    count = 0
    for file in s3.Bucket(bucket_name).objects.filter(Prefix=prefix):
        if file.key.endswith(".dat"):
            count +=1
            print(file.key.split("/")[-1])
            data = file.get()['Body'].read()
            data_list = data.decode("UTF-8").split("\n")
            data_dict = {data_line.split("|")[-1] : data_line.split("|")[0] for data_line in data_list}
            globals()[f"data_dict{count}"] = data_dict
            try:
                globals()[f"data_dict{count}"].pop('')
            except:
                print("No empty data")
            print(len(globals()[f"data_dict{count}"]))
    if count>=2:
        result_set = set(data_dict1.keys()).difference(set(data_dict2.keys()))
        print("result_set :",result_set)
        with open ("/tmp/validation_results.dat",'wb') as temp_file:
            if len(result_set)==0:
                print("All Passed....")
                temp_file.writelines([f"{data_dict1[key].rsplit('/',1)[-1]} ----->> PASSED\n".encode("UTF-8") for key in list(data_dict1.keys())])
            else:
                print("failure....")
                temp_file.writelines([f"{data_dict1[key].rsplit('/',1)[-1]} ----->> FAILED\n".encode("UTF-8") for key in list(result_set)])
                try :
                    temp_file.writelines([f"{data_dict1[key].rsplit('/',1)[-1]} ----->> PASSED\n".encode("UTF-8") for key in list(data_dict1.keys()) if key not in list(result_set)])
                except:
                    print("Handled...")
    print("Done Successfuly.......")
    s3.Bucket(bucket_name).upload_file("/tmp/validation_results.dat","md5_result/validation_results.dat")
    return {
    'statusCode': 200,
    'body': json.dumps('VALIDATION RESULT FILE GENERATED')
    }
   