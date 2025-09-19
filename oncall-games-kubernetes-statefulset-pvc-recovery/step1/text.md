`echo STATEFUL-PERSISTENCE-OK > /data/marker.txt && cat /data/marker.txt` in the pod should persist to PVC.

`kubectl -n datarec exec dataapp-0 -- sh -c 'echo STATEFUL-PERSISTENCE-OK > /data/marker.txt && sync && cat /data/marker.txt'`{{exec}}
