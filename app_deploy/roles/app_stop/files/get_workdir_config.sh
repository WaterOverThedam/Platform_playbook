#!/bin/bash


find /winning/app/ \( -regex '.*/[0-9]*/application.properties' -o -regex '.*/[0-9]*/application.yml' \)| \
awk -F '(application.properties|application.yml)' '{print $0"|"$1}'|sort
