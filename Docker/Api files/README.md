# Api files

All the dockerfiles use a war file and server.xml<br/>
The war file is the java api and the server.xml set the outport of tomcat.


Ipadress | Port | Api name | Api syntax
--- | --- | --- | ---
192.168.1.1|	:8080 |	/helloworldapi |	/helloworld
192.168.1.1|	:8081 |	/calendarapi | /calendar
192.168.1.1|  :8082 | /newsapi | /news/bbc/	
192.168.1.1|	:8083 | /radioapi |	/?
192.168.1.1|	:8084 | /timeapi | /time/Europe/Amsterdam
192.168.1.1|	:8085 | /weatherapi |	/weather/Amsterdam/metric
192.168.1.1|  :8086 | /monitorapi | /monitor

Source:https://github.com/INF2A/HelloWorldapi <br/>
Source:https://github.com/INF2A/calendarapi <br/>
Source:https://github.com/INF2A/newsapi <br/>
Source:https://github.com/INF2A/radioapi <br/>
Source:https://github.com/INF2A/timeapi <br/>
Source:https://github.com/INF2A/weatherapi <br/>
