kubectl delete secret -n cert-manager ca-key-pair
rm -rf ca
mkdir ca
echo "126123" > ca.db.serial
openssl genrsa -out ca/ca.key 2048
openssl req -new -x509 -days 10000 -key ca/ca.key -out ca/ca.crt

sudo cp ca/ca.crt /usr/local/share/ca-certificates/kind/kind.crt
sudo update-ca-certificates

kubectl create secret -n cert-manager --from-file=tls.crt=ca/ca.crt  --from-file=tls.key=ca/ca.key generic ca-key-pair