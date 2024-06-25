

The Nginx Ingress Controller has been installed.

Create a new *Ingress* resource called `world` for domain name `world.universe.mine`. The domain points to the K8s Node IP via `/etc/hosts`.

The *Ingress* resource should have two routes pointing to the existing *Services*:

`http://world.universe.mine:30080/europe/`

and

`http://world.universe.mine:30080/asia/`

<br>




<br>
<details><summary>Explanation</summary>
<br>

Check the NodePort *Service* for the Nginx Ingress Controller to see the ports

```plain
k -n ingress-nginx get svc ingress-nginx-controller
```

<br>

We can reach the NodePort *Service* via the K8s Node IP:

<br>

```plain
curl http://172.30.1.2:30080
```

<br>

And because of the entry in `/etc/hosts` we can call

<br>

```plain
curl http://world.universe.mine:30080
```

</details>
