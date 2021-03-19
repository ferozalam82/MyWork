#!/usr/bin/bash
######################################################################################################
# File Name:	#
# Created On:	#
# Created By:	#
# Description:	#
######################################################################################################
#Enable this option only for debugging 
set -vx

#Record the execution time of the script
CURRENT_DATE=`date +%d%m%Y.%H%M%S`

#EMAIL ID TO BE USED TO SEND THE MAIL
FROM_EMAIL=''

#EMAIL ID  OF THE TEAM TO BE NOTIFIED
NOTIFY_EMAIL=''

#SET THE PATH WHERE THE FILE IS PRESENT
FILE_PATH=''

#Run a loop to process the file in the path
for FILE in ${FILE_PATH}/*;
do
	#Read only the file name exclusing the file path
	FILE_NAME=`basename ${FILE}`
	
	#Concatenate the filename to create the list of files to be zipped
	ATTACH_FILE+="${FILE_NAME} "
	
	#Back up the file with execution time of the script
	cp -p $FILE "${FILE_PATH}/${FILE_NAME}.${CURRENT_DATE}"
	
done

#DEFINE THE ZIP FILEANAME
ZIP_FILE_NAME="ARCHIVEFILE_`date "+%d-%m-%Y"`.zip"

#Change to the path to execute the ZIP Command
cd ${FILE_PATH}

#ZIP the files to a file
zip -q ${ZIP_FILE_NAME} ${ATTACH_FILE}

#Mail the file to the to the team to be notified
mailx -r ${FROM_EMAIL} -s "Demo Mail `date "+%d-%m-%Y"`" -a ${ZIP_FILE_NAME} ${NOTIFY_EMAIL} <<EOF
This is a Demo Mail

Thanks and Regards
Team Avengers

EOF

#Pause the script execution for sending the file over mail
sleep 120

#Remove the ZIP file
rm ${ZIP_FILE_NAME}
