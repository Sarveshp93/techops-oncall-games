After reviewing the context, the task involves introducing a condition into the Horizontal Pod Autoscaler (HPA) template to meet the following requirements:

- Deploy an HPA resource for releases in the `prod` environment.
- Do not deploy an HPA resource for releases in any other environment

Deploy a `mock-app-prod` release in `prod-ns` namespace and a `mock-app-dev` release in `dev-ns` to check the solution.

**NOTE: The chart is packaged and stored in /charts/mock-app folder**

<br>
<details><summary>Tip</summary>
<br>

You can use the value "environment" as the parameter for the condition.
The environment parameter will be provided during the installation of the release.


</details>
