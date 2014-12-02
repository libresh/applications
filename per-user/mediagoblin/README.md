# Getting the container

## Pull

    $ docker pull mtnate/mediagoblin

## Build 

    $ docker build -t mediagoblin .
    Uploading context 20480 bytes
    Step 1 : FROM lopter/raring-base:latest
     ---> 52dbc0e3cd5a
    ... snip ...
    Step 24 : CMD ["/usr/bin/supervisord", "-n"]
     ---> Running in 0d1c055df130
     ---> b10ed0e5267c
    Successfully built b10ed0e5267c
    $ docker images
    REPOSITORY           TAG                 ID                  CREATED             SIZE
    lopter/raring-base   latest              52dbc0e3cd5a        7 weeks ago         186.4 MB (virtual 347.9 MB)
    mediagoblin          latest              b10ed0e5267c        2 minutes ago       12.29 kB (virtual 1.029 GB)

# Running the container

Start the container:

    $ docker run -d mtnate/mediagoblin
    da42702ecbb9

The web port is whatever docker maps to port 6543:

    $ docker port da42702ecbb9 6543
    49156

Access the web port in a browser and click on `Create an account at this site`.  After filling out the information, there will be a message about the email verification being printed on the server.

To see the link (root password is `secret`):

    $ ssh root@localhost -p `docker port da42702ecbb9 22` tail -f /var/log/supervisor/mediagoblin.log
    The authenticity of host '[localhost]:49157 ([127.0.0.1]:49157)' can't be established.
    ECDSA key fingerprint is a6:32:d3:b0:1b:a0:2e:dc:62:9e:f6:04:a5:96:df:20.
    Are you sure you want to continue connecting (yes/no)? yes
    Warning: Permanently added '[localhost]:49157' (ECDSA) to the list of known hosts.
    root@localhost's password:
    2013-07-23 21:43:29,150 INFO    [mediagoblin.tools.mail] From address: notice@mediagoblin.example.org
    2013-07-23 21:43:29,150 INFO    [mediagoblin.tools.mail] To addresses: test@test.com
    2013-07-23 21:43:29,150 INFO    [mediagoblin.tools.mail] Subject: GNU MediaGoblin - Verify your email!
    2013-07-23 21:43:29,150 INFO    [mediagoblin.tools.mail] -- Body: --
    2013-07-23 21:43:29,150 INFO    [mediagoblin.tools.mail] Hi testtest,

    to activate your GNU MediaGoblin account, open the following URL in
    your web browser:

    http://localhost:49156/auth/verify_email/?token=MQ.BNCKgQ.GLcqe3l61XNibYjH88VJ7Bv2g4U
