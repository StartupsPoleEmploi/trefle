from datetime import datetime
import logging
import logging.handlers
import os

import ujson as json

from . import VERSION

logger = logging.getLogger("trefle")
logger.setLevel(logging.DEBUG)
logger.addHandler(logging.StreamHandler())

request_logger = logging.getLogger("request_logger")
request_logger.setLevel(logging.INFO)
request_logger.addHandler(
    logging.handlers.TimedRotatingFileHandler(
        os.path.join(
            os.environ.get("TREFLE_LOG_DIR", "/tmp"),
            "trefle-simulate.log",
        ),
        when="midnight",
        backupCount=365,
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
