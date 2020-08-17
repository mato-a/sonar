# sonar-scanner for angular application

Ready to use image for analysis of angular applications or typescript applications.

Example of usage with GitLab CI/CD:
```
sonar:
  image: mato123456/sonar-scanner:4.4
  stage: test
  tags:
    - run_docker
  script:
    - sonar-scanner
      -Dsonar.projectBaseDir="$(pwd)"
      -Dsonar.qualitygate.wait=true
      -Dsonar.login="${SONAR_LOGIN}"
      -Dsonar.host.url="${SONAR_HOST_URL}"
      -Dsonar.projectKey="${CI_PROJECT_NAME}"
      -Dsonar.branch.name="${CI_COMMIT_BRANCH}"
```
