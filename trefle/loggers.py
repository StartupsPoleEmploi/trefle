from datetime import datetime
import logging
import os
import uuid

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

request_esd_logger = logging.getLogger("request_esd_logger")
request_esd_logger.setLevel(logging.INFO)
request_esd_logger.addHandler(
    logging.FileHandler(
        os.path.join(
            os.environ.get("TREFLE_LOG_DIR", "/tmp"),
            "statsesd_trefle.log",
        ),
    )
)


def log_simulate(request, response, context, financements=None, errors=None):
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
    application = request.headers.get('ORIGIN-USER')
    if not application and request.headers.get('AUTHORIZATION'):
        application = 'esd'

    message_esd = {
        "startup": "trefle",
        "requestId":  str(uuid.uuid4()),
        "date": datetime.utcnow().isoformat(),
        "remoteIP": request.headers.get("X-REAL-IP"),
        "httpReferer": request.headers.get("REFERER"),
        "httpUserAgent": request.headers.get("USER-AGENT"),
        "status": response.status,
        "apiVersion": VERSION,
        "application": application,
    }
    request_esd_logger.info(json.dumps(message_esd, sort_keys=True))
