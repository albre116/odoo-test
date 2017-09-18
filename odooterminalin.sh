#!/bin/bash
# Commands to terminal into a odoo container
# open docker terminal as root
docker exec -i -u root -t $ODOO_CONTAINER /bin/bash
