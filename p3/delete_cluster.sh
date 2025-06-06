echo "Deleting cluster..."
k3d cluster delete p3
sleep 5s

echo "Stop and prune docker..."
docker stop $(docker ps -a -q)
docker system prune -af
docker volume prune -f