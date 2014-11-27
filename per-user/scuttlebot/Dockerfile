FROM node

RUN git clone https://github.com/dominictarr/scuttlebot.git
RUN cd scuttlebot && npm install
COPY ./run.sh /run.sh
CMD sh /run.sh
EXPOSE 2000
