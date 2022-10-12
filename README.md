# docker-sync-with-s3

[![Docker](https://github.com/ice-bergtech/docker-sync-with-s3/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/ice-bergtech/docker-sync-with-s3/actions/workflows/docker-publish.yml)

Docker image that runs a single cron job to sync files with S3 as defined via environment variables.

This image can be used to either sync files from a container to S3 or from S3 to a container. 

It is intended that a single instance of this image will run a single cron job and sync process. If you have multiple 
directories to sync, then you should run multiple containers each with the appropriate configuration for that directory. 

## Docker Image

This image is built automatically and published to on the Docker Hub as [ghcr.io/ice-bergtech/docker-sync-with-s3](https://github.com/ice-bergtech/docker-sync-with-s3/pkgs/container/docker-sync-with-s3).

```
docker pull ghcr.io/ice-bergtech/docker-sync-with-s3:latest
```

## Running locally

1. Clone this repo
2. Copy `local.env.dist` to `local.env` and update values as appropriate
3. Run `docker-compose up -d`

## Expected Environment Variables

1. `ACCESS_KEY` - S3 Access Key
2. `SECRET_KEY` - S3 Secret Access Key
3. `CRON_SCHEDULE` - Schedule for cron job, for every 15 minutes it would be: `*/15 * * * *`
4. `SOURCE_PATH` - Source files to be synced, example: `/var/www/uploads`
5. `DESTINATION_PATH` - Destination of where to sync files to, example: `s3://my-bucket/site-uploads`
6. `BUCKET_LOCATION` - AWS Region for bucket, ex: `us-east-1`
7. `LOGENTRIES_KEY` - (optional) If provided, the image will send command output to syslog with priority `user.info`.
8. `S4SYNC_ARGS` - (optional) If provided, the arguments will be included in the `s3cmd dsync` command. For example, setting `S4SYNC_ARGS=--delete` will cause files in the destination to be deleted if they no longer exist in the source.
9. `ENDPOINT_URL` - endpoint url used in boto3 client

## Volumes

You will need to define volumes in your Docker configuration for sharing filesystem between your application 
containers and this sync container.
