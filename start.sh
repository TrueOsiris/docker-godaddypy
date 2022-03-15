#!/bin/bash
# https://github.com/eXamadeus/godaddypy
/usr/bin/touch /var/log/cron.log
/usr/bin/chmod 777 /var/log/cron.log
godaddykey_varname="GODADDY_KEY"
godaddykey=${!godaddykey_varname}
if [ -z ${godaddykey} ]; then
        echo "$godaddykey_varname is unset. exiting"
        exit 0
else
        echo "$godaddykey_varname = $godaddykey"
fi
godaddysecret_varname="GODADDY_SECRET"
godaddysecret=${!godaddysecret_varname}
if [ -z ${godaddysecret} ]; then
        echo "$godaddysecret_varname is unset. exiting"
        exit 0
else
        echo "$godaddysecret_varname = *******************."
fi
domains_varname="DOMAINS"
domains=${!domains_varname}
if [ -z ${domains} ]; then
	echo "$domains_varname is unset. exiting"
	exit 0
else
	echo "domains = $domains"
fi

if [ ! -d "/logdir" ]; then
	mkdir /logdir
fi
if [ ! -f /logdir/godaddy.log ];then
	echo "startlog" > "/logdir/godaddy.log"
fi
if [ "$1" == "update" ]; then
        rm -R godaddypy 2>/dev/null
        rm -R pygodaddy 2>/dev/null
fi
if [ ! -d godaddypy ]; then
	git clone https://github.com/eXamadeus/godaddypy
	cd godaddypy
	python3 setup.py install
	cd ..
fi
echo " "
echo "godaddypy logs will arrive in /logdir"
echo " "
echo "*/5 * * * * /usr/bin/python3 /godaddy_updater.py -k $godaddykey -s $godaddysecret -d $domains > /var/log/cron.log 2>/var/log/cron.log" > /etc/cron.d/godaddy-cron
echo "30 * * * * /usr/sbin/logrotate /etc/logrotate.d/godaddypy" >> /etc/cron.d/godaddy-cron
echo " " >> /etc/cron.d/godaddy-cron
echo $'/logdir/*.log {\n  rotate 7\n  daily\n  missingok\n  notifempty\n  create\n}' > /etc/logrotate.d/godaddypy
/usr/bin/crontab /etc/cron.d/godaddy-cron
#/usr/sbin/cron -f
#/usr/bin/tail -f /var/log/cron.log

