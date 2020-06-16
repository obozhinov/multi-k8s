docker build -t obozhinov/multi-client:latest -t obozhinov/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t obozhinov/multi-server:latest -t obozhinov/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t obozhinov/multi-worker:latest -t obozhinov/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push obozhinov/multi-client:latest
docker push obozhinov/multi-server:latest
docker push obozhinov/multi-worker:latest

docker push obozhinov/multi-client:$SHA
docker push obozhinov/multi-server:$SHA
docker push obozhinov/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image obozhinov/server-deployment server=obozhinov/multi-server:$SHA
kubectl set image obozhinov/client-deployment server=obozhinov/multi-client:$SHA
kubectl set image obozhinov/worker-deployment server=obozhinov/multi-worker:$SHA
