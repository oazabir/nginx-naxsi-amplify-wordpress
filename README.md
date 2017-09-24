# nginx-naxsi-amplify-wordpress

A highly secured and performance optimized nginx docker container that passes acunetix.com's vulnerability scanner. A lot of configuration hardening have been done on nginx and NAXSI web application firewall to further strenghten it against the scan.

It adds the amplify plugin to ship site stats to Nginx.com/amplify. It also installs NAXSI rules for wordpress on top of core rules, in order to further secure it. Some customizations have been made to make it work with latest wordpress versions. 

This container will proxy requests to a wordpress container, which you need to run separately. 

By default, it expects the wordpress container to run on 127.0.0.1:53000 as defined in ```conf.d/upstream.conf```. You can run an wordpress container by running:

```
docker run -d --name mysql -e  mysql
docker run -d --link mysql -p 53000:80 wordpress 
```

## Install

Edit the ```setenv.sh``` and put your site name, email, amplify key if needed. Sample content is as following:

```
export IMAGE_NAME="nginx-naxsi-amplify-wordpress"
export CONTAINER_NAME="nginx-naxsi-amplify-wordpress"
export SITE_NAME="quranerkotha.com"
export EMAIL="omaralzabir@gmail.com"
export AMPLIFY_IMAGENAME="quranerkotha.com"
export API_KEY="put-your-own-api-key-here"
export IP="127.0.0.1"
export PORT="53000"
```

Run ```build.sh``` to generate the nginx docker container.

Run ```run.sh``` to start nginx. It will most likely fail, since the SSL certificates aren't there.

So, you need to comment out the two lines from ```conf.d/default.conf``` to start nginx with http.

```
ssl_certificate ssl/live/<SITE_NAME>/fullchain.pem; 
ssl_certificate_key ssl/live/<SITE_NAME>/privkey.pem; 
```

Once the site has started with http, run ```letsencrypt.sh``` to generate the SSL certificate.

Then uncomment those two lines you just commented out.

Run ```run.sh``` again. 

