#!/bin/bash
echo $(docker node ps "$1" | grep 'Running' | egrep -o 'timeapi:|radioapi:|weatherapi:|newsapi:|helloworldapi:|caledarapi')     
