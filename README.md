# azure-firewall-poc

## Comandos para rodar nas VMs

```bash
sudo apt install -y dnsutils traceroute netcat curl tmux && tmux

nslookup        ashycliff-6d0e0fd0.eastus.azurecontainerapps.io
nslookup  app-1.ashycliff-6d0e0fd0.eastus.azurecontainerapps.io

nc -dv -w 3 10.0.1.202 443

traceroute 10.0.1.202

curl -I --connect-timeout 3 https://app-1.ashycliff-6d0e0fd0.eastus.azurecontainerapps.io
curl -I --connect-timeout 3 https://app-1.gentlegrass-121cd74d.eastus.azurecontainerapps.io
curl -I --connect-timeout 3 https://app-1.ambitiouswater-a7a0e1ba.eastus.azurecontainerapps.io

curl -I  --connect-timeout 3 -H "Host: app-1.ambitiouswater-a7a0e1ba.eastus.azurecontainerapps.io" http://10.0.1.202

vm-spoke-core 10.0.0.4
vm-spoke-1    10.1.0.4
vm-spoke-2    10.2.0.4

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
curl -k https://downloads.mongodb.com/compass/mongosh-2.5.5-linux-x64.tgz --output mongosh-2.5.5-linux-x64.tgz

tar -xzf mongosh-2.5.5-linux-x64.tgz

export PATH=${PATH}:$PWD/mongosh-2.5.5-linux-x64/bin

MONGODB_CONNECTION_STRING=""

mongosh "${MONGODB_CONNECTION_STRING}" --eval 'db.createCollection("posts")'

db.createCollection("posts")

db.posts.insertOne({ text: "this is an example", author: "Moisés" })

db.posts.find({})
```
