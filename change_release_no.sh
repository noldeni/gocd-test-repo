#!/bin/bash
SEARCH_VERSION="#UNDEFINED_VERSION#"
SEARCH_RELEASE="#UNDEFINED_RELEASE#"
if [ -z ${GO_PIPELINE_COUNTER} ]; then COUNTER="NA"; else COUNTER=$GO_PIPELINE_COUNTER; fi
LAST_TAG=$(git describe --tag --abbrev=0 2>&1)
if [ $? -eq 0 ] 
then
  sed -i "s/${SEARCH_VERSION}/${LAST_TAG}/g" source/conf.py
  sed -i "s/${SEARCH_RELEASE}/${LAST_TAG}-${COUNTER}/g" source/conf.py
fi

