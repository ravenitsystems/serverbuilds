# Self Signed Certificate Procedure

```
openssl req -x509 -newkey rsa:4096 -keyout wild_local_com.key -out wild_local_com.crt -sha256 -days 3650 -nodes -subj "/C=GB/ST=England/L=Leicester/O=RavenItSystems/OU=Web/CN=*.local.com"
```

### Adding a certificate to the Windows trusted roots

- Press Crtl+R to bring up the run dialoge
- Type `certlm.msc` and press enter, this will display the cert management app
- Search for "Trusted Root Certification" and expand
- Click on the "Certificates" Sub menu, you will see the trusted roots
- Right click on this folder and navigate to All Tasks -> Import. This will bring up a wizard
- Click next to select Local Machine
- Browse the filesystem and find the certificate you want to trust and press next
- On the next page ensure that "Place all certificates in following store" is selected and the drop down says "Trusted Root Certification Authorities"
- Click next and you will be presented with a summary of whjat you are about to do, glance over it until happy
- Click on Finish, you should see a dialogue that says "sucessfully imported"

