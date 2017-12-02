# 18F Concourse deployment

This repo contains the pipeline and [BOSH](https://bosh.io) manifests for deploying [Concourse](https://concourse.ci/) tasks.

## Generating certificates

```sh
bosh interpolate certs.yml --vars-store vars.yml > certs-interpolated.yml
```
