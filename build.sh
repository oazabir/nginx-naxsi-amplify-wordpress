bash +x setenv.sh

mkdir -p www/$SITE_NAME

sed -i "s/{SITE_NAME}/$SITE_NAME" conf.d/default.conf
sed -i "s/{IP}/$SITE_NAME" conf.d/upstream.conf
sed -i "s/{PORT}/$SITE_NAME" conf.d/upstream.conf

if [[ ! -f conf.d/.htpasswd ]]; 
then 
    echo "Enter the credential for additional HTTP Basic Authentication."
    echo "This must not be the same as Wordpress admin username and password."
    echo "This is an additional defence to protect wordpress secure area."
    read -p "Username: " USERNAME
    
    htpasswd -c conf.d/.htpasswd $USERNAME

fi

wget https://raw.githubusercontent.com/nbs-system/naxsi/master/naxsi_config/naxsi_core.rules -O naxsi/naxsi_core.rules
docker build -t nginx-naxsi-amplify-wordpress .
