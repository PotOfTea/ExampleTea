Description
===========
This cookbook installs Ganglia, Java, Custome web service

ganglia - http://127.0.0.1:8080/ganglia/
websevice - http://127.0.0.1:8181/ws/passgen

Usage
=====
## Example
* Run vagrant up
* open ganglia panel http://127.0.0.1:8080/ganglia/
* Check WebService Graph
* Run testWs.cmd/testWs.sh

## Java webservice
Web service generate passwords

Accepts java properties:

* -Dws.url - used to set webserice url
* -Dws.url.tester - used to set webservice tester url

Accepts java command line args:

*  test  - run web service tester

Requirements
============
* Ubuntu

Attributes
==========