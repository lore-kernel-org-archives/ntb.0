Return-Path: <prvs=8148ef2bb=Johannes.Thumshirn@wdc.com>
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com. [216.71.153.144])
        by gmr-mx.google.com with ESMTPS id f8si740985pfe.0.2021.07.06.03.47.37
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Jul 2021 03:47:37 -0700 (PDT)
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH] bus: Make remove callback return void
Date: Tue, 6 Jul 2021 10:47:28 +0000
Message-ID: 
 <PH0PR04MB7416BD31D84E2F63346A6F709B1B9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210706095037.1425211-1-u.kleine-koenig@pengutronix.de>
 <YOQxRS8HLTYthWNn@dell>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: Lee Jones <lee.jones@linaro.org>, =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, Geoff Levand <geoff@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "linux1394-devel@lists.sourceforge.net" <linux1394-devel@lists.sourceforge.net>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>, "industrypack-devel@lists.sourceforge.net" <industrypack-devel@lists.sourceforge.net>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>, "greybus-dev@lists.linaro.org" <greybus-dev@lists.linaro.org>, "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
List-ID: <linux-ntb.googlegroups.com>

On 06/07/2021 12:36, Lee Jones wrote:=0A=
> On Tue, 06 Jul 2021, Uwe Kleine-K=F6nig wrote:=0A=
> =0A=
>> The driver core ignores the return value of this callback because there=
=0A=
>> is only little it can do when a device disappears.=0A=
>>=0A=
>> This is the final bit of a long lasting cleanup quest where several=0A=
>> buses were converted to also return void from their remove callback.=0A=
>> Additionally some resource leaks were fixed that were caused by drivers=
=0A=
>> returning an error code in the expectation that the driver won't go=0A=
>> away.=0A=
>>=0A=
>> With struct bus_type::remove returning void it's prevented that newly=0A=
>> implemented buses return an ignored error code and so don't anticipate=
=0A=
>> wrong expectations for driver authors.=0A=
>>=0A=
>> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>=0A=
>> ---=0A=
>> Hello,=0A=
>>=0A=
>> this patch depends on "PCI: endpoint: Make struct pci_epf_driver::remove=
=0A=
>> return void" that is not yet applied, see=0A=
>> https://lore.kernel.org/r/20210223090757.57604-1-u.kleine-koenig@pengutr=
onix.de.=0A=
>>=0A=
>> I tested it using allmodconfig on amd64 and arm, but I wouldn't be=0A=
>> surprised if I still missed to convert a driver. So it would be great to=
=0A=
>> get this into next early after the merge window closes.=0A=
>>=0A=
>> I send this mail to all people that get_maintainer.pl emits for this=0A=
>> patch. I wonder how many recipents will refuse this mail because of the=
=0A=
>> long Cc: list :-)=0A=
>>=0A=
>> Best regards=0A=
>> Uwe=0A=
>>=0A=
>>  arch/arm/common/locomo.c                  | 3 +--=0A=
>>  arch/arm/common/sa1111.c                  | 4 +---=0A=
>>  arch/arm/mach-rpc/ecard.c                 | 4 +---=0A=
>>  arch/mips/sgi-ip22/ip22-gio.c             | 3 +--=0A=
>>  arch/parisc/kernel/drivers.c              | 5 ++---=0A=
>>  arch/powerpc/platforms/ps3/system-bus.c   | 3 +--=0A=
>>  arch/powerpc/platforms/pseries/ibmebus.c  | 3 +--=0A=
>>  arch/powerpc/platforms/pseries/vio.c      | 3 +--=0A=
>>  drivers/acpi/bus.c                        | 3 +--=0A=
>>  drivers/amba/bus.c                        | 4 +---=0A=
>>  drivers/base/auxiliary.c                  | 4 +---=0A=
>>  drivers/base/isa.c                        | 4 +---=0A=
>>  drivers/base/platform.c                   | 4 +---=0A=
>>  drivers/bcma/main.c                       | 6 ++----=0A=
>>  drivers/bus/sunxi-rsb.c                   | 4 +---=0A=
>>  drivers/cxl/core.c                        | 3 +--=0A=
>>  drivers/dax/bus.c                         | 4 +---=0A=
>>  drivers/dma/idxd/sysfs.c                  | 4 +---=0A=
>>  drivers/firewire/core-device.c            | 4 +---=0A=
>>  drivers/firmware/arm_scmi/bus.c           | 4 +---=0A=
>>  drivers/firmware/google/coreboot_table.c  | 4 +---=0A=
>>  drivers/fpga/dfl.c                        | 4 +---=0A=
>>  drivers/hid/hid-core.c                    | 4 +---=0A=
>>  drivers/hid/intel-ish-hid/ishtp/bus.c     | 4 +---=0A=
>>  drivers/hv/vmbus_drv.c                    | 5 +----=0A=
>>  drivers/hwtracing/intel_th/core.c         | 4 +---=0A=
>>  drivers/i2c/i2c-core-base.c               | 5 +----=0A=
>>  drivers/i3c/master.c                      | 4 +---=0A=
>>  drivers/input/gameport/gameport.c         | 3 +--=0A=
>>  drivers/input/serio/serio.c               | 3 +--=0A=
>>  drivers/ipack/ipack.c                     | 4 +---=0A=
>>  drivers/macintosh/macio_asic.c            | 4 +---=0A=
>>  drivers/mcb/mcb-core.c                    | 4 +---=0A=
=0A=
Acked-by: Johannes Thumshirn <jth@kernel.org> # for drivers/mcb=0A=
