#!/bin/bash

if [ $# -lt 1 ]
then
cat << HELP

githubtags  --  list all tags for a Docker image on a remote registry.

EXAMPLE:
    - list all tags for ubuntu:
       githubtags ubuntu

HELP
fi

item="$1"

listUri="https://api.github.com/repos/$item/releases"
result="$(curl --silent --get -H "Accept: application/json" $listUri | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n' | grep tag_name | awk -F: '{print $2}' | tr -d ',')"
echo "${result}"
