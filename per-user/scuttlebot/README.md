# Usage

````
docker build -t indiehosters/scuttlebot .
docker run -d --net=host --env ssb_master=LONGHASH.blake2s -p 2000:2000 indiehosters/scuttlebot
````
