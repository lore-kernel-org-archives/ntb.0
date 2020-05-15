Return-Path: <robherring2@gmail.com>
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com. [209.85.210.67])
        by gmr-mx.google.com with ESMTPS id w8si57594pjr.0.2020.05.14.19.38.53
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 19:38:54 -0700 (PDT)
Received: by mail-ot1-f67.google.com with SMTP id d26so765148otc.7
        for <linux-ntb@googlegroups.com>; Thu, 14 May 2020 19:38:53 -0700 (PDT)
Return-Path: <robherring2@gmail.com>
Date: Thu, 14 May 2020 21:38:50 -0500
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 01/19] dt-bindings: PCI: Endpoint: Add DT bindings for
 PCI EPF NTB Device
Message-ID: <20200515023850.GA10278@bogus>
References: <20200514145927.17555-1-kishon@ti.com>
 <20200514145927.17555-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514145927.17555-2-kishon@ti.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-ntb@googlegroups.com, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Allen Hubbe <allenbh@gmail.com>, Tom Joseph <tjoseph@cadence.com>, Dave Jiang <dave.jiang@intel.com>, Jon Mason <jdmason@kudzu.us>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-ID: <linux-ntb.googlegroups.com>

On Thu, 14 May 2020 20:29:09 +0530, Kishon Vijay Abraham I wrote:
> Add device tree schema for PCI endpoint function bus to which
> endpoint function devices should be attached. Then add device tree
> schema for PCI endpoint function device to include bindings thats
> generic to all endpoint functions. Finally add device tree schema
> for PCI endpoint NTB function device by including the generic
> device tree schema for PCIe endpoint function.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../bindings/pci/endpoint/pci-epf-bus.yaml    | 42 +++++++++++
>  .../bindings/pci/endpoint/pci-epf-device.yaml | 69 +++++++++++++++++++
>  .../bindings/pci/endpoint/pci-epf-ntb.yaml    | 68 ++++++++++++++++++
>  3 files changed, 179 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/endpoint/pci-epf-bus.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/endpoint/pci-epf-device.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/endpoint/pci-epf-ntb.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Traceback (most recent call last):
  File "/usr/local/bin/dt-doc-validate", line 64, in <module>
    ret = check_doc(args.yamldt)
  File "/usr/local/bin/dt-doc-validate", line 25, in check_doc
    testtree = dtschema.load(filename, line_number=line_number, duplicate_keys=False)
  File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 592, in load
    return yaml.load(f.read())
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/main.py", line 343, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 113, in get_single_data
    return self.construct_document(node)
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 123, in construct_document
    for _dummy in generator:
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 723, in construct_yaml_map
    value = self.construct_mapping(node)
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 440, in construct_mapping
    return BaseConstructor.construct_mapping(self, node, deep=deep)
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 257, in construct_mapping
    if self.check_mapping_key(node, key_node, mapping, key, value):
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 295, in check_mapping_key
    raise DuplicateKeyError(*args)
ruamel.yaml.constructor.DuplicateKeyError: while constructing a mapping
  in "<unicode string>", line 5, column 1
found duplicate key "properties" with value "{}" (original value: "{}")
  in "<unicode string>", line 17, column 1

To suppress this check see:
    http://yaml.readthedocs.io/en/latest/api.html#duplicate-keys

Duplicate keys will become an error in future releases, and are errors
by default when using the new API.

Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/pci/endpoint/pci-epf-device.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/pci/endpoint/pci-epf-device.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
Documentation/devicetree/bindings/pci/endpoint/pci-epf-ntb.yaml: while constructing a mapping
  in "<unicode string>", line 5, column 1
found duplicate key "properties" with value "{}" (original value: "{}")
  in "<unicode string>", line 17, column 1

To suppress this check see:
    http://yaml.readthedocs.io/en/latest/api.html#duplicate-keys

Duplicate keys will become an error in future releases, and are errors
by default when using the new API.

Traceback (most recent call last):
  File "/usr/local/bin/dt-mk-schema", line 34, in <module>
    schemas = dtschema.process_schemas(args.schemas, core_schema=(not args.useronly))
  File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 554, in process_schemas
    sch = process_schema(os.path.abspath(filename))
  File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 507, in process_schema
    schema = load_schema(filename)
  File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 123, in load_schema
    return do_load(os.path.join(schema_basedir, schema))
  File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 108, in do_load
    return yaml.load(tmp)
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/main.py", line 343, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 113, in get_single_data
    return self.construct_document(node)
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 123, in construct_document
    for _dummy in generator:
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 723, in construct_yaml_map
    value = self.construct_mapping(node)
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 440, in construct_mapping
    return BaseConstructor.construct_mapping(self, node, deep=deep)
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 257, in construct_mapping
    if self.check_mapping_key(node, key_node, mapping, key, value):
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 295, in check_mapping_key
    raise DuplicateKeyError(*args)
ruamel.yaml.constructor.DuplicateKeyError: while constructing a mapping
  in "<unicode string>", line 5, column 1
found duplicate key "properties" with value "{}" (original value: "{}")
  in "<unicode string>", line 17, column 1

To suppress this check see:
    http://yaml.readthedocs.io/en/latest/api.html#duplicate-keys

Duplicate keys will become an error in future releases, and are errors
by default when using the new API.

Documentation/devicetree/bindings/Makefile:41: recipe for target 'Documentation/devicetree/bindings/processed-schema-examples.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/processed-schema-examples.yaml] Error 123
make[1]: *** Deleting file 'Documentation/devicetree/bindings/processed-schema-examples.yaml'
Traceback (most recent call last):
  File "/usr/local/bin/dt-mk-schema", line 34, in <module>
    schemas = dtschema.process_schemas(args.schemas, core_schema=(not args.useronly))
  File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 554, in process_schemas
    sch = process_schema(os.path.abspath(filename))
  File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 507, in process_schema
    schema = load_schema(filename)
  File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 123, in load_schema
    return do_load(os.path.join(schema_basedir, schema))
  File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 108, in do_load
    return yaml.load(tmp)
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/main.py", line 343, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 113, in get_single_data
    return self.construct_document(node)
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 123, in construct_document
    for _dummy in generator:
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 723, in construct_yaml_map
    value = self.construct_mapping(node)
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 440, in construct_mapping
    return BaseConstructor.construct_mapping(self, node, deep=deep)
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 257, in construct_mapping
    if self.check_mapping_key(node, key_node, mapping, key, value):
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 295, in check_mapping_key
    raise DuplicateKeyError(*args)
ruamel.yaml.constructor.DuplicateKeyError: while constructing a mapping
  in "<unicode string>", line 5, column 1
found duplicate key "properties" with value "{}" (original value: "{}")
  in "<unicode string>", line 17, column 1

To suppress this check see:
    http://yaml.readthedocs.io/en/latest/api.html#duplicate-keys

Duplicate keys will become an error in future releases, and are errors
by default when using the new API.

Documentation/devicetree/bindings/Makefile:45: recipe for target 'Documentation/devicetree/bindings/processed-schema.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/processed-schema.yaml] Error 123
make[1]: *** Deleting file 'Documentation/devicetree/bindings/processed-schema.yaml'
Makefile:1300: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1290443

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

