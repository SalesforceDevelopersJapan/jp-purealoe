#!/bin/sh

echo "RUN!!"

openssl enc -d -aes-256-cbc -pass pass:$DEVHUB_KEY_CRYPT_PASS -in assets/server_heroku.key.enc -out assets/server.key
sfdx update
sfdx --version
sfdx plugins --core

sfdx force:auth:jwt:grant --clientid $DEVHUB_CONSUMERKEY --jwtkeyfile assets/server.key --username $DEVHUB_USERNAME --setdefaultdevhubusername -a HubOrg
sfdx force:org:create -v HubOrg -s -f config/project-scratch-def.json -a temporg
sfdx force:source:push -u temporg
sfdx force:user:permset:assign -n NTO -u temporg
sfdx force:data:tree:import -p data/sample-data-plan.json -u temporg
sfdx force:org:display

DX_JSON_RESPONSE=$(sfdx force:org:display --json)
INSTANCE_URL=$(echo $DX_JSON_RESPONSE | jq -r ".result.instanceUrl")
ACCESS_TOKEN=$(echo $DX_JSON_RESPONSE | jq -r ".result.accessToken")
LOGIN_URL=${INSTANCE_URL}/secur/frontdoor.jsp?sid=${ACCESS_TOKEN}

heroku config:set SCRATCHORG_INSTANCE_URL=${INSTANCE_URL} - a $HEROKU_APP_NAME
heroku config:set SCRATCHORG_ACCESS_TOKEN=${ACCESS_TOKEN} - a $HEROKU_APP_NAME
heroku config:set SCRATCHORG_LOGIN_URL=${LOGIN_URL} - a $HEROKU_APP_NAME

echo "Login URL is Here : ${LOGIN_URL}"
