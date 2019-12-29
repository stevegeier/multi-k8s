docker build -t stevegeier/multi-client:latest -t stevegeier/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t stevegeier/multi-server:latest -t stevegeier/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t stevegeier/multi-worker:latest -t stevegeier/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push stevegeier/multi-client:latest
docker push stevegeier/multi-server:latest
docker push stevegeier/multi-worker:latest

docker push stevegeier/multi-client:$SHA
docker push stevegeier/multi-server:$SHA
docker push stevegeier/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=stevegeier/multi-server:$SHA
kubectl set image deployments/client-deployment client=stevegeier/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=stevegeier/multi-worker:$SHA
