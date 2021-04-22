FROM python:3.9-slim-buster

# Copy source into image
COPY . /opt/keys-server/
WORKDIR /opt/keys-server/

# Install python requirements
RUN pip install -r requirements.txt

# Run the server
CMD ["honcho", "start"]
