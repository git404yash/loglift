#!/bin/bash
# Jenkins CI/CD Log Cost Optimization Script

JENKINS_HOME=/var/lib/jenkins
S3_BUCKET=jenkins-cost-optimization
DATE=$(date +%Y-%m-%d)
RETENTION_DAYS=7

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "AWS CLI is not installed. Exiting."
    exit 1
fi

# Iterate through Jenkins jobs
for job_dir in "$JENKINS_HOME/jobs/"*; do
    job_name=$(basename "$job_dir")

    # Iterate through build directories
    for build_dir in "$job_dir/builds/"*; do
        build_number=$(basename "$build_dir")
        log_file="$build_dir/log"

        # Process only today's logs
        if [ -f "$log_file" ] && \
           [ "$(date -r "$log_file" +%Y-%m-%d)" == "$DATE" ]; then

            # Compress the log
            gzip -c "$log_file" > "$log_file.gz"

            # Upload compressed log to S3
            aws s3 cp "$log_file.gz" \
            "s3://$S3_BUCKET/$job_name-$build_number.log.gz" \
            --only-show-errors

            if [ $? -eq 0 ]; then
                echo "Uploaded: $job_name/$build_number"

                # Delete local compressed file after upload
                rm -f "$log_file.gz"
            else
                echo "Upload failed: $job_name/$build_number"
            fi
        fi
    done
done

# Retention policy: delete logs older than N days
find "$JENKINS_HOME/jobs" -type f -name "log" -mtime +$RETENTION_DAYS -delete

