Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC7B3C13;
	Fri, 19 Aug 2022 15:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=24MYTNmWKwuz612F53s8OGxxNoOr440y1r636RmtOyM=; b=p/vghahIi+rGsJOOBcIrm0yvFt
	0YajqQ0rLEYEnvp2xZHIGxLITHzgOXXEv4M41MX318pD2xLf6gcLiQNI09vS6bl60rwA2GWTjaCQv
	mxLM0ELFbzpxaMzJrb/xq0jOEuym4AOaZVkU3/CJnmE5ZwD8OhMDokLssZhE6l8fD8W61/qAvfDfS
	M6u4mrQh7+6QBfnjdHEB1sbLlPEGx9kkwjr0UDMvfCYbuc2drfea8G4keCpflasM8TCCm6QZTYQYv
	AlZxuTfljpn7GdTINGFYyc+NLCc0rFeua3I+6v+zIHZYya8ZcmJxLSXVRvpYUM4Js1B21+nTRCTGD
	cnR0C4pg==;
Received: from [2600:1702:3c30:6ca0:77cd:43b1:3d69:dd7b]
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oP3uE-00BHzl-Dd; Fri, 19 Aug 2022 15:27:30 +0000
Message-ID: <245d4220-a88a-5665-c756-a5b32e5bfeae@infradead.org>
Date: Fri, 19 Aug 2022 08:26:57 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] net: move from strlcpy with unused retval to strscpy
Content-Language: en-US
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jay Vosburgh <j.vosburgh@gmail.com>,
 Veaceslav Falico <vfalico@gmail.com>, Andy Gospodarek <andy@greyhouse.net>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vivien Didelot <vivien.didelot@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, Kurt Kanzenbach <kurt@linutronix.de>,
 Steffen Klassert <klassert@kernel.org>, David Dillow <dave@thedillows.org>,
 Russell King <linux@armlinux.org.uk>, Ion Badulescu <ionut@badula.org>,
 Andreas Larsson <andreas@gaisler.com>, Mark Einon <mark.einon@gmail.com>,
 Lino Sanfilippo <LinoSanfilippo@gmx.de>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Jes Sorensen <jes@trained-monkey.org>,
 Shay Agroskin <shayagr@amazon.com>, Arthur Kiyanovski <akiyano@amazon.com>,
 David Arinzon <darinzon@amazon.com>, Noam Dagan <ndagan@amazon.com>,
 Saeed Bishara <saeedb@amazon.com>, Don Fry <pcnet32@frontier.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Igor Russkikh <irusskikh@marvell.com>, Chris Snook <chris.snook@gmail.com>,
 Michael Chan <michael.chan@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, Rasesh Mody <rmody@marvell.com>,
 GR-Linux-NIC-Dev@marvell.com, Ariel Elior <aelior@marvell.com>,
 Sudarsana Kalluru <skalluru@marvell.com>, Manish Chopra
 <manishc@marvell.com>, Doug Berger <opendmb@gmail.com>,
 Siva Reddy Kallam <siva.kallam@broadcom.com>,
 Prashant Sreedharan <prashant@broadcom.com>,
 Sunil Goutham <sgoutham@marvell.com>, Raju Rangoju <rajur@chelsio.com>,
 Ayush Sawal <ayush.sawal@chelsio.com>,
 Vinay Kumar Yadav <vinay.yadav@chelsio.com>,
 Rohit Maheshwari <rohitm@chelsio.com>,
 Hartley Sweeten <hsweeten@visionengravers.com>,
 Christian Benvenuti <benve@cisco.com>,
 Govindarajulu Varadarajan <_govind@gmx.com>,
 Denis Kirjanov <kda@linux-powerpc.org>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Madalin Bucur <madalin.bucur@nxp.com>, Ioana Ciornei
 <ioana.ciornei@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>,
 Joakim Zhang <qiangqing.zhang@nxp.com>,
 Pantelis Antoniou <pantelis.antoniou@gmail.com>, Li Yang
 <leoyang.li@nxp.com>, Yisen Zhuang <yisen.zhuang@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>, Douglas Miller
 <dougmill@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Nick Child <nnac123@linux.ibm.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Guo-Fu Tseng <cooldavid@cooldavid.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Marcin Wojtas <mw@semihalf.com>, Geetha sowjanya <gakula@marvell.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>,
 Taras Chornyi <tchornyi@marvell.com>, Mirko Lindner <mlindner@marvell.com>,
 Stephen Hemminger <stephen@networkplumber.org>, Felix Fietkau
 <nbd@nbd.name>, John Crispin <john@phrozen.org>,
 Sean Wang <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Tariq Toukan <tariqt@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Bryan Whitehead <bryan.whitehead@microchip.com>,
 UNGLinuxDriver@microchip.com, Chris Lee <christopher.lee@cspi.com>,
 Jon Mason <jdmason@kudzu.us>, Simon Horman <simon.horman@corigine.com>,
 Rain River <rain.1986.08.12@gmail.com>, Zhu Yanjun <zyjzyj2000@gmail.com>,
 Vladimir Zapolskiy <vz@mleia.com>, Rahul Verma <rahulv@marvell.com>,
 Shahed Shaikh <shshaikh@marvell.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, nic_swsd@realtek.com, Jiri Pirko <jiri@resnulli.us>,
 Byungho An <bh74.an@samsung.com>, Edward Cree <ecree.xilinx@gmail.com>,
 Martin Habets <habetsm.xilinx@gmail.com>, Ralf Baechle
 <ralf@linux-mips.org>, Francois Romieu <romieu@fr.zoreil.com>,
 Daniele Venzano <venza@brownhat.org>, Nicolas Pitre <nico@fluxnic.net>,
 Steve Glendinning <steve.glendinning@shawell.net>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Samuel Chessman <chessman@tux.org>, Ishizaki Kou
 <kou.ishizaki@toshiba.co.jp>, Kevin Brace <kevinbrace@bracecomputerlab.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
 Michal Simek <michal.simek@xilinx.com>, Krzysztof Halasa <khalasa@piap.pl>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 Petko Manolov <petkan@nucleusys.com>, Oliver Neukum <oneukum@suse.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Ronak Doshi <doshir@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 David Ahern <dsahern@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 Christian Lamparter <chunkeey@googlemail.com>,
 Simon Kelley <simon@thekelleys.org.uk>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Arend van Spriel <aspriel@gmail.com>, Franky Lin <franky.lin@broadcom.com>,
 Hante Meuleman <hante.meuleman@broadcom.com>,
 Stanislav Yakovlev <stas.yakovlev@gmail.com>,
 Stanislaw Gruszka <stf_xl@wp.pl>, Jouni Malinen <j@w1.fi>,
 Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@microchip.com>,
 Igor Mitsyanko <imitsyanko@quantenna.com>,
 Sergey Matyukevich <geomatsi@gmail.com>,
 Herton Ronaldo Krzesinski <herton@canonical.com>,
 Hin-Tak Leung <htl10@users.sourceforge.net>, netdev@vger.kernel.org,
 linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-acenic@sunsite.dk,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 intel-wired-lan@lists.osuosl.org, linux-mediatek@lists.infradead.org,
 linux-rdma@vger.kernel.org, oss-drivers@corigine.com,
 linux-mips@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-omap@vger.kernel.org, linux-hyperv@vger.kernel.org,
 ntb@lists.linux.dev, linux-usb@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-wireless@vger.kernel.org,
 b43-dev@lists.infradead.org, brcm80211-dev-list.pdl@broadcom.com,
 SHA-cyfmac-dev-list@infineon.com, libertas-dev@lists.infradead.org
References: <20220818210050.7108-1-wsa+renesas@sang-engineering.com>
From: Geoff Levand <geoff@infradead.org>
In-Reply-To: <20220818210050.7108-1-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Wolfram,

On 8/18/22 14:00, Wolfram Sang wrote:
> Follow the advice of the below link and prefer 'strscpy' in this
> subsystem. Conversion is 1:1 because the return value is not used.
> Generated by a coccinelle script.
> 
> Link: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

...

> diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.c b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> index 3dbfb1b20649..6e838e8f79d0 100644
> --- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> +++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> @@ -1187,8 +1187,8 @@ int gelic_net_open(struct net_device *netdev)
>  void gelic_net_get_drvinfo(struct net_device *netdev,
>  			   struct ethtool_drvinfo *info)
>  {
> -	strlcpy(info->driver, DRV_NAME, sizeof(info->driver));
> -	strlcpy(info->version, DRV_VERSION, sizeof(info->version));
> +	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
> +	strscpy(info->version, DRV_VERSION, sizeof(info->version));
>  }
>  ps3_gelic_net
>  static int gelic_ether_get_link_ksettings(struct net_device *netdev,
> diff --git a/drivers/net/ethernet/toshiba/spider_net_ethtool.c b/drivers/net/ethernet/toshiba/spider_net_ethtool.c
> index 93110dba0bfa..fef9fd127b5e 100644
> --- a/drivers/net/ethernet/toshiba/spider_net_ethtool.c
> +++ b/drivers/net/ethernet/toshiba/spider_net_ethtool.c
> @@ -63,12 +63,12 @@ spider_net_ethtool_get_drvinfo(struct net_device *netdev,
>  	card = netdev_priv(netdev);
>  
>  	/* clear and fill out info */
> -	strlcpy(drvinfo->driver, spider_net_driver_name,
> +	strscpy(drvinfo->driver, spider_net_driver_name,
>  		sizeof(drvinfo->driver));
> -	strlcpy(drvinfo->version, VERSION, sizeof(drvinfo->version));
> -	strlcpy(drvinfo->fw_version, "no information",
> +	strscpy(drvinfo->version, VERSION, sizeof(drvinfo->version));
> +	strscpy(drvinfo->fw_version, "no information",
>  		sizeof(drvinfo->fw_version));
> -	strlcpy(drvinfo->bus_info, pci_name(card->pdev),
> +	strscpy(drvinfo->bus_info, pci_name(card->pdev),
>  		sizeof(drvinfo->bus_info));
>  }

Seems OK for both ps3_gelic_net and spider_net_ethtool.

Acked-by: Geoff Levand <geoff@infradead.org>
