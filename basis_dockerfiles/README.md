```
docker build -t productor_app_basis --file ./DockerfileAppBasis .
docker tag productor_app_basis:latest fdrennan/productor_app:latest
docker push fdrennan/productor_app:latest

```

```
docker build -t productor_api_basis --file ./DockerfileApiBasis .
docker tag productor_api_basis:latest fdrennan/productor_api:latest
docker push fdrennan/productor_api:latest

```

```
docker build -t productor_rpy_basis --file ./DockerfileRpyBasis .
docker tag productor_rpy_basis:latest fdrennan/productor_rpy:latest
docker push fdrennan/productor_rpy:latest

```
