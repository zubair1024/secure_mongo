# Generate CA key and certificate
openssl genrsa -out certs/ca.key 4096
openssl req -x509 -new -nodes -key certs/ca.key -sha256 -days 1024 -out certs/ca.pem -subj "/CN=MongoCA"

# Generate server key
openssl genrsa -out certs/mongodb.key 4096

# Create a configuration file for the CSR
cat >certs/mongodb.cnf <<EOF
[req]
default_bits = 4096
prompt = no
default_md = sha256
req_extensions = req_ext
distinguished_name = dn

[dn]
CN = localhost

[req_ext]
subjectAltName = @alt_names

[alt_names]
DNS.1 = localhost
DNS.2 = mongo1
DNS.3 = mongo2
DNS.4 = mongo3
IP.1 = 127.0.0.1
EOF

# Generate server certificate signing request (CSR)
openssl req -new -key certs/mongodb.key -out certs/mongodb.csr -config certs/mongodb.cnf

# Sign the server certificate with the CA
openssl x509 -req -in certs/mongodb.csr -CA certs/ca.pem -CAkey certs/ca.key -CAcreateserial -out certs/mongodb.crt -days 365 -sha256 -extfile certs/mongodb.cnf -extensions req_ext

# Create the PEM file that includes the server certificate and private key
cat certs/mongodb.key certs/mongodb.crt >certs/mongodb.pem
