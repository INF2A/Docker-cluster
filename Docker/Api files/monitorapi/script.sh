#!/bin/bash
echo $(docker node ps "$1" | grep 'Running.*Running' | egrep -o 'helloworld:|timeapi:|radioapi:|weatherapi:|newsapi:|helloworldapi:|calendarapi:')     
