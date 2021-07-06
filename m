Return-Path: <geoff@infradead.org>
Received: from desiato.infradead.org (desiato.infradead.org. [2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by gmr-mx.google.com with ESMTPS id j63si161399wmj.2.2021.07.06.07.52.39
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 07:52:39 -0700 (PDT)
Subject: Re: [PATCH] bus: Make remove callback return void
References: <20210706095037.1425211-1-u.kleine-koenig@pengutronix.de>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <7a68b536-302c-0374-848f-4b9535ff1306@infradead.org>
Date: Tue, 6 Jul 2021 07:51:36 -0700
MIME-Version: 1.0
In-Reply-To: <20210706095037.1425211-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, William Breathitt Gray <vilhelm.gray@gmail.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Ben Widawsky <ben.widawsky@intel.com>, Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi <cristian.marussi@arm.com>, Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Wolfram Sang <wsa@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Iglesias Gonsalvez <siglesias@igalia.com>, Jens Taprogge <jens.taprogge@taprogge.org>, Johannes Thumshirn <morbidrsa@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, Ulf Hansson <ulf.hansson@linaro.org>, Lee Jones <lee.jones@linaro.org>, Tomas Winkler <tomas.winkler@intel.com>, Arnd Bergmann <arnd@arndb.de>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Mark Gross <mgross@linux.intel.com>, Matt Porter <mporter@kernel.crashing.org>, Alexandre Bounine <alex.bou9@gmail.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, Thorsten Scherer <t.scherer@eckelmann.de>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Andy Gross <agross@kernel.org>, Mark Brown <broonie@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Michael Buesch <m@bues.ch>, Sven Van Asbroeck <TheSven73@gmail.com>, Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, Andreas Noever <andreas.noever@gmail.com>, Michael Jamet <michael.jamet@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Yehezkel Bernat <YehezkelShB@gmail.com>, Rob Herring <robh@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Martyn Welch <martyn@welchs.me.uk>, Manohar Vanga <manohar.vanga@gmail.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Marc Zyngier <maz@kernel.org>, Tyrel Datwyler <tyreld@linux.ibm.com>, Vladimir Zapolskiy <vz@mleia.com>, Samuel Holland <samuel@sholland.org>, Qinglang Miao <miaoqinglang@huawei.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Kai-Heng Feng <kai.heng.feng@canonical.com>, Joey Pabalan <jpabalanb@gmail.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Frank Li <lznuaa@gmail.com>, Mike Christie <michael.christie@oracle.com>, Bodo Stroesser <bostroesser@gmail.com>, Hannes Reinecke <hare@suse.de>, David Woodhouse <dwmw@amazon.co.uk>, SeongJae Park <sjpark@amazon.de>, Julien Grall <jgrall@amazon.com>, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-wireless@vger.kernel.org, linux-sunxi@lists.linux.dev, linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev, dmaengine@vger.kernel.org, linux1394-devel@lists.sourceforge.net, linux-fpga@vger.kernel.org, linux-input@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-i2c@vger.kernel.org, linux-i3c@lists.infradead.org, industrypack-devel@lists.sourceforge.net, linux-media@vger.kernel.org, linux-mmc@vger.kernel.org, netdev@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-scsi@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, linux-staging@lists.linux.dev, greybus-dev@lists.linaro.org, target-devel@vger.kernel.org, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org
List-ID: <linux-ntb.googlegroups.com>

On 7/6/21 2:50 AM, Uwe Kleine-König wrote:

> --- a/arch/powerpc/platforms/ps3/system-bus.c
> +++ b/arch/powerpc/platforms/ps3/system-bus.c
> @@ -381,7 +381,7 @@ static int ps3_system_bus_probe(struct device *_dev)
>  	return result;
>  }
>  
> -static int ps3_system_bus_remove(struct device *_dev)
> +static void ps3_system_bus_remove(struct device *_dev)
>  {
>  	struct ps3_system_bus_device *dev = ps3_dev_to_system_bus_dev(_dev);
>  	struct ps3_system_bus_driver *drv;
> @@ -399,7 +399,6 @@ static int ps3_system_bus_remove(struct device *_dev)
>  			__func__, __LINE__, drv->core.name);
>  
>  	pr_debug(" <- %s:%d: %s\n", __func__, __LINE__, dev_name(&dev->core));
> -	return 0;
>  }

PS3 part looks fine.

Acked-by: Geoff Levand <geoff@infradead.org>
