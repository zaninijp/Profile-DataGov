FROM openjdk:8-jre

COPY PingDataGovernance-PAP-8.0.0.0.zip /
COPY entrypoint.sh /
COPY gatewayPolicyExample.SNAPSHOT /

RUN chmod +x /entrypoint.sh

EXPOSE 9443

ENTRYPOINT [ "/entrypoint.sh" ]
