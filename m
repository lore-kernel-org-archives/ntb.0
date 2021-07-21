Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.99])
        by gmr-mx.google.com with ESMTPS id r7si2547524pjp.0.2021.07.21.03.09.45
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Jul 2021 03:09:45 -0700 (PDT)
Date: Wed, 21 Jul 2021 12:09:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 0/5] bus: Make remove callback return void
Message-ID: <YPfyZen4Y0uDKqDT@kroah.com>
References: <20210713193522.1770306-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210713193522.1770306-1-u.kleine-koenig@pengutronix.de>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: kernel@pengutronix.de, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Alexandre Bounine <alex.bou9@gmail.com>, Alex Dubov <oakad@yahoo.com>, Alex Elder <elder@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Alison Schofield <alison.schofield@intel.com>, Allen Hubbe <allenbh@gmail.com>, Andreas Noever <andreas.noever@gmail.com>, Andy Gross <agross@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ben Widawsky <ben.widawsky@intel.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Bodo Stroesser <bostroesser@gmail.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Chen-Yu Tsai <wens@csie.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Cristian Marussi <cristian.marussi@arm.com>, Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "David S. Miller" <davem@davemloft.net>, David Woodhouse <dwmw@amazon.co.uk>, Dexuan Cui <decui@microsoft.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Eric Farman <farman@linux.ibm.com>, Finn Thain <fthain@linux-m68k.org>, Florian Fainelli <f.fainelli@gmail.com>, Frank Li <lznuaa@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Geoff Levand <geoff@infradead.org>, Haiyang Zhang <haiyangz@microsoft.com>, Halil Pasic <pasic@linux.ibm.com>, Hannes Reinecke <hare@suse.de>, Hans de Goede <hdegoede@redhat.com>, Harald Freudenberger <freude@linux.ibm.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Ira Weiny <ira.weiny@intel.com>, Jakub Kicinski <kuba@kernel.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Jaroslav Kysela <perex@perex.cz>, Jason Wang <jasowang@redhat.com>, Jens Taprogge <jens.taprogge@taprogge.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Jiri Kosina <jikos@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, Joey Pabalan <jpabalanb@gmail.com>, Johan Hovold <johan@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, Johannes Thumshirn <morbidrsa@gmail.com>, Jon Mason <jdmason@kudzu.us>, Juergen Gross <jgross@suse.com>, Julien Grall <jgrall@amazon.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>, Kirti Wankhede <kwankhede@nvidia.com>, Kishon Vijay Abraham I <kishon@ti.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Lee Jones <lee.jones@linaro.org>, Len Brown <lenb@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Manohar Vanga <manohar.vanga@gmail.com>, Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>, Mark Gross <mgross@linux.intel.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Martyn Welch <martyn@welchs.me.uk>, Mathieu Poirier <mathieu.poirier@linaro.org>, Matthew Rosato <mjrosato@linux.ibm.com>, Matt Porter <mporter@kernel.crashing.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Maxime Ripard <mripard@kernel.org>, Maximilian Luz <luzmaximilian@gmail.com>, Maxim Levitsky <maximlevitsky@gmail.com>, Michael Buesch <m@bues.ch>, Michael Ellerman <mpe@ellerman.id.au>, Michael Jamet <michael.jamet@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mike Christie <michael.christie@oracle.com>, Moritz Fischer <mdf@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>, Paul Mackerras <paulus@samba.org>, Peter Oberparleiter <oberpar@linux.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Rich Felker <dalias@libc.org>, Rikard Falkeborn <rikard.falkeborn@gmail.com>, Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Samuel Holland <samuel@sholland.org>, Samuel Iglesias Gonsalvez <siglesias@igalia.com>, SeongJae Park <sjpark@amazon.de>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Stefano Stabellini <sstabellini@kernel.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Stephen Boyd <sboyd@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, Sudeep Holla <sudeep.holla@arm.com>, Sven Van Asbroeck <TheSven73@gmail.com>, Takashi Iwai <tiwai@suse.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thorsten Scherer <t.scherer@eckelmann.de>, Tomas Winkler <tomas.winkler@intel.com>, Tom Rix <trix@redhat.com>, Tyrel Datwyler <tyreld@linux.ibm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Vasily Gorbik <gor@linux.ibm.com>, Vineeth Vijayan <vneethv@linux.ibm.com>, Vinod Koul <vkoul@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, Wei Liu <wei.liu@kernel.org>, William Breathitt Gray <vilhelm.gray@gmail.com>, Wolfram Sang <wsa@kernel.org>, Wu Hao <hao.wu@intel.com>, Yehezkel Bernat <YehezkelShB@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, YueHaibing <yuehaibing@huawei.com>, Yufen Yu <yuyufen@huawei.com>, alsa-devel@alsa-project.org, dmaengine@vger.kernel.org, greybus-dev@lists.linaro.org, industrypack-devel@lists.sourceforge.net, kvm@vger.kernel.org, linux1394-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-cxl@vger.kernel.org, linux-fpga@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-i2c@vger.kernel.org, linux-i3c@lists.infradead.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org, linux-ntb@googlegroups.com, linux-parisc@vger.kernel.org, linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, linux-spi@vger.kernel.org, linux-staging@lists.linux.dev, linux-sunxi@lists.linux.dev, linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, nvdimm@lists.linux.dev, platform-driver-x86@vger.kernel.org, sparclinux@vger.kernel.org, target-devel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org
List-ID: <linux-ntb.googlegroups.com>

On Tue, Jul 13, 2021 at 09:35:17PM +0200, Uwe Kleine-K=EF=BF=BDnig wrote:
> Hello,
>=20
> this is v4 of the final patch set for my effort to make struct
> bus_type::remove return void.
>=20
> The first four patches contain cleanups that make some of these
> callbacks (more obviously) always return 0. They are acked by the
> respective maintainers. Bjorn Helgaas explicitly asked to include the
> pci patch (#1) into this series, so Greg taking this is fine. I assume
> the s390 people are fine with Greg taking patches #2 to #4, too, they
> didn't explicitly said so though.
>=20
> The last patch actually changes the prototype and so touches quite some
> drivers and has the potential to conflict with future developments, so I
> consider it beneficial to put these patches into next soon. I expect
> that it will be Greg who takes the complete series, he already confirmed
> via irc (for v2) to look into this series.
>=20
> The only change compared to v3 is in the fourth patch where I modified a
> few more drivers to fix build failures. Some of them were found by build
> bots (thanks!), some of them I found myself using a regular expression
> search. The newly modified files are:
>=20
>  arch/sparc/kernel/vio.c
>  drivers/nubus/bus.c
>  drivers/sh/superhyway/superhyway.c
>  drivers/vlynq/vlynq.c
>  drivers/zorro/zorro-driver.c
>  sound/ac97/bus.c
>=20
> Best regards
> Uwe

Now queued up.  I can go make a git tag that people can pull from after
0-day is finished testing this to verify all is good, if others need it.

thanks,

greg k-h
