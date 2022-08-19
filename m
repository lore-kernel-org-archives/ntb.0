Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA5A443D
	for <ntb@lists.linux.dev>; Fri, 19 Aug 2022 16:06:43 +0000 (UTC)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-11ce6cfabfeso1278265fac.0
        for <ntb@lists.linux.dev>; Fri, 19 Aug 2022 09:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=C/VkUkLDlA7UTo6eTiCDZwcwtLETboqa7t425d7cVFs=;
        b=QofUb7DJOdTcBKkHtRs4SbBflrFzOCIw2B9e+j2rPfVm3+DTUrJWEO4p4eDZy8jLZk
         opsdXQiUJ9WXgMaU1sxZmlc+wuYRoW1/xU68v5GngopvGwxsby5sDbM+TAAkskyyYVbJ
         v0/8DXCGDQYfB2r+7xmBiYCbNMDUeutJGNtIMunNcf4ImRmfm9wTwpQn2yZcEE6A3vN7
         qogadHylDWza51m4clAc74N/Ll8Gd4wv74ESdXlTG0n3xSP3k774PL52ShWjIF3wvopM
         uW6U6tKls0ZmmFGkjaspYpaTtF500g0bFsCrWBdvelWGz+7nuVgbOwF88CUVfE/Y3CHd
         rblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=C/VkUkLDlA7UTo6eTiCDZwcwtLETboqa7t425d7cVFs=;
        b=XuTGYrsKDt6AEHy/W/DfwR/H2Hr3v03zSCWbb29WqMY+wsUicsC/fdMvxxIjbMO8PU
         93Vgpy0g2o/GbpyA2aitzp8Ew+5hSUw4eWPzusOXXZN5g8wVaLpo1CarUIsi1eCJbTkn
         ZjfxyYklkdyTrDnYvr1R524yBcHcvW6nwxekesQkQTVFxkv0T34KL4ldj1AVonwV6Svx
         XF8dyjSLAqjnRx0jwXsNfDlqn0QDrFUD/7Qhih0eLRO+IccznMyyMWNl+CMgE48mCgfk
         l+Gi1gNUpGMgUrw0gvK4Nr07+FByOBNtfJa5EsFiCN+x2OO1zpZwyCQh9AuEIiUSQW9k
         Hs7A==
X-Gm-Message-State: ACgBeo02DI9di6LsJGOYn7ksmOQ4WKXhaobNudMhVLrkHMxf5CxYSWVE
	1UcwsPt3AMG2CeltZ3WfkQWtzUWIVbF7FlFMsrqGNQ==
X-Google-Smtp-Source: AA6agR6Uut65noEds9DTEAIq4MQRn9wvqo20AqeK6lgjbB1e71ZoXHSsYUO7cMA7xG1TwfyTBeH7dfiOL39FELxWe+4=
X-Received: by 2002:a05:6870:a184:b0:116:bd39:7f94 with SMTP id
 a4-20020a056870a18400b00116bd397f94mr7002666oaf.5.1660925202008; Fri, 19 Aug
 2022 09:06:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220818210050.7108-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220818210050.7108-1-wsa+renesas@sang-engineering.com>
From: Marcin Wojtas <mw@semihalf.com>
Date: Fri, 19 Aug 2022 18:06:29 +0200
Message-ID: <CAPv3WKe2oxyjdyBrkDWwpSFKY21OtB4XEHz8YoWZ0LwhcLkNVw@mail.gmail.com>
Subject: Re: [PATCH] net: move from strlcpy with unused retval to strscpy
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jay Vosburgh <j.vosburgh@gmail.com>, Veaceslav Falico <vfalico@gmail.com>, 
	Andy Gospodarek <andy@greyhouse.net>, Wolfgang Grandegger <wg@grandegger.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vivien Didelot <vivien.didelot@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	Kurt Kanzenbach <kurt@linutronix.de>, Steffen Klassert <klassert@kernel.org>, 
	David Dillow <dave@thedillows.org>, Russell King <linux@armlinux.org.uk>, 
	Ion Badulescu <ionut@badula.org>, Andreas Larsson <andreas@gaisler.com>, 
	Mark Einon <mark.einon@gmail.com>, Lino Sanfilippo <LinoSanfilippo@gmx.de>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Jes Sorensen <jes@trained-monkey.org>, 
	Shay Agroskin <shayagr@amazon.com>, Arthur Kiyanovski <akiyano@amazon.com>, 
	David Arinzon <darinzon@amazon.com>, Noam Dagan <ndagan@amazon.com>, 
	Saeed Bishara <saeedb@amazon.com>, Don Fry <pcnet32@frontier.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	Igor Russkikh <irusskikh@marvell.com>, Chris Snook <chris.snook@gmail.com>, 
	Michael Chan <michael.chan@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Rasesh Mody <rmody@marvell.com>, GR-Linux-NIC-Dev@marvell.com, 
	Ariel Elior <aelior@marvell.com>, Sudarsana Kalluru <skalluru@marvell.com>, 
	Manish Chopra <manishc@marvell.com>, Doug Berger <opendmb@gmail.com>, 
	Siva Reddy Kallam <siva.kallam@broadcom.com>, Prashant Sreedharan <prashant@broadcom.com>, 
	Sunil Goutham <sgoutham@marvell.com>, Raju Rangoju <rajur@chelsio.com>, 
	Ayush Sawal <ayush.sawal@chelsio.com>, Vinay Kumar Yadav <vinay.yadav@chelsio.com>, 
	Rohit Maheshwari <rohitm@chelsio.com>, Hartley Sweeten <hsweeten@visionengravers.com>, 
	Christian Benvenuti <benve@cisco.com>, Govindarajulu Varadarajan <_govind@gmx.com>, 
	Denis Kirjanov <kda@linux-powerpc.org>, Ajit Khaparde <ajit.khaparde@broadcom.com>, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, 
	Somnath Kotur <somnath.kotur@broadcom.com>, Madalin Bucur <madalin.bucur@nxp.com>, 
	Ioana Ciornei <ioana.ciornei@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, 
	Joakim Zhang <qiangqing.zhang@nxp.com>, Pantelis Antoniou <pantelis.antoniou@gmail.com>, 
	Li Yang <leoyang.li@nxp.com>, Yisen Zhuang <yisen.zhuang@huawei.com>, 
	Salil Mehta <salil.mehta@huawei.com>, Douglas Miller <dougmill@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Nick Child <nnac123@linux.ibm.com>, 
	Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Guo-Fu Tseng <cooldavid@cooldavid.org>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Geetha sowjanya <gakula@marvell.com>, 
	Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, 
	Taras Chornyi <tchornyi@marvell.com>, Mirko Lindner <mlindner@marvell.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, Felix Fietkau <nbd@nbd.name>, 
	John Crispin <john@phrozen.org>, Sean Wang <sean.wang@mediatek.com>, 
	Mark Lee <Mark-MC.Lee@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	Bryan Whitehead <bryan.whitehead@microchip.com>, UNGLinuxDriver@microchip.com, 
	Chris Lee <christopher.lee@cspi.com>, Jon Mason <jdmason@kudzu.us>, 
	Simon Horman <simon.horman@corigine.com>, Rain River <rain.1986.08.12@gmail.com>, 
	Zhu Yanjun <zyjzyj2000@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, Rahul Verma <rahulv@marvell.com>, 
	Shahed Shaikh <shshaikh@marvell.com>, Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, 
	Jiri Pirko <jiri@resnulli.us>, Byungho An <bh74.an@samsung.com>, 
	Edward Cree <ecree.xilinx@gmail.com>, Martin Habets <habetsm.xilinx@gmail.com>, 
	Ralf Baechle <ralf@linux-mips.org>, Francois Romieu <romieu@fr.zoreil.com>, 
	Daniele Venzano <venza@brownhat.org>, Nicolas Pitre <nico@fluxnic.net>, 
	Steve Glendinning <steve.glendinning@shawell.net>, Jassi Brar <jaswinder.singh@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Grygorii Strashko <grygorii.strashko@ti.com>, Samuel Chessman <chessman@tux.org>, 
	Geoff Levand <geoff@infradead.org>, Ishizaki Kou <kou.ishizaki@toshiba.co.jp>, 
	Kevin Brace <kevinbrace@bracecomputerlab.com>, 
	Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, 
	Krzysztof Halasa <khalasa@piap.pl>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, 
	Michael Hennerich <michael.hennerich@analog.com>, Petko Manolov <petkan@nucleusys.com>, 
	Oliver Neukum <oneukum@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Ronak Doshi <doshir@vmware.com>, VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, 
	David Ahern <dsahern@kernel.org>, Kalle Valo <kvalo@kernel.org>, 
	Christian Lamparter <chunkeey@googlemail.com>, Simon Kelley <simon@thekelleys.org.uk>, 
	Larry Finger <Larry.Finger@lwfinger.net>, Arend van Spriel <aspriel@gmail.com>, 
	Franky Lin <franky.lin@broadcom.com>, Hante Meuleman <hante.meuleman@broadcom.com>, 
	Stanislav Yakovlev <stas.yakovlev@gmail.com>, Stanislaw Gruszka <stf_xl@wp.pl>, Jouni Malinen <j@w1.fi>, 
	Ajay Singh <ajay.kathat@microchip.com>, Claudiu Beznea <claudiu.beznea@microchip.com>, 
	Igor Mitsyanko <imitsyanko@quantenna.com>, Sergey Matyukevich <geomatsi@gmail.com>, 
	Herton Ronaldo Krzesinski <herton@canonical.com>, Hin-Tak Leung <htl10@users.sourceforge.net>, 
	netdev@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-acenic@sunsite.dk, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, intel-wired-lan@lists.osuosl.org, 
	linux-mediatek@lists.infradead.org, linux-rdma@vger.kernel.org, 
	oss-drivers@corigine.com, linux-mips@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, ntb@lists.linux.dev, linux-usb@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-wireless@vger.kernel.org, 
	b43-dev@lists.infradead.org, brcm80211-dev-list.pdl@broadcom.com, 
	SHA-cyfmac-dev-list@infineon.com, libertas-dev@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

czw., 18 sie 2022 o 23:01 Wolfram Sang
<wsa+renesas@sang-engineering.com> napisa=C5=82(a):
>
> Follow the advice of the below link and prefer 'strscpy' in this
> subsystem. Conversion is 1:1 because the return value is not used.
> Generated by a coccinelle script.
>
> Link: https://lore.kernel.org/r/CAHk-=3DwgfRnXz0W3D37d01q3JFkr_i_uTL=3DV6=
A6G1oUZcprmknw@mail.gmail.com/
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/net/Space.c                              |  2 +-
>  drivers/net/bonding/bond_main.c                  |  2 +-
>  drivers/net/can/sja1000/peak_pcmcia.c            |  2 +-
>  drivers/net/can/usb/peak_usb/pcan_usb_core.c     |  2 +-
>  drivers/net/dsa/b53/b53_common.c                 |  2 +-
>  drivers/net/dsa/bcm_sf2_cfp.c                    |  2 +-
>  drivers/net/dsa/hirschmann/hellcreek.c           |  2 +-
>  drivers/net/dsa/mv88e6xxx/chip.c                 |  2 +-
>  drivers/net/dummy.c                              |  2 +-
>  drivers/net/ethernet/3com/3c509.c                |  2 +-
>  drivers/net/ethernet/3com/3c515.c                |  2 +-
>  drivers/net/ethernet/3com/3c589_cs.c             |  2 +-
>  drivers/net/ethernet/3com/3c59x.c                |  6 +++---
>  drivers/net/ethernet/3com/typhoon.c              |  8 ++++----
>  drivers/net/ethernet/8390/ax88796.c              |  6 +++---
>  drivers/net/ethernet/8390/etherh.c               |  6 +++---
>  drivers/net/ethernet/adaptec/starfire.c          |  4 ++--
>  drivers/net/ethernet/aeroflex/greth.c            |  4 ++--
>  drivers/net/ethernet/agere/et131x.c              |  4 ++--
>  drivers/net/ethernet/alacritech/slicoss.c        |  4 ++--
>  drivers/net/ethernet/allwinner/sun4i-emac.c      |  4 ++--
>  drivers/net/ethernet/alteon/acenic.c             |  4 ++--
>  drivers/net/ethernet/amazon/ena/ena_ethtool.c    |  4 ++--
>  drivers/net/ethernet/amazon/ena/ena_netdev.c     |  2 +-
>  drivers/net/ethernet/amd/amd8111e.c              |  4 ++--
>  drivers/net/ethernet/amd/au1000_eth.c            |  2 +-
>  drivers/net/ethernet/amd/nmclan_cs.c             |  2 +-
>  drivers/net/ethernet/amd/pcnet32.c               |  4 ++--
>  drivers/net/ethernet/amd/sunlance.c              |  2 +-
>  drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c     |  4 ++--
>  .../net/ethernet/aquantia/atlantic/aq_ethtool.c  |  2 +-
>  drivers/net/ethernet/arc/emac_main.c             |  2 +-
>  drivers/net/ethernet/atheros/ag71xx.c            |  4 ++--
>  .../net/ethernet/atheros/atl1c/atl1c_ethtool.c   |  4 ++--
>  .../net/ethernet/atheros/atl1e/atl1e_ethtool.c   |  6 +++---
>  drivers/net/ethernet/atheros/atlx/atl1.c         |  4 ++--
>  drivers/net/ethernet/atheros/atlx/atl2.c         |  6 +++---
>  drivers/net/ethernet/broadcom/b44.c              |  6 +++---
>  drivers/net/ethernet/broadcom/bcm63xx_enet.c     |  4 ++--
>  drivers/net/ethernet/broadcom/bcmsysport.c       |  4 ++--
>  drivers/net/ethernet/broadcom/bgmac.c            |  6 +++---
>  drivers/net/ethernet/broadcom/bnx2.c             |  6 +++---
>  drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c  |  2 +-
>  .../net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c  |  6 +++---
>  drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c |  2 +-
>  .../net/ethernet/broadcom/bnx2x/bnx2x_sriov.h    |  2 +-
>  drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c |  2 +-
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c    |  8 ++++----
>  drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c    |  2 +-
>  drivers/net/ethernet/broadcom/genet/bcmgenet.c   |  2 +-
>  drivers/net/ethernet/broadcom/tg3.c              |  6 +++---
>  drivers/net/ethernet/brocade/bna/bnad_ethtool.c  |  6 +++---
>  drivers/net/ethernet/cavium/octeon/octeon_mgmt.c |  2 +-
>  .../net/ethernet/cavium/thunder/nicvf_ethtool.c  |  4 ++--
>  drivers/net/ethernet/chelsio/cxgb/cxgb2.c        |  4 ++--
>  drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c  |  4 ++--
>  .../net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c   |  4 ++--
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c  |  4 ++--
>  .../net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c  |  4 ++--
>  .../chelsio/inline_crypto/chtls/chtls_main.c     |  2 +-
>  drivers/net/ethernet/cirrus/ep93xx_eth.c         |  2 +-
>  drivers/net/ethernet/cisco/enic/enic_ethtool.c   |  6 +++---
>  drivers/net/ethernet/davicom/dm9000.c            |  4 ++--
>  drivers/net/ethernet/dec/tulip/de2104x.c         |  4 ++--
>  drivers/net/ethernet/dec/tulip/dmfe.c            |  4 ++--
>  drivers/net/ethernet/dec/tulip/tulip_core.c      |  4 ++--
>  drivers/net/ethernet/dec/tulip/uli526x.c         |  4 ++--
>  drivers/net/ethernet/dec/tulip/winbond-840.c     |  4 ++--
>  drivers/net/ethernet/dlink/dl2k.c                |  4 ++--
>  drivers/net/ethernet/dlink/sundance.c            |  4 ++--
>  drivers/net/ethernet/dnet.c                      |  4 ++--
>  drivers/net/ethernet/emulex/benet/be_cmds.c      | 12 ++++++------
>  drivers/net/ethernet/emulex/benet/be_ethtool.c   |  6 +++---
>  drivers/net/ethernet/faraday/ftgmac100.c         |  4 ++--
>  drivers/net/ethernet/faraday/ftmac100.c          |  4 ++--
>  drivers/net/ethernet/fealnx.c                    |  4 ++--
>  .../net/ethernet/freescale/dpaa/dpaa_ethtool.c   |  4 ++--
>  drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c |  2 +-
>  .../net/ethernet/freescale/enetc/enetc_ethtool.c |  4 ++--
>  drivers/net/ethernet/freescale/fec_main.c        |  8 ++++----
>  drivers/net/ethernet/freescale/fec_ptp.c         |  2 +-
>  .../ethernet/freescale/fs_enet/fs_enet-main.c    |  2 +-
>  drivers/net/ethernet/freescale/gianfar_ethtool.c |  2 +-
>  .../net/ethernet/freescale/ucc_geth_ethtool.c    |  4 ++--
>  drivers/net/ethernet/fujitsu/fmvj18x_cs.c        |  4 ++--
>  drivers/net/ethernet/hisilicon/hip04_eth.c       |  4 ++--
>  drivers/net/ethernet/ibm/ehea/ehea_ethtool.c     |  4 ++--
>  drivers/net/ethernet/ibm/emac/core.c             |  4 ++--
>  drivers/net/ethernet/ibm/ibmveth.c               |  4 ++--
>  drivers/net/ethernet/intel/e100.c                |  4 ++--
>  drivers/net/ethernet/intel/e1000/e1000_ethtool.c |  4 ++--
>  drivers/net/ethernet/intel/e1000e/ethtool.c      |  4 ++--
>  drivers/net/ethernet/intel/e1000e/netdev.c       |  6 +++---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c   |  6 +++---
>  drivers/net/ethernet/intel/i40e/i40e_main.c      | 16 ++++++++--------
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c       |  2 +-
>  drivers/net/ethernet/intel/iavf/iavf_ethtool.c   |  6 +++---
>  drivers/net/ethernet/intel/igb/igb_ethtool.c     |  6 +++---
>  drivers/net/ethernet/intel/igb/igb_main.c        |  2 +-
>  drivers/net/ethernet/intel/igbvf/ethtool.c       |  4 ++--
>  drivers/net/ethernet/intel/ixgb/ixgb_ethtool.c   |  4 ++--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  6 +++---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c    |  2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  4 ++--
>  drivers/net/ethernet/intel/ixgbevf/ethtool.c     |  4 ++--
>  drivers/net/ethernet/jme.c                       |  6 +++---
>  drivers/net/ethernet/korina.c                    |  6 +++---
>  drivers/net/ethernet/marvell/mv643xx_eth.c       |  8 ++++----
>  drivers/net/ethernet/marvell/mvneta.c            |  6 +++---
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c  |  6 +++---

For: drivers/net/ethernet/marvell/mvpp2

Acked-by: Marcin Wojtas <mw@semihalf.com>

Thanks,
Marcin
