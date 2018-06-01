#!/bin/bash
# upload the contents of the entire directory using the AWS CLI installed in the venv
# for help see:
# aws s3 sync help
# aws s3 help

unset PYTHONPATH
source venv/bin/activate
export AWS_ACCESS_KEY_ID=ABCDEFG
export AWS_SECRET_ACCESS_KEY=foo/bar

set -x
aws s3 sync . s3://bucket-id # --dryrun
