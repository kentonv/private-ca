
help:
	@echo "usage: make HOSTNAME.crt"
	@echo "This will create HOSTNAME.key and HOSTNAME.crt."
	@echo "On first run, a file ca.crt will be created. Install this into your browser trust store."

.PHONY: help

# Don't delete intermediates.
.SECONDARY:

# Create CA.
ca.key:
	openssl genrsa -out ca.key 4096

ca.crt: ca.key
	@echo "*** Enter details for CA certificate"
	openssl req -key ca.key -new -x509 -days 36500 -sha256 -extensions v3_ca -out ca.crt

ca.srl:
	echo 1000 > ca.srl

%.key:
	openssl genrsa -out $@ 4096

%.cnf:
	echo '[ exts ]\nbasicConstraints = CA:FALSE\nkeyUsage = nonRepudiation, digitalSignature, keyEncipherment\nsubjectAltName=DNS:$(basename $@),DNS:*.$(basename $@)' > $@

%.csr: %.key
	@echo "*** Enter details for certificate for: $(basename $@)"
	openssl req -new -sha256 -key $< -out $@

%.crt: %.csr %.cnf ca.crt ca.key ca.srl
	openssl x509 -req -days 3650 -in $< -CA ca.crt -CAkey ca.key -CAserial ca.srl -out $@ -extfile $(basename $@).cnf -extensions exts

%.key.enc: %.key
	openssl rsa -aes256 -in $< -out $@

