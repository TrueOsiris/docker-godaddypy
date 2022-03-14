#!/bin/bash
# https://github.com/eXamadeus/godaddypy
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

/usr/bin/python3 godaddy_updater.py -k $godaddykey -s $godaddysecret -d $domains

