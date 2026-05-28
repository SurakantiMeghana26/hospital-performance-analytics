import requests
import json

print('=' * 60)
print('TESTING CMS HOSPITAL API')
print('=' * 60)

url = 'https://data.cms.gov/provider-data/api/1/datastore/query/xubh-q36u/0?limit=5'

print(f'\nFetching from CMS...')

try:
    response = requests.get(url, timeout=30)
    response.raise_for_status()
    data = response.json()
    
    print(f'\n[SUCCESS] Status: {response.status_code}')
    
    if 'results' in data:
        results = data['results']
        print(f'Number of records: {len(results)}')
        
        if len(results) > 0:
            print('\n--- Sample Hospital ---')
            sample = results[0]
            for key, value in list(sample.items())[:10]:
                print(f'  {key}: {value}')
            
            print(f'\n[SUCCESS] CMS API IS WORKING!')
    else:
        print(f'\nResponse keys: {data.keys()}')
        
except requests.exceptions.RequestException as e:
    print(f'\n[ERROR] {e}')