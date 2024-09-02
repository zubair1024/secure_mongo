import mongoose from "mongoose";
import path from "path";
import fs from "fs";
import { fileURLToPath } from "url";
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const certPath = path.join(__dirname, "certs");

const ca = [fs.readFileSync(path.join(certPath, "ca.pem"))];
const key = fs.readFileSync(path.join(certPath, "mongodb.pem")); // Optional, only if client authentication is required
const cert = fs.readFileSync(path.join(certPath, "mongodb.crt")); // Optional, only if client authentication is required

/**@type {import('mongoose').MongooseOptions}*/
const options = {
  tlsCAFile: path.join(certPath, "ca.pem"),
  tlsCertificateKeyFile: path.join(certPath, "mongodb.pem"),
  tlsAllowInvalidCertificates: true,
  tlsAllowInvalidHostnames: true,
};
// const uri =
//   "mongodb://mongoroot:your_strong_password_here@localhost:27017,localhost:27018,localhost:27019/razrdb?replicaSet=rs0&authSource=admin&tls=true";

const uri =
  "mongodb://mongoroot:your_strong_password_here@node1.razrlab.com:27017,node1.razrlab.com:27017,node2.razrlab.com:27017/razrdb?replicaSet=rs0&authSource=admin&tls=true";

mongoose
  .connect(uri, options)
  .then(() => {
    console.log("Connected to MongoDB with TLS");
  })
  .catch((err) => {
    console.error("Error connecting to MongoDB", err);
  });
