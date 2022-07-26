docker build -t duyly/multi-client:latest -t duyly/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t duyly/multi-server:latest -t duyly/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t duyly/multi-worker:latest -t duyly/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push duyly/multi-client:latest
docker push duyly/multi-server:latest
docker push duyly/multi-worker:latest

docker push duyly/multi-client:$SHA
docker push duyly/multi-server:$SHA
docker push duyly/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=duyly/multi-server:$SHA
kubectl set image deployments/client-deployment client=duyly/multi-client:$SHA
kubectl set image deployments/worker-deployment client=duyly/multi-worker:$SHA
