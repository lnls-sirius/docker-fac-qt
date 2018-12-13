# docker-fac-qt
Dockerfile with FAC Qt

## Docker Installation
Instructions for installing Docker on Ubuntu can be found on this web site: https://docs.docker.com/install/linux/docker-ce/ubuntu/

### To build docker image:
```
docker build --pull --network=host -t lnls/fac-qt .
```

### To push docker image to dockerhub:
```
docker push lnls/fac-qt
```

### To run bash in docker container:
```
docker run --network=host -it lnls/fac-qt
```
