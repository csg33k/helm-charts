## Helm Charts


Helm chart are published as to an OCI. 

To install:

Get the values file and update it according to you preferences
```sh
helm show values oci://ghcr.io/csg33k/tandoor --version 0.0.1 > myvalues.yaml 
```

```sh
helm install recipe-manager -n food oci://ghcr.io/csg33k/tandoor --version 0.0.1 -f myvalues.yaml 
```
