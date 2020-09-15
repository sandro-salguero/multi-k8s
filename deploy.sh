docker build -t sandrosalguero/multi-client:latest -t sandrosalguero/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sandrosalguero/multi-server:latest -t sandrosalguero/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sandrosalguero/multi-worker:latest -t sandrosalguero/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sandrosalguero/multi-client:latest
docker push sandrosalguero/multi-server:latest
docker push sandrosalguero/multi-worker:latest

docker push sandrosalguero/multi-client:$SHA
docker push sandrosalguero/multi-server:$SHA
docker push sandrosalguero/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sandrosalguero/multi-server:$SHA
kubectl set image deployments/client-deployment client=sandrosalguero/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sandrosalguero/multi-worker:$SHA