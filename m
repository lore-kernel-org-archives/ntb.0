Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A0D7F;
	Tue, 23 Aug 2022 01:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1BD6C433D6;
	Tue, 23 Aug 2022 01:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1661216757;
	bh=rLzGcuELxlw6wzYQ32smCo931y+93Ix6heiyYta6PuM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MR96DcUf7/mwpakCtex8peSxXSqw3SkmRpheR1Y9yV9bbsHlS+ylCyc6+FzPARBgs
	 Dr3pPRLQ+sNVLvh4ozvPIloaIC16Ch13S1QNULTYZYxAIf7HCot8K/HyKwcznycDHt
	 FFEnCEvqAgrohThuq5DZktMpvxleT+WdES/F+E9iEpwJ22tMbCYIdiD/iC+zHPPPwS
	 HdJHWKJxW9//GpH/e/xez+EK8EsiOAF9mByy9EBfJnkGqONB0+VKYiP3TIXyiSFaH4
	 uxFnUaJAdXByRNMSXCmUJZdLn9vOc6s/svAFBhv4wjVkERTxSIyx64fuHvXXcVmkE1
	 Unzt3mUFsASlw==
Date: Mon, 22 Aug 2022 18:05:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jay
 Vosburgh <j.vosburgh@gmail.com>, Veaceslav Falico <vfalico@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Wolfgang Grandegger <wg@grandegger.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Florian Fainelli
 <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Vivien Didelot
 <vivien.didelot@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, Kurt
 Kanzenbach <kurt@linutronix.de>, Steffen Klassert <klassert@kernel.org>,
 David Dillow <dave@thedillows.org>, Russell King <linux@armlinux.org.uk>,
 Ion Badulescu <ionut@badula.org>, Andreas Larsson <andreas@gaisler.com>,
 Mark Einon <mark.einon@gmail.com>, Lino Sanfilippo <LinoSanfilippo@gmx.de>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Jes Sorensen
 <jes@trained-monkey.org>, Shay Agroskin <shayagr@amazon.com>, Arthur
 Kiyanovski <akiyano@amazon.com>, David Arinzon <darinzon@amazon.com>, Noam
 Dagan <ndagan@amazon.com>, Saeed Bishara <saeedb@amazon.com>, Don Fry
 <pcnet32@frontier.com>, Tom Lendacky <thomas.lendacky@amd.com>, Shyam
 Sundar S K <Shyam-sundar.S-k@amd.com>, Igor Russkikh
 <irusskikh@marvell.com>, Chris Snook <chris.snook@gmail.com>, Michael Chan
 <michael.chan@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, Rasesh Mody <rmody@marvell.com>,
 GR-Linux-NIC-Dev@marvell.com, Ariel Elior <aelior@marvell.com>, Sudarsana
 Kalluru <skalluru@marvell.com>, Manish Chopra <manishc@marvell.com>, Doug
 Berger <opendmb@gmail.com>, Siva Reddy Kallam <siva.kallam@broadcom.com>,
 Prashant Sreedharan <prashant@broadcom.com>, Sunil Goutham
 <sgoutham@marvell.com>, Raju Rangoju <rajur@chelsio.com>, Ayush Sawal
 <ayush.sawal@chelsio.com>, Vinay Kumar Yadav <vinay.yadav@chelsio.com>,
 Rohit Maheshwari <rohitm@chelsio.com>, Hartley Sweeten
 <hsweeten@visionengravers.com>, Christian Benvenuti <benve@cisco.com>,
 Govindarajulu Varadarajan <_govind@gmx.com>, Denis Kirjanov
 <kda@linux-powerpc.org>, Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, Somnath Kotur
 <somnath.kotur@broadcom.com>, Madalin Bucur <madalin.bucur@nxp.com>, Ioana
 Ciornei <ioana.ciornei@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>,
 Joakim Zhang <qiangqing.zhang@nxp.com>, Pantelis Antoniou
 <pantelis.antoniou@gmail.com>, Li Yang <leoyang.li@nxp.com>, Yisen Zhuang
 <yisen.zhuang@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, Douglas
 Miller <dougmill@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Nick Child <nnac123@linux.ibm.com>, Jesse
 Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Guo-Fu Tseng <cooldavid@cooldavid.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Marcin Wojtas <mw@semihalf.com>, Geetha
 sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 hariprasad <hkelam@marvell.com>, Taras Chornyi <tchornyi@marvell.com>,
 Mirko Lindner <mlindner@marvell.com>, Stephen Hemminger
 <stephen@networkplumber.org>, Felix Fietkau <nbd@nbd.name>, John Crispin
 <john@phrozen.org>, Sean Wang <sean.wang@mediatek.com>, Mark Lee
 <Mark-MC.Lee@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Petr
 Machata <petrm@nvidia.com>, Bryan Whitehead
 <bryan.whitehead@microchip.com>, UNGLinuxDriver@microchip.com, Chris Lee
 <christopher.lee@cspi.com>, Jon Mason <jdmason@kudzu.us>, Simon Horman
 <simon.horman@corigine.com>, Rain River <rain.1986.08.12@gmail.com>, Zhu
 Yanjun <zyjzyj2000@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, Rahul
 Verma <rahulv@marvell.com>, Shahed Shaikh <shshaikh@marvell.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, Jiri Pirko
 <jiri@resnulli.us>, Byungho An <bh74.an@samsung.com>, Edward Cree
 <ecree.xilinx@gmail.com>, Martin Habets <habetsm.xilinx@gmail.com>, Ralf
 Baechle <ralf@linux-mips.org>, Francois Romieu <romieu@fr.zoreil.com>,
 Daniele Venzano <venza@brownhat.org>, Nicolas Pitre <nico@fluxnic.net>,
 Steve Glendinning <steve.glendinning@shawell.net>, Jassi Brar
 <jaswinder.singh@linaro.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Kunihiko Hayashi
 <hayashi.kunihiko@socionext.com>, Giuseppe Cavallaro
 <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>,
 Samuel Chessman <chessman@tux.org>, Geoff Levand <geoff@infradead.org>,
 Ishizaki Kou <kou.ishizaki@toshiba.co.jp>, Kevin Brace
 <kevinbrace@bracecomputerlab.com>, Radhey Shyam Pandey
 <radhey.shyam.pandey@xilinx.com>, Michal Simek <michal.simek@xilinx.com>,
 Krzysztof Halasa <khalasa@piap.pl>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Sridhar Samudrala
 <sridhar.samudrala@intel.com>, Dave Jiang <dave.jiang@intel.com>, Allen
 Hubbe <allenbh@gmail.com>, Michael Hennerich
 <michael.hennerich@analog.com>, Petko Manolov <petkan@nucleusys.com>,
 Oliver Neukum <oneukum@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Ronak Doshi <doshir@vmware.com>, VMware
 PV-Drivers Reviewers <pv-drivers@vmware.com>, David Ahern
 <dsahern@kernel.org>, Kalle Valo <kvalo@kernel.org>, Christian Lamparter
 <chunkeey@googlemail.com>, Simon Kelley <simon@thekelleys.org.uk>, Larry
 Finger <Larry.Finger@lwfinger.net>, Arend van Spriel <aspriel@gmail.com>,
 Franky Lin <franky.lin@broadcom.com>, Hante Meuleman
 <hante.meuleman@broadcom.com>, Stanislav Yakovlev
 <stas.yakovlev@gmail.com>, Stanislaw Gruszka <stf_xl@wp.pl>, Jouni Malinen
 <j@w1.fi>, Ajay Singh <ajay.kathat@microchip.com>, Claudiu Beznea
 <claudiu.beznea@microchip.com>, Igor Mitsyanko <imitsyanko@quantenna.com>,
 Sergey Matyukevich <geomatsi@gmail.com>, Herton Ronaldo Krzesinski
 <herton@canonical.com>, Hin-Tak Leung <htl10@users.sourceforge.net>,
 netdev@vger.kernel.org, linux-can@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-acenic@sunsite.dk, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, intel-wired-lan@lists.osuosl.org,
 linux-mediatek@lists.infradead.org, linux-rdma@vger.kernel.org,
 oss-drivers@corigine.com, linux-mips@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org,
 linux-hyperv@vger.kernel.org, ntb@lists.linux.dev,
 linux-usb@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
 brcm80211-dev-list.pdl@broadcom.com, SHA-cyfmac-dev-list@infineon.com,
 libertas-dev@lists.infradead.org
Subject: Re: [PATCH] net: move from strlcpy with unused retval to strscpy
Message-ID: <20220822180551.160c2a0b@kernel.org>
In-Reply-To: <20220818210050.7108-1-wsa+renesas@sang-engineering.com>
References: <20220818210050.7108-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Aug 2022 23:00:34 +0200 Wolfram Sang wrote:
>  261 files changed, 568 insertions(+), 568 deletions(-)

Unfortunately looks like patchwork was unable to ingest this change :(
Not sure why.

Would you mind splitting it into 3 chunks - wireless, ethernet,
everything else, and resending? Let's see if that'll be small enough..
