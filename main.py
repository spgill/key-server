# stdlib imports
import pathlib
import re

# vendor imports
import fastapi
from fastapi.responses import PlainTextResponse


# Constants
DATA_VOLUME = "/data"

app = fastapi.FastAPI()


# There's only one route for this app
@app.get("/")
def route_default():
    keys = []

    # Iterate through the data volume
    for filepath in pathlib.Path(DATA_VOLUME).iterdir():
        if filepath.suffix.lower() == ".pub":
            with filepath.open("r") as handle:
                keyContents = handle.read().strip()
                keyMinusComment = re.sub(r" \S+@\S+$", "", keyContents)
                keys.append(keyMinusComment)

    # Return a concatentation of all the key objects
    return PlainTextResponse("\n".join(keys) + "\n")
