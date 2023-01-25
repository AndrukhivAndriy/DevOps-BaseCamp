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
