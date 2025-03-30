#!/bin/bash

# Wait until MongoDB starts
until mongosh --quiet --host localhost --port 27017 --eval "db.runCommand({ ping: 1 }).ok" | grep 1 &>/dev/null; do
  sleep 1
done

echo "MongoDB has started successfully"

echo "Initiating MongoDB replica set..."

# Initiate the replica set
mongosh -u root -p root --host localhost --port 27017 --eval "
  rs.initiate({
    _id: 'rs0',
    members: [
      {
        _id: 0,
        host: 'localhost:27017'
      }
    ]
  })
"
