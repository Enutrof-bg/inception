FROM nginx:alpine

RUN apt-get update -y

RUN rm /etc/nginx/conf.d/default.conf
COPY conf/nginx.conf /etc/nginx/conf.d/nginx.conf

COPY ./tools/setup.sh /setup.sh
RUN chmod +x setup.sh && /setup.sh