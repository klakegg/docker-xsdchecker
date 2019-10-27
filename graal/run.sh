#!/bin/sh

set -e
set -u

if [ ! "${2:-}" ]; then
  xsdchecker
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

  xsdchecker $xsd ${@}
fi
