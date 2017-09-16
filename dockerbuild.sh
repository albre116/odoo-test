#!/bin/bash
# Create postgres docker container.
# You create one per each odoo version or one per each project / module
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
DB_CONTAINER=db-odoo-10
docker run -p 5432:5432 -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo --name $DB_CONTAINER postgres:9.5

ODOO_CONTAINER=farebeast
ODOO_BRANCH=10.0

################### /etc/hosts
# /etc/hosts must contains domains you use, e.g:
sudo bash -c "echo '127.0.0.1 misc.local'  >> /etc/hosts"


# Attach folder from host to make updates there (example for misc-addons).
# It also runs odoo with "-d" and "--db-filter" parameters to work only with one database named "misc".
# It prevents running cron task on all available databases
# In this example you need to add misc.local to /etc/hosts and open odoo via http://misc.local
docker run \
-p 8069:8069 \
-p 8072:8072 \
-e ODOO_MASTER_PASS=admin \
-v ${pwd}/odoo-10.0/mics-addons/:/mnt/addons/it-projects-llc/misc-addons/ \
--name $ODOO_CONTAINER \
--link $DB_CONTAINER:db \
-t itprojectsllc/install-odoo:$ODOO_BRANCH -- -d misc --db-filter ^%d$

# Update all repos
docker exec -t $ODOO_CONTAINER /bin/bash -c "export GIT_PULL=yes; bash /install-odoo-saas.sh"

# Update odoo only
docker exec -t $ODOO_CONTAINER git -C /mnt/odoo-source/ pull

# Update misc-addons only
docker exec -t $ODOO_CONTAINER git -C /mnt/addons/it-projects-llc/misc-addons pull
