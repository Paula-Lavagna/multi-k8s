docker build -t paulalavagna/k8s-client:latest -t paulalavagna/k8s-client:$SHA -f ./client/Dockerfile ./client
docker build -t paulalavagna/k8s-server:latest -t paulalavagna/k8s-server:$SHA -f ./server/Dockerfile ./server
docker build -t paulalavagna/k8s-worker:latest -t paulalavagna/k8s-worker:$SHA -f ./worker/Dockerfile ./worker
docker push paulalavagna/k8s-client:latest
docker push paulalavagna/k8s-server:latest
docker push paulalavagna/k8s-worker:latest

docker push paulalavagna/k8s-client:$SHA
docker push paulalavagna/k8s-server:$SHA
docker push paulalavagna/k8s-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=paulalavagna/k8s-server:$SHA
kubectl set image deployments/client-deployment client=paulalavagna/k8s-client:$SHA
kubectl set image deployments/worker-deployment worker=paulalavagna/k8s-worker:$SHA