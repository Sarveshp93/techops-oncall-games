

There are two existing *Deployments* in *Namespace* `world` which should be made accessible via an *Ingress*.

First: create ClusterIP *Services* for both *Deployments* for port `80`. The *Services* should have the same name as the *Deployments*.



<br>
<details><summary>Tip</summary>
<br>

```plain
k expose deploy -h
```

</details>
