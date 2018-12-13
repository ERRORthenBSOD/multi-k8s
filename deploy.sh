docker build -t atmosphericb/multi-client:latest -t atmosphericb/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t atmosphericb/multi-server:latest -t atmosphericb/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t atmosphericb/multi-worker:latest -t atmosphericb/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push atmosphericb/multi-client:latest
docker push atmosphericb/multi-server:latest
docker push atmosphericb/multi-worker:latest

docker push atmosphericb/multi-client:$SHA
docker push atmosphericb/multi-server:$SHA
docker push atmosphericb/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=atmosphericb/multi-server:$SHA
kubectl set image deployments/client-deployment client=atmosphericb/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=atmosphericb/multi-worker:$SHA