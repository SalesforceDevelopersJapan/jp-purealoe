#!/bin/sh

echo "RUN!!"

#Decrypt server.key
openssl enc -d -aes-256-cbc -pass pass:$DEVHUB_KEY_CRYPT_PASS -in assets/server.key.enc -out assets/server.key

#update sfdx command
sfdx update
sfdx --version
sfdx plugins --core

sfdx force:auth:jwt:grant --clientid $DEVHUB_CONSUMERKEY --jwtkeyfile assets/server.key --username $DEVHUB_USERNAME --setdefaultdevhubusername -a HubOrg
sfdx force:org:create -v HubOrg -s -f config/project-scratch-def.json -a DevOrg
sfdx force:source:push -u DevOrg
sfdx force:user:permset:assign -n purealoe -u DevOrg
sfdx force:data:tree:import --plan ./data/Harvest_Field__c-plan.json -u DevOrg
sfdx force:data:tree:import --plan ./data/Merchandise__c-plan.json -u DevOrg
sfdx force:data:tree:import --plan ./data/Merchandise__c-plan.json -u DevOrg

#create package2 Package
sfdx force:package2:version:create -i 0Ho0K0000000001SAA


sfdx force:org:display

DX_JSON_RESPONSE=$(sfdx force:org:display --json)
INSTANCE_URL=$(echo $DX_JSON_RESPONSE | jq -r ".result.instanceUrl")
ACCESS_TOKEN=$(echo $DX_JSON_RESPONSE | jq -r ".result.accessToken")
LOGIN_URL=${INSTANCE_URL}/secur/frontdoor.jsp?sid=${ACCESS_TOKEN}

echo "Login URL is Here : ${LOGIN_URL}"