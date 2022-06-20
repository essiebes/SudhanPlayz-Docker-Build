#!/bin/bash
currentver="$1"
requiredver="4.0.0"
 if [ "$(printf '%s\n' "$requiredver" "$currentver" | sort -V | head -n1)" = "$requiredver" ]; then 
        exit 0
 else
        exit 1
 fi
