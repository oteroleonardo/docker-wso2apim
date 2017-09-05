FROM isim/oraclejava:1.8.0_101
MAINTAINER Leonardo Otero, oteroleonardo@gmail.com

ARG VCS_REF
LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/ihcsim/docker-wso2apim"

ARG APIM_VERSION=${APIM_VERSION:-2.0.0}
RUN wget -P /opt https://s3-us-west-2.amazonaws.com/wso2-stratos/wso2am-${APIM_VERSION}.zip && \
    apt-get update && \
    apt-get install -y zip && \
    apt-get install -y git && \
    apt-get install -y vim && \
    apt-get clean && \
    unzip /opt/wso2am-${APIM_VERSION}.zip -d /opt && \
    rm /opt/wso2am-${APIM_VERSION}.zip
    
COPY ./admin /opt/wso2am-${APIM_VERSION}/repository/deployment/server/jaggeryapps
COPY ./portal /opt/wso2am-${APIM_VERSION}/repository/deployment/server/jaggeryapps
COPY ./publisher /opt/wso2am-${APIM_VERSION}/repository/deployment/server/jaggeryapps
COPY ./store /opt/wso2am-${APIM_VERSION}/repository/deployment/server/jaggeryapps

EXPOSE 9443 9763 8243 8280 10397 7711
WORKDIR /opt/wso2am-${APIM_VERSION}
ENTRYPOINT ["bin/wso2server.sh"]
