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

tokenUri="https://ghcr.io/token"
data=("service=ghcr.io" "scope=repository:$item:pull")
token="$(curl --silent --get --data-urlencode ${data[0]} --data-urlencode ${data[1]} $tokenUri | sed -E 's/(\{|\})//g' | grep -oP '^"token":"\K.*?(?="$|$)')"
listUri="https://ghcr.io/v2/$item/tags/list"
result="$(curl --silent --get -H "Accept: application/json" -H "Authorization: Bearer $token" $listUri | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n'  | awk -F: '{print $3}' | tr ',' '\n')"
echo "${result}"
