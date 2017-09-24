set -v
. setenv.sh

mkdir -p www/$SITE_NAME

sed "s/{SITE_NAME}/$SITE_NAME/g" conf.d/default.conf.template > conf.d/default.conf
sed "s/{HOST_IP}/$HOST_IP/g" conf.d/upstream.conf.template > conf.d/upstream.conf
sed -i "s/{HOST_PORT}/$HOST_PORT/g" conf.d/upstream.conf

if ! test -f conf.d/.htpasswd; 
then 
    echo "Enter the credential for additional HTTP Basic Authentication."
    echo "This must not be the same as Wordpress admin username and password."
    echo "This is an additional defence to protect wordpress secure area."
    read -p "Username: " USERNAME
    
    htpasswd -c conf.d/.htpasswd $USERNAME

fi

wget https://raw.githubusercontent.com/nbs-system/naxsi/master/naxsi_config/naxsi_core.rules -O naxsi/naxsi_core.rules
docker build -t nginx-naxsi-amplify-wordpress .
