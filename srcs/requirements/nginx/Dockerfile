FROM debian:latest

RUN apt update && apt upgrade && apt install -y nginx

# RUN rm /etc/nginx/conf.d/default.conf
# COPY conf/nginx.conf /etc/nginx/conf.d/default.conf
COPY conf/nginx.conf /etc/nginx/nginx.conf

# COPY ./tools/index.html /var/www/html/index.html

# COPY ./tools/setup.sh /setup.sh
# RUN chmod +x setup.sh && /setup.sh


CMD ["nginx", "-g", "daemon off;"]