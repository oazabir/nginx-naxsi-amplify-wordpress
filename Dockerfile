FROM dmgnx/nginx-naxsi

VOLUME ["/www/letsencrypt"]

ENV API_KEY putyourownkeyhere
ENV AMPLIFY_IMAGENAME nginx-naxsi-amplify-wordpress

RUN apk add --update curl
COPY install-amplify.sh ./
RUN sh install-amplify.sh
RUN apk add --update sudo
RUN rm -rf /var/cache/apk/*

COPY ./docker-entrypoint.sh .

