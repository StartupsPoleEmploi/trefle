from datetime import datetime
import logging
import os

import ujson as json

from . import VERSION

logger = logging.getLogger("trefle")
logger.setLevel(logging.DEBUG)
logger.addHandler(logging.StreamHandler())

request_logger = logging.getLogger("request_logger")
request_logger.setLevel(logging.INFO)
request_logger.addHandler(
    logging.FileHandler(
        os.path.join(
            os.environ.get("TREFLE_LOG_DIR", "/tmp"),
            "trefle-simulate.log",
        ),
    )
)


def log_simulate(context, financements=None, errors=None):
    financements = financements or []
    errors = errors or []
    message = {
        "date": datetime.utcnow().isoformat(),
        "context": context,
        "financements": [f["intitule"] for f in financements if f["eligible"]],
        "errors": errors,
        "version": VERSION,
    }
    request_logger.info(json.dumps(message, sort_keys=True))
