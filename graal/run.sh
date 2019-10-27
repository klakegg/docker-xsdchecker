#!/bin/sh

set -e
set -u

if [ "${INPUT_SCRIPT:-}" ]; then
  # Trigger script.
  sh -c "${INPUT_SCRIPT}"
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
  xsdchecker-official
else
  xsd=$1
  shift

  case $xsd in
    "--maven")
      xsd="/schemas/maven-4.0.0.xsd"
      ;;
    "--maven-4.0")
      xsd="/schemas/maven-4.0.0.xsd"
      ;;
    "--xsd-1.0")
      xsd="/schemas/xsd-1.0.xsd"
      ;;
    "--xslt2")
      xsd="/schemas/xslt-2.0.xsd"
      ;;
    "--xslt-2.0")
      xsd="/schemas/xslt-2.0.xsd"
      ;;
  esac

  xsdchecker-official $xsd ${@}
fi
