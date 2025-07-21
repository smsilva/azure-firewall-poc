# azure-firewall-poc

## Comandos para rodar nas VMs

```bash
sudo apt install -y dnsutils traceroute netcat curl tmux && tmux
```

```bash
nslookup        wittyrock-527c4502.eastus.azurecontainerapps.io
nslookup  app-1.wittyrock-527c4502.eastus.azurecontainerapps.io

curl -I --connect-timeout 3 https://app-1.wittyrock-527c4502.eastus.azurecontainerapps.io
curl -I --connect-timeout 3 https://app-1.politedesert-43ee8ea9.eastus.azurecontainerapps.io
curl -I --connect-timeout 3 https://app-1.delightfulriver-1e65689f.eastus.azurecontainerapps.io

curl -I  --connect-timeout 3 -H "Host: app-1.delightfulriver-1e65689f.eastus.azurecontainerapps.io" http://10.0.1.202

nc -dv -w 3 10.0.0.4 80
nc -dv -w 3 10.1.0.4 80
nc -dv -w 3 10.2.0.4 80
```

## Comandos para rodar no Container App com Linux Mariner

```bash
tdnf update -y
tdnf install -y tar bind-utils
```

## Comandos para testar MongoDB

```bash
curl \
  --insecure https://downloads.mongodb.com/compass/mongosh-2.5.5-linux-x64.tgz \
  --output mongosh-2.5.5-linux-x64.tgz

tar -xzf mongosh-2.5.5-linux-x64.tgz

export PATH=${PATH}:$PWD/mongosh-2.5.5-linux-x64/bin

MONGODB_CONNECTION_STRING="mongodb://wasp-cloud-poc-joint-gazelle-core-main:REDACTED_CREDENTIAL_HERE@wasp-cloud-poc-joint-gazelle-core-main.mongo.cosmos.azure.com:10255/?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@wasp-cloud-poc-joint-gazelle-core-main@"

mongosh "${MONGODB_CONNECTION_STRING}" --eval 'db.createCollection("posts")'
mongosh "${MONGODB_CONNECTION_STRING}" --eval 'db.posts.insertOne({ text: "this is an example", author: "Moisés" })'
mongosh "${MONGODB_CONNECTION_STRING}" --eval 'db.posts.find({})'
```
