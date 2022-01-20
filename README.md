# 18F Concourse deployment

This repo contains the pipeline and [BOSH](https://bosh.io) manifests for deploying [Concourse](https://concourse-ci.org/) tasks.

## Generating certificates

* Generate certificates using bosh `variables`

    ```sh
    bosh interpolate certs.yml --vars-store vars.yml > certs-interpolated.yml
    ```

* Merge credentials into existing secrets

    ```sh
    spruce merge secrets.yml certs-interpolated.yml > secrets-complete.yml
    ```
