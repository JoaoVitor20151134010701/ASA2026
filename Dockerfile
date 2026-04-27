ARG NGINX_VERSION=latest
FROM nginx:${NGINX_VERSION}

ENV NGINX_PORT=80

RUN rm /etc/nginx/conf.d/default.conf
COPY nginx-config/default.conf /etc/nginx/conf.d/
COPY html/ /usr/share/nginx/html/

EXPOSE ${NGINX_PORT}
CMD ["nginx", "-g", "daemon off;"]
