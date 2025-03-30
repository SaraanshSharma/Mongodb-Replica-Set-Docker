# MongoDB Replica Set with Docker

This repository contains a Docker-based setup for running a MongoDB replica set using a single-node configuration. It includes scripts for initializing a keyfile and setting up the replica set.

## Features
- Runs MongoDB in a container with replica set support.
- Uses a keyfile for authentication.
- Automates the initialization of the replica set.
- Uses environment variables for easy configuration.

## Prerequisites
- Docker
- Docker Compose
- Linux-based system (This setup may not work on Windows)

## Setup Instructions

### 1. Clone the Repository
```sh
git clone https://github.com/SaraanshSharma/Mongodb-Replica-Set-Docker.git
cd Mongodb-Replica-Set-Docker
```

### 2. Configure Environment Variables
Copy the `.env.example` file and rename it to `.env`.
```sh
cp .env.example .env
```
Edit the `.env` file and set the `MONGO_REPLICA_SET_KEY`. You can generate a secure key using OpenSSL:
```sh
openssl rand -base64 756 > mongo-keyfile
chmod 600 mongo-keyfile
```
Then, copy the contents of `mongo-keyfile` into your `.env` file:
```env
MONGO_REPLICA_SET_KEY=your-secure-key
```

### 3. Update Configuration
Before running the setup, update the following in `docker-compose.yml`:
- **Change the MongoDB ports** if needed (default is `27017`).
- **Set your own MongoDB root username and password** instead of the default `root` credentials.

### 4. Start the Containers
Run the following command to start the MongoDB replica set:
```sh
docker compose up -d
```

### 5. Verify the Replica Set
After the containers start, you can verify the replica set status:
```sh
docker exec -it mongodb-1 mongosh -u root -p root --host localhost --port 27017 --eval "rs.status()"
```

## File Structure
```
.
├── .env.example              # Environment variables template
├── docker-compose.yml        # Docker Compose file for MongoDB replica set
├── init-keyfile.sh           # Script to generate the keyfile
├── init-replica-set.sh       # Script to initialize the MongoDB replica set
```

## Stopping the Containers
To stop the running containers, execute:
```sh
docker compose down
```

## Notes
- Ensure that the keyfile permissions are correctly set; otherwise, MongoDB will not start.
- If you need to reset the replica set, remove the data directory (`./data/mongodb-1`) and restart the containers.
- This setup is currently tested on **Linux-based systems**. It may not work on Windows without modifications.

## License
This project is licensed under the MIT License.

---
Developed by [Saraansh Sharma](https://github.com/SaraanshSharma)

