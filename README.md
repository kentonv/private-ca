# OpenSSL Private CA scripts for testing

This is a simple Makefile that implements a private CA using the OpenSSL command line tool. The CA generates wildcard certificates.

You can use this to create a private CA key pair and then sign certificates with it. If you add the CA certificate to your browser's trust store, then it will trust all the certificates you create. This is useful for doing local development and testing of HTTPS servers without obtaining a real certificate.

I wrote this because it is incredibly hard to find information on the internet on how to do this. Most guides and docs seem intended for creating a serious CA and are far too heavyweight for testing purposes. Moreover, OpenSSL's handling of extensions (needed to specify a wildcard) is confusing, with conflicting information on the internet scattered across various blog posts and Stack Overflow answers.

## Warning

**This is intended for local testing only, for developers who just need a certificate to load into a local test server with minimal work. You should not use this to run a CA in production, even privately within an organization. For production use, consider [cfssl](https://github.com/cloudflare/cfssl); see: [How to build your own public key infrastructure](https://blog.cloudflare.com/how-to-build-your-own-public-key-infrastructure/)**

## Usage

First, create your CA keypair:

    make ca.crt

This creates `ca.key` (CA private key) and `ca.crt` (CA certificate). Add `ca.crt` to your browser's trust store.

Then, you can create a certificate for a particular host by typing:

    make HOSTNAME.crt

You'll end up with `HOSTNAME.key` and `HOSTNAME.crt` in PEM format, ready to load into your favorite server. The certificate will be a **wildcard certificate** good for both `HOSTNAME` itself and `*.HOSTNAME`.

## Advanced usage

Each intermediate is a separate make target. If you understand make, you should be able to figure out everything from the Makefile.
