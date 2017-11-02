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

SEARCH_VERSION="#UNDEFINED_VERSION#"
SEARCH_RELEASE="#UNDEFINED_RELEASE#"
if [ -z ${GO_PIPELINE_COUNTER} ]; then COUNTER="NA"; else COUNTER=$GO_PIPELINE_COUNTER; fi
LAST_TAG=$(git describe --tag --abbrev=0 2>&1)
if [ $? -eq 0 ]
then
  sed -i "s/${SEARCH_VERSION}/${LAST_TAG}/g" source/conf.py
  sed -i "s/${SEARCH_RELEASE}/${LAST_TAG}-${COUNTER}/g" source/conf.py
fi

echo "Building $BUILDTYPE"
/usr/bin/docker run --rm -i -v "${PWD}:/doc" -u "$(id -u):$(id -g)" eomir/docker-sphinx make $BUILDTYPE

