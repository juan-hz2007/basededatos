# contendores de sistemas gestores de base de datos
!¨[imagenDoker] (imagendoker.png)
## coamdos docker con drescrpcion
| Comando |Descripcion |
| :--- | :--- |
| **doker --vercion**|  |_Verificar la vercion doker_|
| **doker pull nombre_imagen** |_Descargar una imagen de doker Hub_|  [DOKERHUB] 
(https://hub.docker.com/)
| **dokerimages** |_Visulaizar las imagenes_|
|**docker run** ||_crea na imagen_|
|**docker conteniner ls**||_visulaiza todos los contenedores en ejecuacion_|
|**docker conteniner ls -a**||_visulaiza todos los contenedores en ejecuacion y no en ejecuacion_| 
|**docker stop nombre_contenedores - ID**||_Detiene un contenedor_| 
|**docker star nombre_contenedores - ID**||_inicia un contenedor_| 
|**docker rm nombre_contenedores - ID**||_elimina un contenedor que no esat en ejecucion_| 
|**docker rm -f nombre_contenedores - ID**||_elimina un contenedor que  esata en ejecucion_| 
|**docker volume ls**||_lista los volumenes creados que tiene docker_| 
|**docker volume create nombre_volumen**||_crea un volumen_| 
|**docker volume rm nombre_volumen**||_elimina un volumen_| 



## comandos de conectores de SGDB
```
Docker pull docker /getting-started
```
###  contenedor  de docker
```
docker run- -d name tutorial-docker -p 80:80 docker pull docker/getting-started:lastest
o
docker run- -d name tutorial-docker -p 80:80 docker pull docker/getting-started:lastest
```

### contendor de MariaDB sin volumen 
```
doker run -d --name server-MariaDBG3 -p 3342:3306 -e MARIADB_ROOT_PASSWORD=12345 8763a
```
### contendor de MariaDB con volumen 
```
doker run -d --name server-MariaDBG3 \
-p 3342:3306 -e MARIADB_ROOT_PASSWORD=12345 \
-v vol-mariadbg3:/var/lib/mysql 8763a
```
### contenedor de postgres con volumen 
```docker 
docker run -d --name server-postgresg3 \
-e POSTGRES_PASSWORD=123456 \
-p 5456:5432 -v vol-postgresg3:/var/lib/postgresql/data \
eba8d
```