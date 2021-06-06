# lab-big-data-processing

## Usage

```bash
git clone xxx

# generate RSA key pair
ssh-keygen -t rsa configs/ssh/id_rsa
cp ./configs/ssh/id_rsa.pub ./configs/ssh/authorized_keys

docker-compose -up -d --scale replica=3
```