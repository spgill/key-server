FROM python:3.9-slim-buster

# Copy source into image
COPY . /opt/keys-server/
WORKDIR /opt/keys-server/

# Install python requirements
RUN pip install -r requirements.txt

# Volumes and ports
VOLUME /data
EXPOSE 5000/tcp

# Run the server
CMD ["honcho", "start"]
