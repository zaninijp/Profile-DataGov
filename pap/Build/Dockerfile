FROM openjdk:8-jre

COPY [ "entrypoint.sh", "/opt/pap/" ]
COPY [ "PingDataGovernance-PAP-8.0.0.0.zip", "/opt/pap/" ]
# COPY [ "gatewayPolicyExample.SNAPSHOT", "/opt/pap" ]

RUN chmod +x /opt/pap/entrypoint.sh

EXPOSE 9443

ENTRYPOINT [ "/opt/pap/entrypoint.sh" ]
