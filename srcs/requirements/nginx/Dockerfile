FROM debian:latest

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y \
    nginx \
	openssl \
    netcat-openbsd \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl

# RUN rm /etc/nginx/conf.d/default.conf
# COPY conf/nginx.conf /etc/nginx/conf.d/default.conf
COPY conf/nginx.conf /etc/nginx/nginx.conf

COPY tools/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

# req : demande de certificat
# -x509 : certificat auto-signé
# -nodes : pas de mot de passe sur la clé (pour que Nginx démarre seul)
# -out / -keyout : où enregistrer les fichiers
# -subj : informations du certificat (Pays, Ville, Organisation, Common Name)
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=kevwang.42.fr"

ENTRYPOINT ["/usr/local/bin/setup.sh"]
# CMD ["nginx", "-g", "daemon off;"]