"""
CMS Hospital Data Extractor
=============================
Extracts US hospital data from CMS Provider Data API.

Author: Surakanti Meghana
Project: US Hospital Performance Analytics Platform
Date: May 2026
"""

import requests
import pandas as pd
import json
import os
from datetime import datetime
import logging

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)


def extract_cms_hospitals(limit=5000):
    """
    Extract hospital data from CMS API.
    
    Args:
        limit: Maximum number of records to fetch
    
    Returns:
        List of hospital records
    """
    logger.info('=' * 60)
    logger.info('CMS HOSPITAL DATA EXTRACTION')
    logger.info('=' * 60)
    
    base_url = 'https://data.cms.gov/provider-data/api/1/datastore/query/xubh-q36u/0'
    
    all_hospitals = []
    offset = 0
    page_size = 500
    
    logger.info(f'Starting extraction (target: {limit} records)')
    
    while len(all_hospitals) < limit:
        url = f'{base_url}?limit={page_size}&offset={offset}'
        
        try:
            logger.info(f'Fetching page (offset: {offset})...')
            response = requests.get(url, timeout=60)
            response.raise_for_status()
            data = response.json()
            
            if 'results' in data:
                results = data['results']
                
                if not results:
                    logger.info('No more records to fetch')
                    break
                
                all_hospitals.extend(results)
                logger.info(f'Retrieved {len(results)} records. Total so far: {len(all_hospitals)}')
                
                offset += page_size
                
                if len(results) < page_size:
                    logger.info('Reached end of dataset')
                    break
            else:
                logger.warning('No results found in response')
                break
                
        except requests.exceptions.RequestException as e:
            logger.error(f'API request failed: {e}')
            break
    
    logger.info(f'\n[SUCCESS] Total hospitals extracted: {len(all_hospitals)}')
    return all_hospitals


def save_data(hospitals, output_dir='data/raw'):
    """
    Save extracted data to CSV and JSON files.
    
    Args:
        hospitals: List of hospital records
        output_dir: Directory to save files
    
    Returns:
        Tuple of (csv_path, json_path)
    """
    # Create date-partitioned directory
    today = datetime.now().strftime('%Y-%m-%d')
    save_dir = os.path.join(output_dir, 'cms', today)
    os.makedirs(save_dir, exist_ok=True)
    
    logger.info(f'\nSaving data to: {save_dir}')
    
    # Convert to DataFrame
    df = pd.DataFrame(hospitals)
    
    # Save as CSV
    csv_path = os.path.join(save_dir, 'hospitals.csv')
    df.to_csv(csv_path, index=False)
    logger.info(f'  ✓ CSV saved: {csv_path}')
    
    # Save as JSON
    json_path = os.path.join(save_dir, 'hospitals.json')
    with open(json_path, 'w') as f:
        json.dump(hospitals, f, indent=2)
    logger.info(f'  ✓ JSON saved: {json_path}')
    
    return csv_path, json_path


def display_summary(hospitals):
    """Display data summary statistics."""
    if not hospitals:
        logger.warning('No data to display')
        return
    
    df = pd.DataFrame(hospitals)
    
    logger.info('\n' + '=' * 60)
    logger.info('DATA SUMMARY')
    logger.info('=' * 60)
    
    logger.info(f'\nTotal Records: {len(df):,}')
    logger.info(f'Total Columns: {len(df.columns)}')
    
    logger.info(f'\nColumns: {", ".join(df.columns[:10])}...')
    
    if 'state' in df.columns:
        logger.info(f'\nTop 5 States by Hospital Count:')
        state_counts = df['state'].value_counts().head(5)
        for state, count in state_counts.items():
            logger.info(f'  {state}: {count} hospitals')
    
    if 'hospital_overall_rating' in df.columns:
        logger.info(f'\nHospital Rating Distribution:')
        rating_counts = df['hospital_overall_rating'].value_counts().sort_index()
        for rating, count in rating_counts.items():
            logger.info(f'  Rating {rating}: {count} hospitals')


def main():
    """Main extraction workflow."""
    logger.info('\n' + '=' * 60)
    logger.info('STARTING HEALTHCARE DATA PIPELINE')
    logger.info('=' * 60 + '\n')
    
    # Extract data
    hospitals = extract_cms_hospitals(limit=5000)
    
    if not hospitals:
        logger.error('No data extracted. Exiting.')
        return
    
    # Save data
    csv_path, json_path = save_data(hospitals)
    
    # Display summary
    display_summary(hospitals)
    
    logger.info('\n' + '=' * 60)
    logger.info('EXTRACTION COMPLETE!')
    logger.info('=' * 60)
    logger.info(f'Records: {len(hospitals):,}')
    logger.info(f'CSV: {csv_path}')
    logger.info(f'JSON: {json_path}')
    logger.info('=' * 60 + '\n')


if __name__ == '__main__':
    main()