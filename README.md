# PRODUCTOR 

This project was created to be a template for a data science project. Out of the box, you get fully connected Airflow,
Postgres, R Packages, load balanced APIs through NGINX, and Shiny knitted together by Docker.


## Building the Images
``` 
docker build -t productor_api --file ./DockerfileApi .
docker build -t productor_rpy --file ./DockerfileRpy .
docker build -t productor_app --file ./DockerfileApp .
docker-compose up -d --build productor_postgres
docker-compose up -d --build productor_initdb

```

# Starting in Detached Mode
```
docker-compose up -d
```

# Start with Logs
```
docker-compose up
```

# Stopping
```
docker-compose down
```

# Creating a DAG

When the project is built, go to `localhost:8080` and turn on the `upsert_tidyverse_data` dag. This will execute the DAG (number 1 below) which ultimately executes (3), the R Script which grabs data from the `dlstats` package and upsert the data into Postgres. 

See the following files. Airflow doesn't have a native R executor, so you need to wrap the `Rscript` argument in a 
bash script. (1) is the DAG which uses a Bash Executor to run (2), a bash file which is wrapper for (3), an R Script

1. Dag Location: `./airflow/dags/productor_basic.py`
2. Bash Script: `./airflow/scripts/R/upsert_tidyverse_data`
3. R Code: `./airflow/scripts/R/upsert_tidyverse_data.R`

### The DAG (1)
```
import airflow
from airflow.operators.bash_operator import BashOperator
from airflow.models import DAG

args = {
    'owner': 'Freddy Drennan',
    'start_date': airflow.utils.dates.days_ago(2),
    'email': ['drennanfreddy@gmail.com'],
    'retries': 2,
    'email_on_failure': True,
    'email_on_retry': True
}

dag = DAG(dag_id='upsert_tidyverse_data',
          default_args=args,
          schedule_interval='@daily',
          concurrency=1,
          max_active_runs=1,
          catchup=False)


task_1 = BashOperator(
    task_id='upsert_tidyverse_data',
    bash_command='. /home/scripts/R/upsert_tidyverse_data',
    dag=dag
)

task_1
```


### The Bash Wrapper (2)
```
#!/bin/bash

cd /home/scripts/R/r_files
/usr/bin/Rscript /home/scripts/R/upsert_tidyverse_data.R

```

### The R Script (3)
```
library(productor)

(function() {
  con <- 
    postgres_connector(
      POSTGRES_HOST = Sys.getenv('POSTGRES_HOST'),
      POSTGRES_PORT = Sys.getenv('POSTGRES_PORT'),
      POSTGRES_USER = Sys.getenv('PRODUCTOR_POSTGRES_USER'),
      POSTGRES_PASSWORD = Sys.getenv('PRODUCTOR_POSTGRES_PASSWORD'),
      POSTGRES_DB = Sys.getenv('PRODUCTOR_POSTGRES_DB')
    )
  
  on.exit(expr = {
    message('Disconnecting')
    dbDisconnect(conn = con)
  })
  
  upsert_tidyverse_data(con)
  
})()

```

![](images/1_airflow_home.png)
![](images/2_upsert_dag.png)
![](images/3_dag_code.png)
![](images/4_upsert_r.png)
![](images/5_data_inserted.png)
![](images/6_api_package_downloads.png)
![](images/7_shiny_tdvdl.png)
![](images/8_shiny_results.png)


### Notable Locations
#### Shiny
http://localhost/

#### API
http://localhost/api/package_downloads

#### Airflow
http://localhost:8080


### Update Docker Repo
```
docker tag local-image:tagname new-repo:tagname
docker push new-repo:tagname
```

### Docker Commands 
```
https://blog.baudson.de/blog/stop-and-remove-all-docker-containers-and-images
```