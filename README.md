# OpenSSL Private CA scripts

This is a simple Makefile that implements a private CA using the OpenSSL command line tool. The CA generates wildcard certificates.

You can use this to create a private CA key pair and then sign certificates with it. If you add the CA certificate to your browser's trust store, then it will trust all the certificates you create. This is useful for doing local development and testing of HTTPS servers without obtaining a real certificate.

I wrote this because it is incredibly hard to find information on the internet on how to do this. OpenSSL's handling of extensions (needed to specify a wildcard) is confusing and documentation only seems to exist in the form of scattered incomplete guides and Stack Overflow answers.

## Usage

Just type:

    make HOSTNAME.crt

Then follow the on-screen prompts. On first run, you'll be asked to fill in certificate info for the CA. On all runs, you'll then be asked to fill in info for the certificate you are creating.

You'll end up with `HOSTNAME.key` and `HOSTNAME.crt` in PEM format, ready to load into your favorite server. You'll also get `ca.crt`, which you can add to your browser's trust store.

The certificate will be a **wildcard certificate** good for both `HOSTNAME` itself and `*.HOSTNAME`.

## Advanced usage

Each intermediate is a separate make target. If you understand make, you should be able to figure out everything from the Makefile.
