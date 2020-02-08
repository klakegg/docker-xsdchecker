#!/bin/sh

set -e
set -u

if [ "${2:-}" ]; then
  xsdchecker ${@}
elif [ "${INPUT_SCRIPT:-}" ]; then
  # Trigger script.
  sh -ec "${INPUT_SCRIPT}"
elif [ "${INPUT_SCRIPT_PATH:-}" ]; then
  # Trigger script file.
  path=$(echo ${INPUT_SCRIPT_PATH} | envsubst)

  # Check if file exists.
  if [ ! -e $path ]; then
    echo "Unable to find '$path'."
    exit 1
  fi

  # Trigger script.
  source $path
elif [ ! "${2:-}" ]; then
  xsdchecker
fi
