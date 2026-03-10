# Self Signed Certificate Procedure


## Creating the new certificate

The first thing we need to do is generate a private key for us to base the rest of this process off, we will use 4096 length keys so its nice and secure.
```
openssl genrsa -out any_local_com.key 4096
```
Now we need a signing request based on the key we have previously generated
```
openssl req -new -key any_local_com.key -out any_local_com.csr
```
Because we want to use the new SAN protocols because windows will not accept it if we do not, we need to make a tempary version 3 configuration file.
```
cat >v3.ext <<EOL
subjectKeyIdentifier   = hash
authorityKeyIdentifier = keyid:always,issuer:always
basicConstraints       = CA:TRUE
keyUsage               = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment, keyAgreement, keyCertSign
subjectAltName         = DNS:local.com, DNS:*.local.com
issuerAltName          = issuer:copy
EOL
```
Now we have everything ready we can go ahead and generate the actual certificate
```
openssl x509 -req -in any_local_com.csr -signkey any_local_com.key -out any_local_com.crt -days 3650 -sha256 -extfile v3.ext

rm -f v3.ext
```
## Trusting the new certificate

### Adding a certificate to the linux trusted roots


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

