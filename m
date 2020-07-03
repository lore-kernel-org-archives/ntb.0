Return-Path: <jasowang@redhat.com>
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com. [205.139.110.61])
        by gmr-mx.google.com with ESMTPS id y16si510669oot.2.2020.07.03.00.16.31
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jul 2020 00:16:31 -0700 (PDT)
Subject: Re: [RFC PATCH 00/22] Enhance VHOST to enable SoC-to-SoC
 communication
References: <20200702082143.25259-1-kishon@ti.com>
 <20200702055026-mutt-send-email-mst@kernel.org>
 <603970f5-3289-cd53-82a9-aa62b292c552@redhat.com>
 <14c6cad7-9361-7fa4-e1c6-715ccc7e5f6b@ti.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <59fd6a0b-8566-44b7-3dae-bb52b468219b@redhat.com>
Date: Fri, 3 Jul 2020 15:16:09 +0800
MIME-Version: 1.0
In-Reply-To: <14c6cad7-9361-7fa4-e1c6-715ccc7e5f6b@ti.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>


On 2020/7/2 下午9:35, Kishon Vijay Abraham I wrote:
> Hi Jason,
>
> On 7/2/2020 3:40 PM, Jason Wang wrote:
>> On 2020/7/2 下午5:51, Michael S. Tsirkin wrote:
>>> On Thu, Jul 02, 2020 at 01:51:21PM +0530, Kishon Vijay Abraham I wrote:
>>>> This series enhances Linux Vhost support to enable SoC-to-SoC
>>>> communication over MMIO. This series enables rpmsg communication between
>>>> two SoCs using both PCIe RC<->EP and HOST1-NTB-HOST2
>>>>
>>>> 1) Modify vhost to use standard Linux driver model
>>>> 2) Add support in vring to access virtqueue over MMIO
>>>> 3) Add vhost client driver for rpmsg
>>>> 4) Add PCIe RC driver (uses virtio) and PCIe EP driver (uses vhost) for
>>>>      rpmsg communication between two SoCs connected to each other
>>>> 5) Add NTB Virtio driver and NTB Vhost driver for rpmsg communication
>>>>      between two SoCs connected via NTB
>>>> 6) Add configfs to configure the components
>>>>
>>>> UseCase1 :
>>>>
>>>>    VHOST RPMSG                     VIRTIO RPMSG
>>>>         +                               +
>>>>         |                               |
>>>>         |                               |
>>>>         |                               |
>>>>         |                               |
>>>> +-----v------+                 +------v-------+
>>>> |   Linux    |                 |     Linux    |
>>>> |  Endpoint  |                 | Root Complex |
>>>> |            <----------------->              |
>>>> |            |                 |              |
>>>> |    SOC1    |                 |     SOC2     |
>>>> +------------+                 +--------------+
>>>>
>>>> UseCase 2:
>>>>
>>>>        VHOST RPMSG                                      VIRTIO RPMSG
>>>>             +                                                 +
>>>>             |                                                 |
>>>>             |                                                 |
>>>>             |                                                 |
>>>>             |                                                 |
>>>>      +------v------+                                   +------v------+
>>>>      |             |                                   |             |
>>>>      |    HOST1    |                                   |    HOST2    |
>>>>      |             |                                   |             |
>>>>      +------^------+                                   +------^------+
>>>>             |                                                 |
>>>>             |                                                 |
>>>> +---------------------------------------------------------------------+
>>>> |  +------v------+                                   +------v------+  |
>>>> |  |             |                                   |             |  |
>>>> |  |     EP      |                                   |     EP      |  |
>>>> |  | CONTROLLER1 |                                   | CONTROLLER2 |  |
>>>> |  |             <----------------------------------->             |  |
>>>> |  |             |                                   |             |  |
>>>> |  |             |                                   |             |  |
>>>> |  |             |  SoC With Multiple EP Instances   |             |  |
>>>> |  |             |  (Configured using NTB Function)  |             |  |
>>>> |  +-------------+                                   +-------------+  |
>>>> +---------------------------------------------------------------------+
>>>>
>>>> Software Layering:
>>>>
>>>> The high-level SW layering should look something like below. This series
>>>> adds support only for RPMSG VHOST, however something similar should be
>>>> done for net and scsi. With that any vhost device (PCI, NTB, Platform
>>>> device, user) can use any of the vhost client driver.
>>>>
>>>>
>>>>       +----------------+  +-----------+  +------------+  +----------+
>>>>       |  RPMSG VHOST   |  | NET VHOST |  | SCSI VHOST |  |    X     |
>>>>       +-------^--------+  +-----^-----+  +-----^------+  +----^-----+
>>>>               |                 |              |              |
>>>>               |                 |              |              |
>>>>               |                 |              |              |
>>>> +-----------v-----------------v--------------v--------------v----------+
>>>> |                            VHOST CORE                                |
>>>> +--------^---------------^--------------------^------------------^-----+
>>>>            |               |                    |                  |
>>>>            |               |                    |                  |
>>>>            |               |                    |                  |
>>>> +--------v-------+  +----v------+  +----------v----------+  +----v-----+
>>>> |  PCI EPF VHOST |  | NTB VHOST |  |PLATFORM DEVICE VHOST|  |    X     |
>>>> +----------------+  +-----------+  +---------------------+  +----------+
>>>>
>>>> This was initially proposed here [1]
>>>>
>>>> [1] -> https://lore.kernel.org/r/2cf00ec4-1ed6-f66e-6897-006d1a5b6390@ti.com
>>> I find this very interesting. A huge patchset so will take a bit
>>> to review, but I certainly plan to do that. Thanks!
>>
>> Yes, it would be better if there's a git branch for us to have a look.
> I've pushed the branch
> https://github.com/kishon/linux-wip.git vhost_rpmsg_pci_ntb_rfc


Thanks


>> Btw, I'm not sure I get the big picture, but I vaguely feel some of the work is
>> duplicated with vDPA (e.g the epf transport or vhost bus).
> This is about connecting two different HW systems both running Linux and
> doesn't necessarily involve virtualization.


Right, this is something similar to VOP 
(Documentation/misc-devices/mic/mic_overview.rst). The different is the 
hardware I guess and VOP use userspace application to implement the device.


>   So there is no guest or host as in
> virtualization but two entirely different systems connected via PCIe cable, one
> acting as guest and one as host. So one system will provide virtio
> functionality reserving memory for virtqueues and the other provides vhost
> functionality providing a way to access the virtqueues in virtio memory. One is
> source and the other is sink and there is no intermediate entity. (vhost was
> probably intermediate entity in virtualization?)


(Not a native English speaker) but "vhost" could introduce some 
confusion for me since it was use for implementing virtio backend for 
userspace drivers. I guess "vringh" could be better.


>
>> Have you considered to implement these through vDPA?
> IIUC vDPA only provides an interface to userspace and an in-kernel rpmsg driver
> or vhost net driver is not provided.
>
> The HW connection looks something like https://pasteboard.co/JfMVVHC.jpg
> (usecase2 above),


I see.


>   all the boards run Linux. The middle board provides NTB
> functionality and board on either side provides virtio/vhost functionality and
> transfer data using rpmsg.


So I wonder whether it's worthwhile for a new bus. Can we use the 
existed virtio-bus/drivers? It might work as, except for the epf 
transport, we can introduce a epf "vhost" transport driver.

It will have virtqueues but only used for the communication between 
itself and uppter virtio driver. And it will have vringh queues which 
will be probe by virtio epf transport drivers. And it needs to do 
datacopy between virtqueue and vringh queues.

It works like:

virtio drivers <- virtqueue/virtio-bus -> epf vhost drivers <- vringh 
queue/epf>

The advantages is that there's no need for writing new buses and drivers.

Does this make sense?

Thanks


>
> Thanks
> Kishon
>
>> Thanks
>>
>>
>>>> Kishon Vijay Abraham I (22):
>>>>     vhost: Make _feature_ bits a property of vhost device
>>>>     vhost: Introduce standard Linux driver model in VHOST
>>>>     vhost: Add ops for the VHOST driver to configure VHOST device
>>>>     vringh: Add helpers to access vring in MMIO
>>>>     vhost: Add MMIO helpers for operations on vhost virtqueue
>>>>     vhost: Introduce configfs entry for configuring VHOST
>>>>     virtio_pci: Use request_threaded_irq() instead of request_irq()
>>>>     rpmsg: virtio_rpmsg_bus: Disable receive virtqueue callback when
>>>>       reading messages
>>>>     rpmsg: Introduce configfs entry for configuring rpmsg
>>>>     rpmsg: virtio_rpmsg_bus: Add Address Service Notification support
>>>>     rpmsg: virtio_rpmsg_bus: Move generic rpmsg structure to
>>>>       rpmsg_internal.h
>>>>     virtio: Add ops to allocate and free buffer
>>>>     rpmsg: virtio_rpmsg_bus: Use virtio_alloc_buffer() and
>>>>       virtio_free_buffer()
>>>>     rpmsg: Add VHOST based remote processor messaging bus
>>>>     samples/rpmsg: Setup delayed work to send message
>>>>     samples/rpmsg: Wait for address to be bound to rpdev for sending
>>>>       message
>>>>     rpmsg.txt: Add Documentation to configure rpmsg using configfs
>>>>     virtio_pci: Add VIRTIO driver for VHOST on Configurable PCIe Endpoint
>>>>       device
>>>>     PCI: endpoint: Add EP function driver to provide VHOST interface
>>>>     NTB: Add a new NTB client driver to implement VIRTIO functionality
>>>>     NTB: Add a new NTB client driver to implement VHOST functionality
>>>>     NTB: Describe the ntb_virtio and ntb_vhost client in the documentation
>>>>
>>>>    Documentation/driver-api/ntb.rst              |   11 +
>>>>    Documentation/rpmsg.txt                       |   56 +
>>>>    drivers/ntb/Kconfig                           |   18 +
>>>>    drivers/ntb/Makefile                          |    2 +
>>>>    drivers/ntb/ntb_vhost.c                       |  776 +++++++++++
>>>>    drivers/ntb/ntb_virtio.c                      |  853 ++++++++++++
>>>>    drivers/ntb/ntb_virtio.h                      |   56 +
>>>>    drivers/pci/endpoint/functions/Kconfig        |   11 +
>>>>    drivers/pci/endpoint/functions/Makefile       |    1 +
>>>>    .../pci/endpoint/functions/pci-epf-vhost.c    | 1144 ++++++++++++++++
>>>>    drivers/rpmsg/Kconfig                         |   10 +
>>>>    drivers/rpmsg/Makefile                        |    3 +-
>>>>    drivers/rpmsg/rpmsg_cfs.c                     |  394 ++++++
>>>>    drivers/rpmsg/rpmsg_core.c                    |    7 +
>>>>    drivers/rpmsg/rpmsg_internal.h                |  136 ++
>>>>    drivers/rpmsg/vhost_rpmsg_bus.c               | 1151 +++++++++++++++++
>>>>    drivers/rpmsg/virtio_rpmsg_bus.c              |  184 ++-
>>>>    drivers/vhost/Kconfig                         |    1 +
>>>>    drivers/vhost/Makefile                        |    2 +-
>>>>    drivers/vhost/net.c                           |   10 +-
>>>>    drivers/vhost/scsi.c                          |   24 +-
>>>>    drivers/vhost/test.c                          |   17 +-
>>>>    drivers/vhost/vdpa.c                          |    2 +-
>>>>    drivers/vhost/vhost.c                         |  730 ++++++++++-
>>>>    drivers/vhost/vhost_cfs.c                     |  341 +++++
>>>>    drivers/vhost/vringh.c                        |  332 +++++
>>>>    drivers/vhost/vsock.c                         |   20 +-
>>>>    drivers/virtio/Kconfig                        |    9 +
>>>>    drivers/virtio/Makefile                       |    1 +
>>>>    drivers/virtio/virtio_pci_common.c            |   25 +-
>>>>    drivers/virtio/virtio_pci_epf.c               |  670 ++++++++++
>>>>    include/linux/mod_devicetable.h               |    6 +
>>>>    include/linux/rpmsg.h                         |    6 +
>>>>    {drivers/vhost => include/linux}/vhost.h      |  132 +-
>>>>    include/linux/virtio.h                        |    3 +
>>>>    include/linux/virtio_config.h                 |   42 +
>>>>    include/linux/vringh.h                        |   46 +
>>>>    samples/rpmsg/rpmsg_client_sample.c           |   32 +-
>>>>    tools/virtio/virtio_test.c                    |    2 +-
>>>>    39 files changed, 7083 insertions(+), 183 deletions(-)
>>>>    create mode 100644 drivers/ntb/ntb_vhost.c
>>>>    create mode 100644 drivers/ntb/ntb_virtio.c
>>>>    create mode 100644 drivers/ntb/ntb_virtio.h
>>>>    create mode 100644 drivers/pci/endpoint/functions/pci-epf-vhost.c
>>>>    create mode 100644 drivers/rpmsg/rpmsg_cfs.c
>>>>    create mode 100644 drivers/rpmsg/vhost_rpmsg_bus.c
>>>>    create mode 100644 drivers/vhost/vhost_cfs.c
>>>>    create mode 100644 drivers/virtio/virtio_pci_epf.c
>>>>    rename {drivers/vhost => include/linux}/vhost.h (66%)
>>>>
>>>> -- 
>>>> 2.17.1
>>>>

