 # Makefile to setup and teardown the container

setup:
  @echo "Setting up resources..."
  @docker-compose -f ./docker-compose.yml up -d --build --force-recreate
    
teardown:
  @echo "Tearing down resources.."
  @docker-compose -f ./docker-compose.yml rm -f -v -s
  @docker system prune -f
