#!/usr/bin/env /usr/bin/python3

import time
import logging
import pif
import sys
import getopt
from godaddypy import Client, Account

# https://docs.python.org/2/library/logging.html
# https://github.com/eXamadeus/godaddypy
# info : https://pypi.python.org/pypi/GoDaddyPy

def main():
    gkey = ''
    gsec = ''
    domains = ''
    try:
        opts, args = getopt.getopt(sys.argv[1:], "k:s:d:", ["gkey", "gsec", "domains"])
    except getopt.GetoptError as err:
        print (err)
        print ("usage:")
        print ('godaddy_updater.py -k <key> -s <secret> -d <domains>')
        sys.exit(2)
    for o, a in opts:
        if o in ("-k","--gkey"):
            gkey = a
        elif o in ("-s","--gsec"):
            gsec = a
        elif o in ("-d","--domains"):
            domains = a
            print(domains)
        else:
            assert False, "unhandled option"
            sys.exit(2)

    dom=domains.split(',')
    my_acct = Account(api_key=gkey, api_secret=gsec)
    ttl=3600
    typ='A'

    logging.getLogger("requests").setLevel(logging.WARNING)
    logging.getLogger("urllib3").setLevel(logging.WARNING)
    client = Client(my_acct)
    s = client.get_domains()
#    print ('domains: '+str(s))
    public_ip = pif.get_public_ip()
#    print(public_ip)
    for t in dom:
        update_ip = 'unset'
        s=str(t)
        records=client.get_records(s, record_type='A')
        print (s + ' was ' + str(records))
        if str(records) == '[]':
            update_ip = client.add_record(s,{'data':public_ip,'name':s,'ttl':ttl,'type':typ})
        else:
            try:
                update_ip = client.update_record_ip(public_ip,s,s,typ)
                update_ip = client.update_ip(public_ip,domains=[s])
            except:
                update_ip = '\x1b[0;31;40mFalse\x1b[0m'
        output1 = 'updating '+typ+' record for domain \x1b[1;33;40m'+s+'\x1b[0m to ip '+public_ip
        u=str(update_ip)
#        output2 = 'Result: '+'\x1b[0;32;40m'+u+'\x1b[0m'
        logging.basicConfig(filename='/logdir/godaddy.log',level=logging.DEBUG)
#        final_output=time.strftime("%c")+' '+output1+' '+output2
        final_output=time.strftime("%c")+' '+output1
        print(final_output)
        logging.debug(final_output)

if __name__ == "__main__":
    main()
