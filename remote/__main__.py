import os
import sys
from io import StringIO
import urllib.request


import minicli
from usine import run, sudo, connect, mkdir, chown, exists, put, config


def python(command):
    """Run a python command on the remote server.

    :command: the python command to run.
    """
    with sudo(user='trefle'):
        run('/srv/trefle/venv/bin/python {}'.format(command))


@minicli.cli
def pip(command):
    """Run a pip command on the remote server.

    :command: the pip command to run.
    """
    with sudo(user='trefle'):
        run('/srv/trefle/venv/bin/pip {}'.format(command))


@minicli.cli
def system():
    """Setup the system."""
    with sudo():
        run('apt update')
        run('apt install -y nginx git software-properties-common gcc '
            'python-virtualenv python3.6 python3.6-dev pkg-config')
        mkdir('/srv/trefle/data')
        run('useradd -N trefle -d /srv/trefle/ || exit 0')
        chown('trefle:users', '/srv/trefle/')
        run('chsh -s /bin/bash trefle')


@minicli.cli
def venv():
    """Setup the python virtualenv."""
    path = '/srv/trefle/venv/'
    if not exists(path):
        with sudo(user='trefle'):
            run(f'virtualenv {path} --python=python3.6')
    pip('install pip -U')


@minicli.cli
def http():
    """Setup the HTTP layer."""
    # TODO: https when we have a domain.
    put('remote/nginx-http.conf', '/etc/nginx/sites-enabled/trefle')
    restart()


@minicli.cli
def bootstrap():
    """Bootstrap the system."""
    system()
    venv()
    service()
    http()


@minicli.cli
def cli(command):
    """Run the trefle executable on the remote server.

    :command: the trefle command to run.
    """
    with sudo(user='trefle'):
        run(f'/srv/trefle/venv/bin/trefle {command}')


@minicli.cli
def service():
    """Deploy/update the trefle systemd service."""
    with sudo():
        put('remote/trefle.service', '/etc/systemd/system/trefle.service')
        systemctl('enable trefle.service')


@minicli.cli
def deploy():
    """Deploy/update the trefle code base."""
    put('remote/gunicorn.conf', '/srv/trefle/gunicorn.conf')
    pip(f'install -U git+https://framagit.org/ybon/trefle@{config.version}')
    pip('install gunicorn')
    restart()


@minicli.cli
def restart():
    """Restart the systemd services."""
    with sudo():
        systemctl('restart trefle nginx')


@minicli.cli
def systemctl(*args):
    """Run a systemctl command on the remote server.

    :command: the systemctl command to run.
    """
    run(f'systemctl {" ".join(args)}')


@minicli.cli
def logs(lines=50):
    """Display the trefle logs.

    :lines: number of lines to retrieve
    """
    with sudo():
        run(f'journalctl --lines {lines} --unit trefle --follow')


@minicli.cli
def status():
    """Get the services status."""
    systemctl('status nginx trefle')


@minicli.cli
def ssh_keys(path='.ssh/authorized_keys'):
    """Install ssh keys from remote urls."""
    with sudo():
        for name, url in config.get('ssh_key_urls', {}).items():
            with urllib.request.urlopen(url) as response:
                key = response.read().decode().replace('\n', '')
            run(f'grep -q -r "{key}" {path} || echo "{key}" '
                f'| tee --append {path}')


@minicli.cli
def access_logs():
    """See the nginx access logs."""
    with sudo():
        run('tail -F /var/log/nginx/access.log')


@minicli.cli
def error_logs():
    """See the nginx error logs."""
    with sudo():
        run('tail -F /var/log/nginx/error.log')


@minicli.cli
def upload_env():
    """Upload environment vars to the server.

    Use those to deal with info not commitable.
    """
    keys = ['LBF_CHARMAP']
    content = ''
    for key in keys:
        try:
            content += '{}={}\n'.format(key, os.environ[key])
        except KeyError as e:
            sys.exit('The {} environment variable does not exist.'.format(e))
    path = '/srv/trefle/env'
    if exists(path):
        run(f'cat {path}')
    put(StringIO(content), path)


@minicli.wrap
def wrapper(hostname, configpath):
    with connect(hostname=hostname, configpath=configpath):
        yield


if __name__ == '__main__':
    minicli.run(hostname='root@51.15.221.175', configpath='remote/config.yml')
