#!/bin/bash
echo " Running as $USER "
/opt/mqm/bin/crtmqm -q PEER1_INT400
/opt/mqm/bin/strmqm PEER1_INT400
/opt/mqm/bin/strmqcsv PEER1_INT400 & dir
/opt/mqm/bin/runmqlsr -m PEER1_INT400 -t TCP &
/opt/mqm/bin/setmqaut -m PEER1_INT400 -t qmgr -g mqm +connect +inq +dsp
/opt/mqm/bin/setmqaut -m PEER1_INT400 -n "**" -t q -g mqm +dsp
/opt/mqm/bin/setmqaut -m PEER1_INT400 -n "**" -t topic -g mqm +dsp
#echo "define channel(PEER1_INT400) chltype(sdr) conname(10.253.0.15) xmitq(INT400.LINUX.TQ) trptype(tcp)"|/opt/mqm/bin/runmqsc
echo "define channel(LINUX_INTTEST) chltype(sdr) conname(10.253.0.15) xmitq(INT400.LINUX.TQ) trptype(tcp)"|/opt/mqm/bin/runmqsc
/opt/mqm/bin/setmqaut -m PEER1_INT400 -n "**" -t channel -g mqm +dsp
/opt/mqm/bin/setmqaut -m PEER1_INT400 -n "**" -t process -g mqm +dsp
/opt/mqm/bin/setmqaut -m PEER1_INT400 -n "**" -t namelist -g mqm +dsp
/opt/mqm/bin/setmqaut -m PEER1_INT400 -n "**" -t authinfo -g mqm +dsp
/opt/mqm/bin/setmqaut -m PEER1_INT400 -n "**" -t clntconn -g mqm +dsp
/opt/mqm/bin/setmqaut -m PEER1_INT400 -n "**" -t listener -g mqm +dsp
/opt/mqm/bin/setmqaut -m PEER1_INT400 -n "**" -t service -g mqm +dsp
/opt/mqm/bin/setmqaut -m PEER1_INT400 -n "**" -t comminfo -g mqm +dsp

echo "DEFINE CHANNEL (SYSTEM.ADMIN.SVRCONN) CHLTYPE(SVRCONN) TRPTYPE(TCP)"|/opt/mqm/bin/runmqsc
/opt/mqm/bin/setmqaut -m N -n "**" -t channel -g mqm +dsp
echo "ALTER QMGR CHLAUTH(DISABLED)" |/opt/mqm/bin/runmqsc PEER1_INT400

echo "define channel (INTTEST_LINUX) chltype (RCVR) trptype (TCP)"|/opt/mqm/bin/runmqsc PEER1_INT400
#echo "define channel (INT400_PEER1) chltype (RCVR) trptype (TCP)"|/opt/mqm/bin/runmqsc PEER1_INT400

echo "start channel (PEER1_INT400)"|/opt/mqm/bin/runmqsc PEER1_INT400

echo "DEFINE QLOCAL(INT400.LINUX.TQ) DESCR('Transmission queue to test') USAGE(XMITQ)"|/opt/mqm/bin/runmqsc PEER1_INT400

echo "start channel (PEER1_INT400)"|/opt/mqm/bin/runmqsc PEER1_INT400
echo "DEFINE QLOCAL (CAT.IN)"|/opt/mqm/bin/runmqsc PEER1_INT400

echo "DEFINE QREMOTE(IPSCNC.OUT) RNAME(IPSCNC.IN) RQMNAME(INTTEST) XMITQ(INT400.PEER1.TQ)"|/opt/mqm/bin/runmqsc PEER1_INT400

echo "DEFINE QREMOTE(IPSQ.OUT) RNAME(IPSQ.IN) RQMNAME(INTTEST) XMITQ(INT400.PEER1.TQ)"|/opt/mqm/bin/runmqsc PEER1_INT400

echo "DEFINE QREMOTE(REDPROD.OUT) RNAME(REDPROD.IN) RQMNAME(INTTEST) XMITQ(INT400.PEER1.TQ)"|/opt/mqm/bin/runmqsc PEER1_INT400

echo "DEFINE QREMOTE(TEST.OUT) RNAME(TEST.IN) RQMNAME(INTTEST) XMITQ(INT400.LINUX.TQ)"|/opt/mqm/bin/runmqsc PEER1_INT400
echo "DEFINE QREMOTE(WAT.ORDEBK.OUT) RNAME(WAT.ORDEBK.IN) RQMNAME(INTTEST) XMITQ(INT400.LINUX.TQ)"|/opt/mqm/bin/runmqsc PEER1_INT400

echo "DEFINE QLOCAL (PRICE.IN)"|/opt/mqm/bin/runmqsc PEER1_INT400
echo "DEFINE QLOCAL (STOCK.IN)"|/opt/mqm/bin/runmqsc PEER1_INT400
