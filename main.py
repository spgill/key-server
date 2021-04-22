# stdlib imports
import os
import pathlib

# vendor imports
import flask
import gevent.pywsgi


# Constants
DATA_VOLUME = "/data"


# Method to generate flask app
def createApp():
    app = flask.Flask(__name__)

    # Flask config
    app.config["DEBUG"] = os.environ.get("FLASK_DEBUG", "").lower() == "true"

    # Default route returns all of the concatenated public keys
    @app.route("/", methods=["GET"])
    def route_default():
        output = ""

        # Iterate through the data volume
        for filepath in pathlib.Path(DATA_VOLUME).iterdir():
            if filepath.suffix.lower() == ".pub":
                with filepath.open("r") as handle:
                    output += handle.read()

        # Build the response object and send it
        response = flask.make_response(output)
        response.headers["content-type"] = "text/plain"
        return response

    return app


# Main method
def main():
    # Create the app
    app = createApp()

    # Start the server
    print("Starting server at http://localhost:5000/")
    gevent.pywsgi.WSGIServer(
        listener=("0.0.0.0", 5000), application=app
    ).serve_forever()


if __name__ == "__main__":
    main()
