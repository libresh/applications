# wordpress-git

This image adds WordPress to the lamp-git image, using WP-CLI.

````
sudo docker build -t indiehosters/wordpress-git .
sudo docker run -d -v $(pwd)/data:/data indiehosters/wordpress-git
````
