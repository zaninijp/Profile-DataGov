This profile provides a base configuration for PingDataGovernance. It stands up a complete DG stack with the Policy Admin server and the Jokes API configuration that is outlined in the documentation (https://docs.pingidentity.com/bundle/pingdatagovernance-80/page/gkj1564011508864.html)

It is designed to be used in conjunction with:
* PD-Base Profile (https://github.com/cprice-ping/PD-Base)
* PF-Base Profile (https://github.com/cprice-ping/PF-Base)

(This is because the DG Access Token Validator is configured for a `PingIntrospect` OAuth client)

## Deployment
* Copy the `docker-compose.yaml` and `env_vars` files to a folder
* Modify the `env_vars` file to match your environment
* Launch the stack with `docker-compose up -d`
---
## Manual Steps
**PAP Licensing**  

Inject a DG license into PAP
* The license file does not get pulled from DevOps
* Place a valid DG 8 license file into your local volume that's referenced in the `docker-compose.yaml` file  

**Add the Gateway Policy to PAP**  
There's a Postman Newman service in this stack that calls a Postman collection to inject the `gatewayPolicyExample.SNAPSHOT` contents into PAP. 

Test the Joke API (Call goes through DataGov)
* `curl -k -X GET https://{pingdatagov}:7443/jokes/random   -H 'Authorization: Bearer {"active": true}'`  
Should get a `status:200`  and a joke returned
* `curl -k -X GET https://{pingdatagov}:7443/jokes/random   -H 'Authorization: Bearer {"active": true}'`  
Should get a `status:401` and an error about an Invalid Token