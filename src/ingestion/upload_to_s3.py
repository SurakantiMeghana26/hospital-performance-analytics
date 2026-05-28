"""
S3 Upload Script
================
Uploads extracted healthcare data to AWS S3 bucket.

Author: Surakanti Meghana
Project: US Hospital Performance Analytics Platform
"""

import boto3
import os
import logging
from datetime import datetime

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

# Configuration
BUCKET_NAME = 'hospital-analytics-meghana-2026'
LOCAL_DATA_DIR = 'data/raw/cms'
S3_PREFIX = 'raw/cms'


def upload_file_to_s3(local_path, bucket, s3_key):
    """
    Upload a single file to S3.
    
    Args:
        local_path: Local file path
        bucket: S3 bucket name
        s3_key: S3 object key (path in bucket)
    
    Returns:
        True if successful, False otherwise
    """
    try:
        s3_client = boto3.client('s3')
        
        file_size = os.path.getsize(local_path)
        size_mb = file_size / (1024 * 1024)
        
        logger.info(f'Uploading: {local_path}')
        logger.info(f'  Size: {size_mb:.2f} MB')
        logger.info(f'  Destination: s3://{bucket}/{s3_key}')
        
        s3_client.upload_file(local_path, bucket, s3_key)
        
        logger.info(f'  [SUCCESS] Uploaded!')
        return True
        
    except Exception as e:
        logger.error(f'  [ERROR] Upload failed: {e}')
        return False


def upload_directory(local_dir, bucket, s3_prefix):
    """
    Upload all files in a directory to S3.
    
    Args:
        local_dir: Local directory path
        bucket: S3 bucket name
        s3_prefix: S3 prefix (folder path)
    
    Returns:
        Number of successful uploads
    """
    if not os.path.exists(local_dir):
        logger.error(f'Directory not found: {local_dir}')
        return 0
    
    success_count = 0
    
    for root, dirs, files in os.walk(local_dir):
        for file in files:
            local_path = os.path.join(root, file)
            
            # Calculate S3 key (preserve folder structure)
            relative_path = os.path.relpath(local_path, local_dir)
            relative_path = relative_path.replace('\\', '/')  # Windows fix
            s3_key = f'{s3_prefix}/{relative_path}'
            
            if upload_file_to_s3(local_path, bucket, s3_key):
                success_count += 1
    
    return success_count


def verify_s3_upload(bucket, prefix):
    """List uploaded files in S3."""
    try:
        s3_client = boto3.client('s3')
        response = s3_client.list_objects_v2(
            Bucket=bucket,
            Prefix=prefix
        )
        
        if 'Contents' in response:
            logger.info(f'\nFiles in s3://{bucket}/{prefix}:')
            for obj in response['Contents']:
                size_mb = obj['Size'] / (1024 * 1024)
                logger.info(f'  - {obj["Key"]} ({size_mb:.2f} MB)')
            return len(response['Contents'])
        else:
            logger.warning('No files found in S3')
            return 0
            
    except Exception as e:
        logger.error(f'Error verifying uploads: {e}')
        return 0


def main():
    """Main upload workflow."""
    logger.info('=' * 60)
    logger.info('S3 UPLOAD - HEALTHCARE DATA')
    logger.info('=' * 60)
    logger.info(f'\nBucket: {BUCKET_NAME}')
    logger.info(f'Local Directory: {LOCAL_DATA_DIR}')
    logger.info(f'S3 Prefix: {S3_PREFIX}\n')
    
    # Upload files
    success_count = upload_directory(LOCAL_DATA_DIR, BUCKET_NAME, S3_PREFIX)
    
    logger.info('\n' + '=' * 60)
    logger.info(f'Upload Summary: {success_count} files uploaded')
    logger.info('=' * 60)
    
    # Verify uploads
    logger.info('\nVerifying S3 uploads...')
    file_count = verify_s3_upload(BUCKET_NAME, S3_PREFIX)
    
    logger.info('\n' + '=' * 60)
    logger.info('UPLOAD COMPLETE!')
    logger.info('=' * 60)
    logger.info(f'Files uploaded: {success_count}')
    logger.info(f'Files verified in S3: {file_count}')
    logger.info('=' * 60)


if __name__ == '__main__':
    main()