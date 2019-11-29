FROM python:3.6

LABEL MAINTAINER "labonneformation@pole-emploi.fr"

ENV LANG C.UTF-8
ENV PYTHON_VERSION 3.6
ENV TREFLE_LOG_DIR /srv/log
ARG TREFLE_VERSION
ARG TREFLE_GIT

RUN apt-get update && apt-get -y install \
                                    software-properties-common\
                                    unzip \
                                    vim \
                                    bzip2 \
                                    git\
                                    pkg-config\
                                    logrotate\
                                    rsync\
                                    cron

# setup system
RUN mkdir -p ${TREFLE_LOG_DIR}
WORKDIR /srv
COPY docker/gunicorn.logrotate /etc/logrotate.d/gunicorn

#deploy
COPY docker/gunicorn.conf.py ./gunicorn.conf.py


# setup virtualenv
RUN pip install pip -U && \
    pip install gunicorn && \
    pip install git+${TREFLE_GIT}@${TREFLE_VERSION}

#start
COPY trefle/start.sh .
ENTRYPOINT ./start.sh
