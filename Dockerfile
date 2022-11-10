FROM python:3.10-slim-bullseye

# Copy source into image
COPY . /opt/key-server/
WORKDIR /opt/key-server/

# Install python requirements
RUN pip install -r requirements.txt

# Volumes and ports
VOLUME /data
EXPOSE 5000/tcp

# Run the server
ENTRYPOINT [ "./docker-entrypoint.sh" ]
