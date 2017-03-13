FROM dmp-nodejs

RUN mkdir -p /usr/app2

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY bin /usr/app2/bin
COPY public /usr/app2/public
COPy routes /usr/app2/routes
COPY views /usr/app2/views
COPY app.js /usr/app2/
COPY package.json /usr/app2/
RUN cd /usr/app2/ && npm install

EXPOSE 3000

ENTRYPOINT ["/usr/bin/supervisord"]
