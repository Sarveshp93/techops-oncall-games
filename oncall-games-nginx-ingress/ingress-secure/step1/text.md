
Make sure to have solved the previous Scenario [Ingress Create](https://killercoda.com/sarvesh-oncall-games/course/scenarios-nginx-ingress/ingress-create).

The Nginx Ingress Controller has been installed and an *Ingress* resource configured in *Namespace* `world`.

You can reach the application using 

`curl http://world.universe.mine:30080/europe`

Generate a new TLS certificate using:

`openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout cert.key -out cert.crt -subj "/CN=world.universe.mine/O=world.universe.mine"`

Configure the *Ingress* to use the new certificate, so that you can call

`curl -kv https://world.universe.mine:30443/europe`

The curl verbose output should show the new certificate being used instead of the default *Ingress* one.

<br>
<details><summary>Verify</summary>
<br>

```
curl -m1 -kvI https://world.universe.mine:30443/europe 2>&1 | grep subject | grep world.universe.mine
```

</details>
