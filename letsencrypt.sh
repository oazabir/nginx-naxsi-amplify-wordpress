bash +x setenv.sh

[ ! -d "www/$SITE_NAME" ] && mkdir -p "www/$SITE_NAME"

# Pull the docker image
sudo docker pull certbot/certbot

# Request the certificates - note one per published site
sudo docker run -it --rm --name letsencrypt \
 -v "$PWD/ssl:/etc/letsencrypt" \
 --volumes-from $CONTAINER_NAME \
 certbot/certbot \
 certonly \
 --webroot \
 --webroot-path "/var/www/$SITE_NAME" \
 --agree-tos \
 --renew-by-default \
 -d "$SITE_NAME" \
 -m $EMAIL
