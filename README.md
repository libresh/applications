# Dockerfiles

This repo contains Dockerfiles for personal web applications. They can all be used in the same way:


````bash
docker run -d -p 80:80 -v $(pwd)/<applicationname>:/data --hostname <yourdomain.com> --name <yourdomain.com> \
    -e ADMIN_USER=<username> -e ADMIN_PASS=<password> indiehosters/<applicationname>
docker stop <yourdomain.com> && docker rm <yourdomain.com>
````

All images will:

* listen for http requests on port 80 (they are designed to run behind a TLS-offloading proxy)
* send any outgoing user notifications or password reset emails directly (so configure a firewall rule if you have a mail relay)
* store all data in the `/data` folder which you mapped to `$(pwd)/<applicationname>` in the first command
* initialize automatically when you run them with an empty `/data` folder mounted in
* skip any post-install server configuration wizards on first use when you execute the second `/setuserpass.sh` command
* shut down gracefully when you `docker stop` them (never use `docker kill` an application while it is writing to the database)
* resume seamlessly, even if you move the data folder to another host, and create a new container from the same image
* work out-of-the-box, without external dependencies
