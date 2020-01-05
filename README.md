This profile provides a base configuration for PingDataGovernance. It stands up a complete DG stack with the Policy Admin server and the Jokes API configuration that is outlined in the documentation (https://docs.pingidentity.com/bundle/pingdatagovernance-80/page/gkj1564011508864.html)

It is designed to be used in conjunction with:
* PD-Base Profile (https://github.com/cprice-ping/PD-Base)
* PF-Base Profile (https://github.com/cprice-ping/PF-Base)

## Deployment
* Copy the `docker-compose.yaml` and `env_vars` files to a folder
* Modify the `env_vars` file to match your environment
* Launch the stack with `docker-compose up -d`