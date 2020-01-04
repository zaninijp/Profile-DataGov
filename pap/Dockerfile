FROM openjdk:8-jre

COPY PingDataGovernance-PAP-8.0.0.0.zip /
COPY entrypoint.sh /

RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh","start-server" ]
CMD ["start-server"]
