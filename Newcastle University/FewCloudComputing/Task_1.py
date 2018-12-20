import docker
client = docker.from_env()
#list the containers
for container in client.containers.list():
  print (container.id)
#list image
for image in client.images.list():
     print (image.id)
     
#pull the image
image = client.images.pull("nclcloudcomputing/javabenchmarkapp")
print(image)

container = client.containers.run("nclcloudcomputing/javabenchmarkapp", detach=True)

print(container.id)

for container in client.containers.list():
    container.stop()
