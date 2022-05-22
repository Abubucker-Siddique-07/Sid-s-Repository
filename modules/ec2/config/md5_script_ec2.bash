#!bin/bash


#Constants
ROOT_PATH="/home/ec2-user"
FILE_PATH="/home/ec2-user/test_text_files"
MD5_DIR="/home/ec2-user/md5_dir"
BUCKET_NAME=$1



#MAIN PROGRAM STARTS HERE

mkdir $MD5_DIR
ls $FILE_PATH >> "${ROOT_PATH}/temp.dat"
while read -r line ;
do
	md5_value=($(md5sum "${FILE_PATH}/${line}"))
	printf "${FILE_PATH}/${line}|${md5_value}\n" >> "${MD5_DIR}/ec2_md5.dat" 
done < "${ROOT_PATH}/temp.dat"
rm "${ROOT_PATH}/temp.dat"
touch "${ROOT_PATH}/trigger_lambda_function.trigger"
aws s3 cp "${ROOT_PATH}/test_text_files" "s3://${BUCKET_NAME}/test_text_files" --recursive	
aws s3 cp "${ROOT_PATH}/md5_dir/ec2_md5.dat" "s3://${BUCKET_NAME}/md5_result/ec2_md5.dat"
aws s3 cp "${ROOT_PATH}/trigger_lambda_function.trigger" "s3://${BUCKET_NAME}/test_text_files/trigger_lambda_function.trigger"
exit
