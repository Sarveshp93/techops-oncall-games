Now that our pod has a `PersistentVolume` any data it creates under `/mnt/share/my-pvc` will persist even if the container crashes or restarts.

Go ahead and create a file named `coolfile` in the container `pvc-user` under `/mnt/share/my-pvc`.

Restart/Recreate the container

Look under `/mnt/share/my-pvc` is `coolfile` still there?