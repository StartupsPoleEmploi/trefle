# Trefle deployment

Ask your colleague to give you the `secrets.yml` file and add it to the current folder.

## Requirements

  pip install ansible

## Install everything

  make install

## Upgrade to the latest version of trefle

  make upgrade

## Other commands

Restart all services:

  make restart

Tail nginx access and error logs:

  make access-logs
  make error-logs

Tail trefle logs:

  make app-logs

Tail simulate logs:

  make simulate-logs
  
(Known limitation: with these commands, you will not be able to follow logs)

Get status of different services:

  make status
