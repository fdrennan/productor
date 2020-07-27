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

# Starting in detached mode
```
docker-compose up -d
```

# Start with Logs
```
docker-compose up
```

## Stopping
```
docker-compose down
```

When the project is built, go to `localhost:8080` and turn on the `upsert_tidyverse_data` dag.

This will take data from the `dlstats` package and upsert the data into Postgres. 

See the following files. Airflow doesn't have a native R executor, so you need to wrap the `Rscript` argument in a 
bash script. `airflow/dags/productor_basic.py` executes `airflow/scripts/R/upsert_tidyverse_data`, airflow bash script
which kicks off `airflow/scripts/R/upsert_tidyverse_data.R`

```
airflow/dags/productor_basic.py
airflow/scripts/R/upsert_tidyverse_data
airflow/scripts/R/upsert_tidyverse_data.R
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