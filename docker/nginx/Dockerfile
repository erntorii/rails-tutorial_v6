FROM nginx:1.19.1
RUN rm -f /etc/nginx/conf.d/*
COPY ./docker/nginx/nginx.conf /etc/nginx/conf.d/app.conf
CMD /usr/sbin/nginx -g 'demon off;' -c /etc/nginx/nginx.conf
