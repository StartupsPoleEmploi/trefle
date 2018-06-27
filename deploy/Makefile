lines ?= 50

install:
	ansible-playbook -vv --diff install.yml

upgrade:
	ansible-playbook -vv --diff --limit=trefle --tags=trefle install.yml

restart:
	ansible proxy -b -a "systemctl restart nginx"
	ansible app -b -a "systemctl restart trefle"

access-logs:
	ansible proxy -b -a "tail -$(lines) /var/log/nginx/access.log"

error-logs:
	ansible proxy -b -a "tail -$(lines) /var/log/nginx/error.log"

app-logs:
	ansible proxy -b -a "journalctl --lines $(lines) --unit trefle"

simulate-logs:
	ansible proxy -b -a "tail -$(lines) /srv/trefle/logs/trefle-simulate.log"

status:
	ansible proxy -b -a "systemctl status nginx"
	ansible app -b -a "systemctl status trefle"
