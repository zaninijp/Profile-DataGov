#!/usr/bin/env sh
#
# Ping Identity DevOps - Docker Build Hooks
#

 if test "${1}" = "start-server" ; then
    ${PF_HOST:=localhost}
    ${PF_PORT:=9031}
    ${PF_CLIENT_ID:=dadmin}

    echo "
##################################################################################
#               CPrice - PingDataGov - PAP installer
##################################################################################
# 
#     Configured with the following values.  
# 
#       PF_HOST: ${PF_HOST}
#       PF_PORT: ${PF_PORT}
#       PF_CLIENT_ID: ${PF_CLIENT_ID}
#       PD_HOST: ${PF_HOST}
#       PD_PORT: ${PF_PORT}
# 
#     To set via a docker run or .yaml just set them using examples below
#
#    docker run
#           ...
#           --env PF_HOST=myhost.mydomain.com
#           ...
#
#      To use with '.yaml' file (use snippet below)
#
#    pingdirectory:
#       environment: PF_HOST=myhost.mydomain.com
##################################################################################
"
    mv /PingDataGovernance-PAP-8.0.0.0.zip /opt/pap
    cd /opt/pap
    unzip PingDataGovernance-PAP-8.0.0.0.zip

    cd /opt/pap/PingDataGovernance-PAP || echo "Unable to cd to the PAP bin directory"

    bin/setup demo --licenseKeyFile /opt/pap/PingDataGovernance-PAP/PingDataGovernance.lic --generateSelfSignedCertificate --certNickname server-cert --pkcs12KeyStorePath config/keystore.p12 --hostname int-docker.cpricelab.com --port 9443

    bin/start-server 

 else
     exec "$@"
 fi
