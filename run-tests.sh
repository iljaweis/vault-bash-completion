#!/bin/sh

for bash_version in 4.4.5 3.2.57; do
  echo "*** Running tests for bash $bash_version ..."
  docker-compose -f tests/docker-compose.yml run test-vault-bash-completion-$bash_version
  echo
done
