# Self Signed Certificate Procedure

```
openssl req -x509 -newkey rsa:4096 -keyout wild_local_com.key -out wild_local_com.crt -sha256 -days 3650 -nodes -subj "/C=GB/ST=England/L=Leicester/O=RavenItSystems/OU=Web/CN=*.local.com"
```
