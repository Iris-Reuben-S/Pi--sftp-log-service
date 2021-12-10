# installer via 'make'
# \author R Sweetman

install:
	@echo Target install
	install -m 0755 -T log-service.sh /usr/local/bin/log-service
	install -m 0755 -T parse-log.py /usr/local/bin/parse-log.py
	install -D -m 0644 log-service.service --target-directory /usr/local/lib/systemd/system
	install -D -m 0644 log-service.timer --target-directory /usr/local/lib/systemd/system
	systemctl daemon-reload
	systemctl enable log-service.timer
	systemctl start log-service.timer	
uninstall:
	@echo Target: uninstall
	rm -f /usr/local/bin/log-service.sh
	rm -f /usr/local/bin/parse-log.py
	systemctl stop log-service.timer
	systemctl disable log-service.timer
	rm -f /usr/local/lib/systemd/system/log-service.timer
	systemctl stop log-service.service
	systemctl disable log-service.service
	rm -f /usr/local/lib/systemd/log-service.service

default: install
