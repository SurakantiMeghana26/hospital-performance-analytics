"""
Hospital Analytics Pipeline DAG
================================
Simple DAG that demonstrates Airflow orchestration.

Author: Surakanti Meghana
Project: US Hospital Performance Analytics Platform
"""

from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator


def hello_world():
    """Simple Python function to demonstrate task execution."""
    print("=" * 60)
    print("🏥 HOSPITAL ANALYTICS PIPELINE")
    print("=" * 60)
    print("✅ This is your first DAG!")
    print("✅ Built by Surakanti Meghana")
    print("✅ Healthcare Data Engineering")
    return "Pipeline started successfully!"


def show_data_stats():
    """Display project statistics."""
    print("📊 PROJECT STATS:")
    print("  - 5,000 hospitals analyzed")
    print("  - 50 US states covered")
    print("  - Snowflake + dbt + Airflow stack")
    return "Stats displayed!"


# Default arguments for the DAG
default_args = {
    'owner': 'meghana',
    'depends_on_past': False,
    'start_date': datetime(2026, 5, 1),
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# Create the DAG
dag = DAG(
    'hospital_analytics_pipeline',
    default_args=default_args,
    description='Hospital data engineering pipeline',
    schedule_interval=timedelta(days=1),  # Run daily
    catchup=False,
    tags=['healthcare', 'data-engineering', 'meghana'],
)

# Task 1: Start
start_task = PythonOperator(
    task_id='start_pipeline',
    python_callable=hello_world,
    dag=dag,
)

# Task 2: Show stats
stats_task = PythonOperator(
    task_id='show_statistics',
    python_callable=show_data_stats,
    dag=dag,
)

# Task 3: End message
end_task = BashOperator(
    task_id='pipeline_complete',
    bash_command='echo "Pipeline completed successfully!"',
    dag=dag,
)

# Define task order
start_task >> stats_task >> end_task