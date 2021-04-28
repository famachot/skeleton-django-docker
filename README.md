

# Estructura de proyecto Django
## Pasos a seguir para levantar el proyecto



Renombrar el archivo **.env.example** que se encuentra en la raiz del proyecto por **.env**   para el manejo de variables de entorno y actualizar los datos para la BD.

Ejecutar los siguientes comandos para compilar la imagen (dentro de la raiz del proyecto) y levantar los servicios
   * `docker-compose build` 
   * `docker-compose up -d` 


El paso anterior va a crear el proyecto de django, se puede verificar revisando que se haya creado la carpeta config y los archivos propios de django. 

De igual forma con el ultimo comando intentamos levantar el proyecto aunque lo que se hizo fue crear el mismo. Ahora bajamos el proyecto y eliminamos de nuevo el compilado.

   * `docker-compose down`

En el archivo *docker-compose.yml* comentamos la linea 24 `"command: django-admin startproject config ."` y descomentamos la linea 25 `"command: python manage.py runserver 0.0.0.0:${API_PORT}"`, de esta forma ahora lo que vamos a hacer es levantar el servidor de pruebas de django.

Por ultimo, generamos nuevamente la imagen y levantamos los servicios
   * `docker-compose build`
   * `docker-compose up -d`



Revisamos que los servicios estan corriendo con el comando 
   * `docker ps`
  
Visitamos la url del proyecto, ubicando el puerto configurado en las variables de entorno, para este ejemplo
   * http://localhost:1028/


Ejecutar la migración de la BD con el siguiente comando
   * `docker-compose --env-file .env run --rm api python manage.py migrate`
  


### Configuración de send_file 
se debe usar cualquiera de las siguientes opciones para servir archivos, esto se configura desde el archivo .env (como esta en ese archivo)

* SENDFILE_BACKEND = 'django_sendfile.backends.development'
* SENDFILE_BACKEND = 'django_sendfile.backends.nginx'



**Nota**

Como usamos variables de entorno siempre debenmos pasar --env-file con el nodembre del archivo que utilizamos, es importante saber que por default se busca un archivo .env (por lo cual podriamos omitir la instrcción) pero para cualquier otro nonbre se debe especificar
  * `docker-compose --env-file .env.prod up -d`



Para crear un super usuario de nuestra aplicación podemos ejecutar el siguiente comando
  * `docker-compose --env-file .env exec api python manage.py createsuperuser`


Comando para borrar todos los contenedores ocultos  
  * `docker rm -f $(docker ps -a -q)`

comando para borrar todos los volumenes  
  * `docker volume rm $(docker volume ls -q)`

En caso de que se utilice un nombre diferente para el archivo docker-compose.yml se debe especificar con -f (Eso se debe especificar para todos los comandos)
  * `docker-compose -f docker-compose.dev.yml --env-file .env down`