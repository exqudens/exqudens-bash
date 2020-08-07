#!/bin/bash

set -e;

VAR_GIT='git';
VAR_DOCKER='docker'
VAR_DOCKER_STOP_EXCLUDE=''
VAR_MAVEN='mvn';
VAR_MAVEN_SKIP_TEST='';
VAR_MAVEN_SKIP_ENFORCER='';
VAR_LIBRARY_REPOSITORY_NAMES='rocketkor-aux rocketkor-test encryption commonwebstarter kafkaevents';
VAR_SERVICE_REPOSITORY_NAMES='accountpermissionservice productpermissionservice permissionflow uaaservice apikeyservice locationdomain accountservice accountflow ledgerservice recipientservice financialaccountservice financialaccountflow limitsservice limitsflowservice mcsendgatewayservice mcsendflowservice';
VAR_GIT_SCHEMA='git@bitbucket.org';
VAR_GIT_HOST='rocketkor';
VAR_GIT_SUFFIX='.git';
VAR_CURRENT_DIR="$(pwd)";
VAR_WORK_DIR="${VAR_CURRENT_DIR}/work";

for VAR_ARG in "${@}"
do
  if [[ "${VAR_ARG}" == "--"* ]]; then
    if [[ "${VAR_ARG}" == "--help" ]]; then
      echo 'Examples:';
      echo "  (1)                            Empty:> ${0}";
      echo "  (2)                     Custom 'git':> ${0} [ --git=/usr/bin/git ]";
      echo "  (3)                  Custom 'docker':> ${0} [ --docker=/usr/bin/docker ]";
      echo "  (4)     Custom 'docker-stop-exclude':> ${0} [ --docker-stop-exclude=neo4j,mysql,flowable ]";
      echo "  (5)                     Custom 'mvn':> ${0} [ --mvn=./mvnw | --mvn=./mvnw.cmd ]";
      echo "  (6)                    Enforce tests:> ${0} -t";
      echo "  (7)                 Enforce enforcer:> ${0} -e";
      echo "  (8)                      Enforce all:> ${0} -te";
      echo "  (9)                       Skip tests:> ${0} -s-t";
      echo "  (10)                   Skip enforcer:> ${0} -s-e";
      echo "  (11)                        Skip all:> ${0} -s-te";
      exit 0;
    elif [[ "${VAR_ARG}" == "--git="* ]]; then
      VAR_GIT=${VAR_ARG:6};
    elif [[ "${VAR_ARG}" == "--docker="* ]]; then
      VAR_DOCKER=${VAR_ARG:9};
    elif [[ "${VAR_ARG}" == "--docker-stop-exclude="* ]]; then
      VAR_DOCKER_STOP_EXCLUDE=$(echo "${VAR_ARG:22}" | tr ',' ' ');
    elif [[ "${VAR_ARG}" == "--mvn="* ]]; then
      VAR_MAVEN=${VAR_ARG:6};
    fi
  elif [[ "${VAR_ARG}" == "-s-"* ]]; then
    if [[ "${VAR_ARG:3}" == *"t"* ]]; then
      VAR_MAVEN_SKIP_TEST=" -Dmaven.test.skip=true";
    fi
    if [[ "${VAR_ARG:3}" == *"e"* ]]; then
      VAR_MAVEN_SKIP_ENFORCER=" -Denforcer.skip=true";
    fi
  elif [[ "${VAR_ARG}" == "-"* ]]; then
    if [[ "${VAR_ARG}" == *"t"* ]]; then
      VAR_MAVEN_SKIP_TEST=" -Dmaven.test.skip=false";
    fi
    if [[ "${VAR_ARG}" == *"e"* ]]; then
      VAR_MAVEN_SKIP_ENFORCER=" -Denforcer.skip=false";
    fi
  fi
done

rm -rf "${VAR_WORK_DIR}";
mkdir "${VAR_WORK_DIR}";

for VAR_REPOSITORY_NAME in ${VAR_LIBRARY_REPOSITORY_NAMES}
do

  VAR_REPOSITORY_DIR="${VAR_WORK_DIR}/${VAR_REPOSITORY_NAME}";

  echo "--- git clone ${VAR_REPOSITORY_NAME} ---";
  eval "${VAR_GIT} clone -b develop ${VAR_GIT_SCHEMA}:${VAR_GIT_HOST}/${VAR_REPOSITORY_NAME}${VAR_GIT_SUFFIX} ${VAR_REPOSITORY_DIR}";

  pushd "${VAR_REPOSITORY_DIR}" > "/dev/null";

  echo "--- git submodule update ${VAR_REPOSITORY_NAME} ---";
  eval "${VAR_GIT} submodule update --init --remote";

  echo "--- docker stop all except ${VAR_DOCKER_STOP_EXCLUDE} ---";
  for VAR_DOCKER_NAME_RUNNING in $(docker ps -a --format='{{.Names}}')
  do
    VAR_DOCKER_NAME_FOR_STOP="${VAR_DOCKER_NAME_RUNNING}";
    for VAR_DOCKER_NAME_STOP_EXCLUDE in ${VAR_DOCKER_STOP_EXCLUDE}
    do
      if [[ "${VAR_DOCKER_NAME_RUNNING}" == "${VAR_DOCKER_NAME_STOP_EXCLUDE}" ]]; then
        VAR_DOCKER_NAME_FOR_STOP=''
      fi
    done
    if [[ ! -z "${VAR_DOCKER_NAME_FOR_STOP}" ]]; then
      eval "${VAR_DOCKER} rm -f ${VAR_DOCKER_NAME_FOR_STOP}";
    fi
  done

  echo "--- mvn ${VAR_REPOSITORY_NAME} ---";
  if [[ "${VAR_REPOSITORY_NAME}" == "rocketkor-aux" ]]; then
    eval "${VAR_MAVEN}${VAR_MAVEN_SKIP_TEST} -Denforcer.skip=true clean install";
  else
    eval "${VAR_MAVEN}${VAR_MAVEN_SKIP_TEST}${VAR_MAVEN_SKIP_ENFORCER} clean install";
  fi

  popd > "/dev/null";

done

for VAR_REPOSITORY_NAME in ${VAR_SERVICE_REPOSITORY_NAMES}
do

  VAR_REPOSITORY_DIR="${VAR_WORK_DIR}/${VAR_REPOSITORY_NAME}";

  echo "--- git clone ${VAR_REPOSITORY_NAME} ---";
  eval "${VAR_GIT} clone -b develop ${VAR_GIT_SCHEMA}:${VAR_GIT_HOST}/${VAR_REPOSITORY_NAME}${VAR_GIT_SUFFIX} ${VAR_REPOSITORY_DIR}";

  pushd "${VAR_REPOSITORY_DIR}" > "/dev/null";

  echo "--- git submodule update ${VAR_REPOSITORY_NAME} ---";
  eval "${VAR_GIT} submodule update --init --remote";

  echo "--- docker stop all except ${VAR_DOCKER_STOP_EXCLUDE} ---";
  for VAR_DOCKER_NAME_RUNNING in $(docker ps -a --format='{{.Names}}')
  do
    VAR_DOCKER_NAME_FOR_STOP="${VAR_DOCKER_NAME_RUNNING}";
    for VAR_DOCKER_NAME_STOP_EXCLUDE in ${VAR_DOCKER_STOP_EXCLUDE}
    do
      if [[ "${VAR_DOCKER_NAME_RUNNING}" == "${VAR_DOCKER_NAME_STOP_EXCLUDE}" ]]; then
        VAR_DOCKER_NAME_FOR_STOP=''
      fi
    done
    if [[ ! -z "${VAR_DOCKER_NAME_FOR_STOP}" ]]; then
      eval "${VAR_DOCKER} rm -f ${VAR_DOCKER_NAME_FOR_STOP}";
    fi
  done

  echo "--- mvn ${VAR_REPOSITORY_NAME} ---";
  eval "${VAR_MAVEN}${VAR_MAVEN_SKIP_TEST}${VAR_MAVEN_SKIP_ENFORCER} -Pdefault,docker,test clean install";

  popd > "/dev/null";

done

exit 0;
