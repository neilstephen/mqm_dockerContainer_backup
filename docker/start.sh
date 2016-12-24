#!/bin/bash
#
#git clone https://dev_team_ws@bitbucket.org/waterstones/ifs-bridge.git /var/ifsmq
/sbin/sysctl -p
echo 'Updated Semaphores and Limits'
su mqm -c "/opt/mqm/bin/mqconfig"
chmod 744 /home/mqm/waterstones_MQSchannel_setup.sh
#su mqm -c "/bin/bash -x /home/mqm/test_waterstones_MQSchannel_setup.sh" # mqm test version
su mqm -c "/bin/bash -x /home/mqm/live_waterstones_MQSchannel_setup.sh"
