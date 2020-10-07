$reg_name='kind-registry'
$reg_port=5000
$running=docker inspect -f '{{.State.Running}}' $reg_name 2> $null

If (-NOT $running)
{
    echo "Starting Registry"
    docker run -d --restart=always -p ${reg_port}:5000 --name ${reg_name} registry:2
}
else
{
    echo "Registry Running"
}

kind create cluster --config cluster.yaml
docker network connect "kind" "${reg_name}"

kubectl annotate node kind-control-plane "kind.x-k8s.io/registry=localhost:5000"
kubectl taint nodes --all node-role.kubernetes.io/master-
