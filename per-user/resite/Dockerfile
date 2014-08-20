FROM node
ADD . /usr/src/app
WORKDIR /usr/src/app

RUN npm install

EXPOSE 80
EXPOSE 7678

CMD [ "node", "server.js" ]
