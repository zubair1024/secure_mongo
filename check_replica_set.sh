mongosh --tls --tlsCertificateKeyFile /etc/mongodb/mongodb.pem --tlsCAFile /etc/mongodb/ca.pem --tlsAllowInvalidCertificates --eval 'rs.status()'
