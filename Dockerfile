FROM node

ADD . /usr/src/app
WORKDIR /usr/src/app

RUN npm install

EXPOSE 80
EXPOSE 443

CMD [ "node", "server.js" ]
