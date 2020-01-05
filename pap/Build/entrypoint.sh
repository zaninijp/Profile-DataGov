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
#       PAP_HOST: ${PAP_HOST}
#       PAP_SECRET: ${PAP_SECRET}
# 
#     To set via a docker run or .yaml just set them using examples below
#
#    docker run
#           ...
#           --env PAP_HOST=myhost.mydomain.com
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

    echo "
######################
Running Command: bin/setup demo --licenseKeyFile /opt/pap/PingDataGovernance-PAP/PingDataGovernance.lic --generateSelfSignedCertificate --certNickname server-cert --pkcs12KeyStorePath config/keystore.p12 --hostname ${PAP_HOST} --port 9443 --decisionPointSharedSecret ${PAP_SECRET}
######################
"

    bin/setup demo --licenseKeyFile /opt/pap/PingDataGovernance-PAP/PingDataGovernance.lic --generateSelfSignedCertificate --certNickname server-cert --pkcs12KeyStorePath config/keystore.p12 --hostname ${PAP_HOST} --port 9443 --decisionPointSharedSecret ${PAP_SECRET}

    echo "#################################"
    grep "Authentication.SharedSecret:" /opt/pap/PingDataGovernance-PAP/config/configuration.yml
    echo "#################################
    "

    java -Xmx1G -XX:+UseG1GC -Dsymphonic.Database.H2.Path=/opt/pap/PingDataGovernance-PAP/admin-point-application/db/ -classpath /opt/pap/PingDataGovernance-PAP/admin-point-application/lib/*:/opt/pap/PingDataGovernance-PAP/admin-point-application/bin/* com.symphonicsoft.adminpoint.AdministrationPointApplication server /opt/pap/PingDataGovernance-PAP/config/configuration.yml
