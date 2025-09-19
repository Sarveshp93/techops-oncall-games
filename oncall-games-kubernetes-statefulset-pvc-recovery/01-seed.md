Write a marker:

`kubectl -n datarec exec dataapp-0 -- sh -c 'echo STATEFUL-PERSISTENCE-OK > /data/marker.txt && sync && cat /data/marker.txt'`{{exec}}
