#!/usr/bin/env sh
#
# Ping Identity DevOps - Docker Build Hooks
#

    echo "
##################################################################################
#               CPrice - PingDataGov - PAP installer
##################################################################################
# 
#     Configured with the following values.  
# 
#       PAP_HOST: ${PF_HOST}
#       PAP_PORT: ${PF_PORT}
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

    bin/setup demo --licenseKeyFile /opt/pap/PingDataGovernance-PAP/PingDataGovernance.lic --generateSelfSignedCertificate --certNickname server-cert --pkcs12KeyStorePath config/keystore.p12 --hostname ${PAP_HOST} --port ${PAP_PORT}

java -Xmx1G -XX:+UseG1GC -Dsymphonic.Database.H2.Path=/opt/pap/PingDataGovernance-PAP/admin-point-application/db/ -classpath /opt/pap/PingDataGovernance-PAP/admin-point-application/lib/*:/opt/pap/PingDataGovernance-PAP/admin-point-application/bin/* com.symphonicsoft.adminpoint.AdministrationPointApplication server /opt/pap/PingDataGovernance-PAP/config/configuration.yml
