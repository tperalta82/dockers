docker run -d \
-p 5000:5000 \
--restart=always \
--name registry \
-v /opt/docker:/var/lib/registry \
-e SEARCH_BACKEND=sqlalchemy \
registry:2 serve /etc/docker/registry/config.yml


docker run -d \
-p 8080:8080 \
--restart=always \
--name registryui \
-e REGISTRY_HOST=172.17.0.2 \
-e REGISTRY_PORT=5000  \
hyper/docker-registry-web
