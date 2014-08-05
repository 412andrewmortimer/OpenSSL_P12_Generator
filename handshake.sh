#!/bin/sh

subject="/O=Honest Achmed/OU=Fake Certs/CN=google.com"
file="name_it"
cafile="name_it_ca"


openssl req -new -newkey rsa:2048 -days 365 -subj "$subject" \
    -x509 -out "$cafile.pem" -keyout "$cafile.key" -nodes


openssl req -new -newkey rsa:2048 -days 365 -subj "$subject" \
    -out "$file.csr" -keyout "$file.key" -nodes

openssl x509 -req -in "$file.csr" -out "$file.pem" \
    -CA "$cafile.pem" -CAkey "$cafile.key" -CAserial "serial.txt"

openssl pkcs12 -export -in "$file.pem" -inkey "$file.key" -out "$file.p12"
