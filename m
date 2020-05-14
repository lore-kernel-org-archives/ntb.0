Return-Path: <kishon@ti.com>
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com. [198.47.23.248])
        by gmr-mx.google.com with ESMTPS id 132si254169vkb.1.2020.05.14.07.59.56
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2020 07:59:56 -0700 (PDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 00/19] Implement NTB Controller using multiple PCI EP
Date: Thu, 14 May 2020 20:29:08 +0530
Message-ID: <20200514145927.17555-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Tom Joseph <tjoseph@cadence.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-ntb@googlegroups.com, Kishon Vijay Abraham I <kishon@ti.com>
List-ID: <linux-ntb.googlegroups.com>

This series is about implementing SW defined NTB using
multiple endpoint instances. This series has been tested using
2 endpoint instances in J7 connected to two DRA7 boards. However there
is nothing platform specific for the NTB functionality.

This was presented in Linux Plumbers Conference. The presentation
can be found @ [1]

RFC patch series can be found @ [2]

This series has been validated after applying [3] and [4]

Changes from RFC:
1) Converted the DT binding patches to YAML schema and merged the
   DT binding patches together
2) NTB documentation is converted to .rst
3) One HOST can now interrupt the other HOST using MSI-X interrupts
4) Added support for teardown of memory window and doorbell
   configuration
5) Add support to provide support 64-bit memory window size from
   DT

[1] -> https://www.linuxplumbersconf.org/event/4/contributions/395/attachments/284/481/Implementing_NTB_Controller_Using_PCIe_Endpoint_-_final.pdf
[2] -> http://lore.kernel.org/r/20190926112933.8922-1-kishon@ti.com
[3] -> http://lore.kernel.org/r/20200508130646.23939-1-kishon@ti.com
[4] -> http://lore.kernel.org/r/20200506151429.12255-1-kishon@ti.com

Kishon Vijay Abraham I (19):
  dt-bindings: PCI: Endpoint: Add DT bindings for PCI EPF NTB Device
  Documentation: PCI: Add specification for the *PCI NTB* function
    device
  PCI: endpoint: Add API to get reference to EPC from device-tree
  PCI: endpoint: Add API to create EPF device from device tree
  PCI: endpoint: Add "pci-epf-bus" driver
  PCI: endpoint: Make *_get_first_free_bar() take into account 64 bit
    BAR
  PCI: endpoint: Add helper API to get the 'next' unreserved BAR
  PCI: endpoint: Make *_free_bar() to return error codes on failure
  PCI: endpoint: Remove unused pci_epf_match_device()
  PCI: endpoint: Make pci_epf_driver ops optional
  PCI: endpoint: Add helper API to populate header with values from DT
  PCI: endpoint: Add support to associate secondary EPC with EPF
  PCI: endpoint: Add pci_epc_ops to map MSI irq
  PCI: cadence: Implement ->msi_map_irq() ops
  PCI: endpoint: Add EP function driver to provide NTB functionality
  PCI: Add TI J721E device to pci ids
  NTB: Add support for EPF PCI-Express Non-Transparent Bridge
  NTB: tool: Enable the NTB/PCIe link on the local or remote side of
    bridge
  NTB: ntb_perf/ntb_tool: Use PCI device for dma_alloc_coherent()

 Documentation/PCI/endpoint/index.rst          |    1 +
 Documentation/PCI/endpoint/pci-test-ntb.rst   |  344 +++
 .../bindings/pci/endpoint/pci-epf-bus.yaml    |   42 +
 .../bindings/pci/endpoint/pci-epf-device.yaml |   69 +
 .../bindings/pci/endpoint/pci-epf-ntb.yaml    |   68 +
 drivers/misc/pci_endpoint_test.c              |    1 -
 drivers/ntb/hw/Kconfig                        |    1 +
 drivers/ntb/hw/Makefile                       |    1 +
 drivers/ntb/hw/epf/Kconfig                    |    5 +
 drivers/ntb/hw/epf/Makefile                   |    1 +
 drivers/ntb/hw/epf/ntb_hw_epf.c               |  752 ++++++
 drivers/ntb/test/ntb_perf.c                   |    3 +-
 drivers/ntb/test/ntb_tool.c                   |    4 +-
 .../pci/controller/cadence/pcie-cadence-ep.c  |   50 +
 drivers/pci/endpoint/Makefile                 |    3 +-
 drivers/pci/endpoint/functions/Kconfig        |   12 +
 drivers/pci/endpoint/functions/Makefile       |    1 +
 drivers/pci/endpoint/functions/pci-epf-ntb.c  | 2038 +++++++++++++++++
 drivers/pci/endpoint/functions/pci-epf-test.c |   13 +-
 drivers/pci/endpoint/pci-ep-cfs.c             |    6 +-
 drivers/pci/endpoint/pci-epc-core.c           |  216 +-
 drivers/pci/endpoint/pci-epf-bus.c            |   54 +
 drivers/pci/endpoint/pci-epf-core.c           |  137 +-
 include/linux/pci-epc.h                       |   43 +-
 include/linux/pci-epf.h                       |   26 +-
 include/linux/pci_ids.h                       |    1 +
 26 files changed, 3823 insertions(+), 69 deletions(-)
 create mode 100644 Documentation/PCI/endpoint/pci-test-ntb.rst
 create mode 100644 Documentation/devicetree/bindings/pci/endpoint/pci-epf-bus.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/endpoint/pci-epf-device.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/endpoint/pci-epf-ntb.yaml
 create mode 100644 drivers/ntb/hw/epf/Kconfig
 create mode 100644 drivers/ntb/hw/epf/Makefile
 create mode 100644 drivers/ntb/hw/epf/ntb_hw_epf.c
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-ntb.c
 create mode 100644 drivers/pci/endpoint/pci-epf-bus.c

-- 
2.17.1

