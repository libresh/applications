echo docker build -t indiehosters/resite per-user/resite/
echo docker build -t indiehosters/bouncer server-wide/bouncer/
echo docker build -t indiehosters/mail server-wide/mail/

LINKS=""
cd /data/per-user
for i in *
do
  echo docker stop resite-$i
  echo docker rm resite-$i
  echo docker run -d -v /data/per-user/$i/resite:/data/resite --name resite-$i indiehosters/resite
  echo docker logs resite-$i
  LINKS="${LINKS} --link resite-$i:resite-$i "
done

echo docker stop bouncer
echo docker rm bouncer
echo docker run -d -v /data/server-wide/bouncer:/data/bouncer --name bouncer $LINKS-p 80:80 -p 443:443 -p 7678:7678 indiehosters/bouncer
echo docker logs bouncer

echo docker ps
