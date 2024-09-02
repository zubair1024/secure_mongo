docker exec -it mongo mongosh --tls --tlsCertificateKeyFile /etc/mongodb/mongodb.pem --tlsCAFile /etc/mongodb/ca.pem

rs.initiate({
  _id: "rs0",
  members: [
    {_id: 0, host: "node1.razrlab.com:27017"},
    {_id: 1, host: "node2.razrlab.com:27017"},
    {_id: 2, host: "node3.razrlab.com:27017"}
  ]
})

// Create root user
use admin
db.createUser(
  {
    user: "mongoroot",
    pwd: "your_strong_password_here",
    roles: [ { role: "root", db: "admin" } ]
  }
)

exit