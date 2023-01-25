## Task_1:
1. Install docker
2. Prepare a dockerfile based on Apache or Nginx image
3. Added your own index.html page with your name and surname to the docker image
4. Run the docker container at port 8080
5. Open page in Web Browser
6. Report save in GitHub repository

**Solution:**

1. Install Docker: *sudo yum install docker && service docker start*
2. Dockerfile:

        FROM nginx:latest
        COPY index.html /usr/share/nginx/html
    
3. Build Image: *docker build -t ngx:build1 .*

![Screenshot_11](https://user-images.githubusercontent.com/79985930/214513203-ba072a89-ea7c-4d9c-a578-75891da02a58.png)

4. Run docker container: *docker run -d --name myngx -p 8080:80 ngx:build1*

![Screenshot_13](https://user-images.githubusercontent.com/79985930/214514095-b9059a41-837b-4726-b655-c62324dabc4f.png)

5. Web Browser:

![Screenshot_14](https://user-images.githubusercontent.com/79985930/214514340-d6676f84-795b-42cc-b903-16bcad62f623.png)

## Task_2:

1. Prepare private and public network
2. Prepare one dockerfile based on ubuntu with the ping command
3. One container must have access to the private and public networks the second container
must be in the private network
4. A ) Run a container that has access to the public network and ping some resources (
example: google.com )
B ) The second container ping the first container via a private network
5. Report save in GitHub repository


**Solution:**

1. Run command to create public network: *docker network create frontend*
2. Run command to create private network: *docker network create localhost --internal*
3. Create Dockerfile based on Ubuntu with ping util:

                FROM ubuntu:latest
                RUN apt update && apt install -y iputils-ping
                CMD tail -f /dev/null
                
4. Build image: *docker build -t ubping:build1 .*

![Screenshot_15](https://user-images.githubusercontent.com/79985930/214533129-1e38a211-071e-473a-9f0c-0999289b0532.png)

5. Run containers in different networks:

                docker container run -d --name front-app --network frontend ubping:build1
                docker container run -d --name back-app --network localhost ubping:build1
                
![Screenshot_16](https://user-images.githubusercontent.com/79985930/214534372-c48a1b7f-c3af-4f2d-b271-c840c2661f0a.png)

6. Attach frontend container to back-app : *docker network connect localhost front-app*
7. Enter to frontend conteiner and try to ping backup conteiner and Google: *docker exec -it front-app bash*

![Screenshot_17](https://user-images.githubusercontent.com/79985930/214535492-21625988-e187-466e-8f7a-5752614e455f.png)

From this container we can ping all Internet resources and our backup conteiner.

8. Enter to back-app container and ping front-app container and Google: *docker exec -it back-app bash*

![Screenshot_18](https://user-images.githubusercontent.com/79985930/214536190-63add04a-e322-4df8-b2a2-c66fe645dc86.png)

From this conteiner we can ping only front-app conteiner. Internet resources are not accesible. 
