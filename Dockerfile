FROM python:3.10-slim-bullseye

# Add Tini
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

# Copy source into image
COPY . /opt/key-server/
WORKDIR /opt/key-server/

# Install python requirements
RUN pip install -r requirements.txt

# Volumes and ports
VOLUME /data
EXPOSE 5000/tcp

# Run the server
ENTRYPOINT ["/tini", "-v", "--", "./docker-entrypoint.sh"]
