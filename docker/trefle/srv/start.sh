#!/bin/sh
set -e

#start cron for logrotate
service cron start

cp authorisations.csv /usr/local/lib/python${PYTHON_VERSION}/site-packages/trefle/config/authorisations.csv



#start or reload gunicorn
if pgrep -x "gunicorn" > /dev/null
then
    killall -HUP gunicorn
else
    gunicorn trefle.api:app --config gunicorn.conf.py \
            --error-logfile log/gunicorn-error.log  \
            --capture-output
fi


#NOTE : see https://stackoverflow.com/a/20214015 for why gunicorn-access.log not in use
