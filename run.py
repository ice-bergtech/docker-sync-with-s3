import os
access_key = os.environ.get('ACCESS_KEY')
secret_key = os.environ.get('SECRET_KEY')
bucket_location = os.environ.get('BUCKET_LOCATION')
cron_schedule = os.environ.get('CRON_SCHEDULE')
source_path = os.environ.get('SOURCE_PATH')
destination_path = os.environ.get('DESTINATION_PATH')
endpoint_url = os.environ.get('ENDPOINT_URL')
S3SYNC_ARGS = os.environ.get('S3SYNC_ARGS')

if S3SYNC_ARGS == None:
    S3SYNC_ARGS = ""


# create dictionary of environment variables
env_dict = {}
env_dict['ACCESS_KEY'] = access_key
env_dict['SECRET_KEY'] = secret_key
env_dict['BUCKET_LOCATION'] = bucket_location
env_dict['CRON_SCHEDULE'] = cron_schedule
env_dict['SOURCE_PATH'] = source_path
env_dict['DESTINATION_PATH'] = destination_path
env_dict['ENDPOINT_URL'] = endpoint_url
env_dict['S3SYNC_ARGS'] = S3SYNC_ARGS


# function to add environment variables to file
def add_env_variables(file, env_dict):
    for key in env_dict:
        file = file.replace(key, env_dict[key])
    return file


# read file for crontabs
with open('/etc/crontabs/root', 'r') as in_file:
    text = in_file.read()

# write file for crontabs
with open('/etc/crontabs/root', 'w') as out_file:
    out_file.write(add_env_variables(text, env_dict))

