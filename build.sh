#!/bin/bash

function usage {
  echo "Usage: `basename $0` option";
  echo "  Option is one of:";
  echo "    -h or --html -> Build html";
  echo "    -p or --pdf -> Build pdf";
  echo "    -j or --json -> Build json";
}

if (($# == 0)); then
  usage;
  exit $E_OPTERROR;
fi

key="$1"
case $key in
  -h|--html)
  BUILDTYPE=html
  ;;
  -p|--pdf)
  BUILDTYPE=pdf
  ;;
  -j|--json)
  BUILDTYPE=json
  ;;
  -a|--all)
  BUILDTYPE=ALL
  ;;
  *)    # unknown option
	  usage;
	  exit $E_OPTERROR;
  ;;
esac

echo "Building $BUILDTYPE"
/usr/bin/docker run --rm -i -v "${PWD}:/doc" -u "$(id -u):$(id -g)" eomir/docker-sphinx make $BUILDTYPE