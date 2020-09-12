#!/bin/bash

set -o nounset \
    -o errexit \
    -o verbose \
    -o xtrace

# Generate CA key
openssl req -new -x509 -keyout snakeoil-ca-1.key -out snakeoil-ca-1.crt -days 365 -subj '/CN=ca1.test/OU=TEST/O=TEST/L=TEST/ST=TEST/C=US' -passin pass:CarnegieBg! -passout pass:CarnegieBg!

# Setup broker stores
for i in broker1 broker2 broker3
do
	echo $i
	# Create keystores
	keytool -genkey -noprompt \
				 -alias $i \
				 -dname "CN=$i.test,OU=TEST,O=TEST,L=TEST,ST=TEST,C=US" \
				 -keystore kafka.$i.keystore.jks \
				 -keyalg RSA \
				 -storepass CarnegieBg! \
				 -keypass CarnegieBg!

	# Create CSR, sign the key and import back into keystore
	keytool -noprompt -keystore kafka.$i.keystore.jks -alias $i -certreq -file $i.csr -storepass CarnegieBg! -keypass CarnegieBg!

	openssl x509 -req -CA snakeoil-ca-1.crt -CAkey snakeoil-ca-1.key -in $i.csr -out $i-ca1-signed.crt -days 9999 -CAcreateserial -passin pass:CarnegieBg!

	keytool -noprompt -keystore kafka.$i.keystore.jks -alias CARoot -import -file snakeoil-ca-1.crt -storepass CarnegieBg! -keypass CarnegieBg!

	keytool -noprompt -keystore kafka.$i.keystore.jks -alias $i -import -file $i-ca1-signed.crt -storepass CarnegieBg! -keypass CarnegieBg!

	# Create truststore and import the CA cert.
	keytool -noprompt -keystore kafka.$i.truststore.jks -alias CARoot -import -file snakeoil-ca-1.crt -storepass CarnegieBg! -keypass CarnegieBg!

  echo "CarnegieBg!" > ${i}_sslkey_creds
  echo "CarnegieBg!" > ${i}_keystore_creds
  echo "CarnegieBg!" > ${i}_truststore_creds
done

# Setup client stores
for i in admin user
do
	echo $i
	# Create keystores
	keytool -genkey -noprompt \
				 -alias $i \
				 -dname "CN=$i.test,OU=TEST,O=TEST,L=TEST,ST=TEST,C=US" \
				 -keystore kafka.$i.keystore.jks \
				 -keyalg RSA \
				 -storepass CarnegieBg! \
				 -keypass CarnegieBg!

	keytool -noprompt -keystore kafka.$i.keystore.jks -alias CARoot -import -file snakeoil-ca-1.crt -storepass CarnegieBg!

	keytool -noprompt -keystore kafka.$i.keystore.jks -alias $i -certreq -file cert-file-client-$i -storepass CarnegieBg!

	openssl x509 -req -CA snakeoil-ca-1.crt -CAkey snakeoil-ca-1.key -in cert-file-client-$i -out cert-signed-client-$i -days 365 -CAcreateserial -passin pass:CarnegieBg!

	# Create truststore and import the CA cert.
	keytool -noprompt -keystore kafka.$i.truststore.jks -alias CARoot -import -file snakeoil-ca-1.crt -storepass CarnegieBg! -keypass CarnegieBg!

	# Add signed client cert to brokers trust
	keytool -noprompt -keystore kafka.broker1.truststore.jks -alias $i -import -file cert-signed-client-$i -storepass CarnegieBg!
	keytool -noprompt -keystore kafka.broker2.truststore.jks -alias $i -import -file cert-signed-client-$i -storepass CarnegieBg!
	keytool -noprompt -keystore kafka.broker3.truststore.jks -alias $i -import -file cert-signed-client-$i -storepass CarnegieBg!

	# Export raw key from keystore for other use cases
	keytool -noprompt -importkeystore -srckeystore kafka.$i.keystore.jks -destkeystore kafka.$i.keystore.p12 -deststoretype PKCS12 -srcstorepass CarnegieBg! -deststorepass CarnegieBg!
	openssl pkcs12 -in kafka.$i.keystore.p12 -nodes -nocerts -out $i.private.key -passin pass:CarnegieBg!
	openssl rsa -in $i.private.key -out $i.private.key 
done
