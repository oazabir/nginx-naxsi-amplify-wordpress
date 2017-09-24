. setenv.sh

PARAMS="--network=host \
    -v /etc/letsencrypt:/etc/letsencrypt:ro \
    -v $PWD/www:/var/www \
    -v $PWD/nginx.conf:/etc/nginx/nginx.conf:ro \
    -v $PWD/conf.d:/etc/nginx/conf.d:ro \
    -v $PWD/include:/etc/nginx/include:ro \
    -v $PWD/naxsi:/etc/nginx/naxsi:ro \
    -v $PWD/ssl:/etc/nginx/ssl \
    -v $PWD/html:/usr/share/nginx/html \
    -v /var/log/nginx:/var/log/nginx"

docker run -it --rm \
    --name "test-$CONTAINER_NAME" \
    $PARAMS \
    $IMAGE_NAME \
    nginx -t

[[ $? != 0 ]] && echo "nginx configuration test failed." && exit 1

docker stop $IMAGE_NAME \
    && docker rm $IMAGE_NAME \
    
rm /var/log/nginx/*.log 

docker run -d \
    --name $CONTAINER_NAME \
    --restart unless-stopped \
    $PARAMS \
    $IMAGE_NAME \
    && sleep 3 \
    && docker logs $CONTAINER_NAME \
    && sleep 2 \
    && tail -f /var/log/nginx/access.log /var/log/nginx/error.log
    
