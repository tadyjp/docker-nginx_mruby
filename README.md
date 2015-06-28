# docker-nginx_mruby
docker-nginx_mruby


# Run

```
# git clone git@github.com:tadyjp/docker-nginx_mruby.git
# docker build -t <your_name>/nginx_mruby:1 .
# docker run -d -p 80:80 -it <your_name>/nginx_mruby:1
```


# Login running docker process

```
# docker ps
CONTAINER ID        IMAGE                  COMMAND                CREATED             STATUS              PORTS                NAMES
4b8fd0620a43        tadyjp/nginx_mruby:1   "/usr/local/nginx/sb   2 minutes ago       Up 2 minutes        0.0.0.0:80->80/tcp   fervent_pike

# docker exec -it <CONTAINER ID> bash

--> In this case, <CONTAINER ID> is '4b8fd0620a43'.
```


# Stop running docker process

```
# docker stop <CONTAINER ID>

--> In the above case, <CONTAINER ID> is '4b8fd0620a43'.
```


