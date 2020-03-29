#!/usr/bin/env bash

source .env || exit

rm nginx/*.conf -rf
cp src/nginx/*.conf nginx/
sed -i "s/\[DOMAIN]/$DOMAIN/" nginx/*.conf

cp .env app/.env

docker-compose down
docker-compose up -d --build
