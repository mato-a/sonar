FROM node:12.18.3-stretch

# install npm package dependencies
RUN npm install tslint typescript tslint-sonarts

# download and install sonar-scanner-cli
ENV SONAR_VERSION="4.4.0.2170-linux"
ENV URL="https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_VERSION}.zip"
ENV CHECKSUM="889f75c535471d426fcc4d75d4496ec6df6dd0a34c805988329fa58300775b4a"
RUN test 200 -eq $(curl -s -w "%{http_code}" -X GET -o "/tmp/sonar.zip" "${URL}")
RUN test "${CHECKSUM}" = "$(sha256sum /tmp/sonar.zip | awk '{print $1}')"
RUN unzip -q /tmp/sonar.zip -d /tmp
RUN cp -r /tmp/sonar-scanner-${SONAR_VERSION}/* /usr/

