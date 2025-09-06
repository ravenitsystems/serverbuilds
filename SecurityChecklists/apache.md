# SECURITY CHECKLIST FOR APACHE

This checklist is based on the software family and is not made for a specific version, it covers all the basic production hardening for Apache. 

## Basic Configuration

* Set ServerTokens Prod in httpd.conf to hide any version information, this makes it harder for an attacker to look up potential exploits solwing them down.
* Set ServerSignature Off in the httpd.conf to hide any information given by the page footer upon error
* Disable all directory listing using Options -Indexes if the options are in negative mode or simply missing them out if using positive mode
* Disable htaccess overrides except the ones that are needed
* Use TraceEnable Off to disable the HTTP TRACE method.

