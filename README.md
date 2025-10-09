
# loglift
Automates Jenkins log archival to Amazon S3 to reduce CI/CD server storage 
costs and improve pipeline performance. Includes daily log detection, 
secure S3 upload, and lifecycle-based cost optimization.

![Bash](https://img.shields.io/badge/Script-Bash-blue?logo=gnu-bash&logoColor=white)
![AWS 
S3](https://img.shields.io/badge/Storage-AWS%20S3-orange?logo=amazonaws&logoColor=white)
![Jenkins](https://img.shields.io/badge/CI%2FCD-Jenkins-red?logo=jenkins&logoColor=white)
![Linux](https://img.shields.io/badge/OS-Linux-green?logo=linux&logoColor=white)
![License: 
MIT](https://img.shields.io/badge/License-MIT-yellow?logo=open-source-initiative&logoColor=white)
![Made with ❤️ by Yash 
Kulkarni](https://img.shields.io/badge/Made%20with-%E2%9D%A4%EF%B8%8F%20by%20Yash%20Kulkarni-pink)
![Maintenance](https://img.shields.io/badge/Maintained-Yes-brightgreen?logo=githubactions&logoColor=white)

🚀 Features

Automatically uploads today’s build logs to S3

Maintains clear naming convention: <job_name>-<build_number>.log

Verifies AWS CLI installation before running

Provides detailed success/failure output for each upload

Easy to automate via cron job

🏗️ How It Works

The script checks for the AWS CLI installation.

It scans Jenkins job directories in /var/lib/jenkins/jobs/.

For each build that has a log file created today, it uploads it to your S3 
bucket.



