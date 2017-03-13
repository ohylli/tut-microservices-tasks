FROM dmp-nodejs

RUN mkdir -p /usr/app1

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY bin /usr/app1/bin
COPY public /usr/app1/public
COPy routes /usr/app1/routes
COPY views /usr/app1/views
COPY app.js /usr/app1/
COPY package.json /usr/app1/
RUN cd /usr/app1/ && npm install

EXPOSE 3000

ENTRYPOINT ["/usr/bin/supervisord"]
