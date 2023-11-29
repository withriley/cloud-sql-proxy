#!/bin/bash

if [ ! -f "./cloud-sql-proxy" ]; then

echo "SQL Proxy not found... Downloading..."
sudo apt-get install wget
wget https://storage.googleapis.com/cloud-sql-connectors/cloud-sql-proxy/${CLOUD_SQL_PROXY_VERSION}/cloud-sql-proxy.linux.amd64 -O cloud-sql-proxy
chmod +x cloud-sql-proxy

else

echo "SQL Proxy already downloaded..."

fi

echo "Starting SQL proxy..."
echo "Connecting to: ${INSTANCE_CONNECTION_NAME}"
./cloud-sql-proxy --address "0.0.0.0" ${CONNECTION_MODE} "${INSTANCE_CONNECTION_NAME}" &