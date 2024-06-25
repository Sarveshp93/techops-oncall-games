Now that we've created a PersistentVolume and a PersistentVolumeClaim, we're ready to use the volume!

Create a pod named `pvc-user` in namespace `default` that mounts your PVC `my-claim` under `/mnt/share/my-pvc`. Use the image `nginx`.

<br>
<details><summary>Solution</summary>
<br>
This is another one where starting with an from the K8s docs and modifying it for our use case is a good strategy.

</details>
