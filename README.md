java_ext Cookbook
=================
This cookbook provides various helpers for dealing with Java in Chef.

Requirements
------------
Java cookbook - This cookbook does not `include_recipe "java"`, you should make sure java is installed.

Usage
-----

### LWRP
#### java_ext_keystore
This LWRP will generate a self-signed keypair in a keystore. The example is pretty self explanatory.

    include_recipe "java"
    java_ext_keystore "/tmp/keystore" do
      cert_alias "test-alias"
      dn "CN=avishai ish-shalom/O=fewbytes/"
      password "gargamel"
      with_certificate do |c|
        node.set["java_keys"]["my_cert"] = c
      end
    end
Attributes:
- `dn` - distinguinshed name
- `keystore_path` - name attribute, the path of the keystore file
- `mode` - file permissions mode
- `owner` - keystore file owner
- `group` - keystore file group
- `cert_alias` - certificate alias in the keystore
- `password` - keystore *and* private key password. Since the common use case is a single keystore housing a single keypair we use the same password for both.
- `java_bin_path` - directory of java binaries. defaults to _node["java"]["home_dir"]/bin_

#### java_ext_truststore_certificate
This LWRP will import a certificate into a truststore, e.g.

    java_ext_truststore_certificate "test-alias" do
      truststore_path "/tmp/truststore"
      certificate node["java_ext"]["certificate"]
      password "gargamel"
    end

Attributes:
- `certificate` - the certificate to import in pem (rfc) format
- `truststore_path` - the path of the truststore file
- `mode` - file permissions mode
- `owner` - keystore file owner
- `group` - keystore file group
- `cert_alias` - name attribute, certificate alias in the truststore
- `password` - truststore password
- `java_bin_path` - directory of java binaries. defaults to _node["java"]["home_dir"]/bin_

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Avishai Ish-Shalom
License: Apache V2
