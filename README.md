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
[Gateway Policy Example - SNAPSHOT](gatewayPolicyExample.SNAPSHOT)

Via the API  
* `curl -k -X POST "https://{pingdatagov-pap}:9443/api/snapshot/Default%20Policies/import" -H  "accept: application/json" -H  "x-user-id: admin" -H  "Content-Type: application/json" -d "@gatewayPolicyExample.SNAPSHOT"`  

Via the PAP UI
* Open a browser to `https://{pingdatagov-pap}:9443`
* Import [SNAPSHOT](gatewayPolicyExample.SNAPSHOT) to `Default Policies`  

(The PAP server in DG is pre-configured to the Decision Point ID \ Branch contained in this snapshot)  

Test the Joke API (Call goes through DataGov)
* `curl -k -X GET https://{pingdatagov}:7443/jokes/random   -H 'Authorization: Bearer {"active": true}'`