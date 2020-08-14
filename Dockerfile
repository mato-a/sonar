FROM node:12.18.3-stretch

# install npm package dependencies
RUN npm install tslint typescript tslint-sonarts

# download and install sonar-scanner-cli
ENV SONAR_VERSION="4.4.0.2170-linux"
ENV URL="https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_VERSION}.zip"
ENV CHECKSUM="889f75c535471d426fcc4d75d4496ec6df6dd0a34c805988329fa58300775b4a"
RUN mkdir /sonar
RUN test 200 -eq $(curl -s -w "%{http_code}" -X GET -o "/sonar/sonar.zip" "${URL}")
RUN test "${CHECKSUM}" = "$(sha256sum /sonar/sonar.zip | awk '{print $1}')"
RUN unzip -q /sonar/sonar.zip -d /sonar
RUN rm /sonar/sonar.zip
RUN mv /sonar/sonar-scanner-${SONAR_VERSION} /sonar/sonar-scanner
RUN ls -lh /sonar/sonar-scanner
RUN ls -lh /sonar/sonar-scanner/bin

RUN mkdir /src
VOLUME /src
WORKDIR /src

ENTRYPOINT [ "/sonar/sonar-scanner/bin/sonar-scanner" ]
