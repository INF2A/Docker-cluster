#!/bin/bash
echo $(docker node ps "$1" | grep 'Running.*Running' | egrep -o 'timeapi:|radioapi:|weatherapi:|newsapi:|helloworldapi:|calendarapi:')     
