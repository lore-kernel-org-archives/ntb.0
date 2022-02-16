Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0555023D2
	for <ntb@lists.linux.dev>; Wed, 16 Feb 2022 17:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:cc:content-disposition;
	bh=9RtWKouvnIbUc5VW2C8Hx+trq+PRLwveM0SzwLypKAg=; b=KOd+KyRpFXEmNHQ5mCE6NcxUGo
	+DRVsF9bDDBVVtHJ1MVcRdlpjKBMJoEBnvBYaiiATaZgqvqRANiQziJDt9N8sP6bz4179MSowNnjc
	d9R+z4u+w5huO9FoB3Lo87YJu+97gdvKukNecllXiG059lXg2fW3c9uG23Q+alRED6FhSMxMR7po3
	nmT1lXM88QeD9Uk3hmNSv+rWz8BcGBAsr7HCiLdH8zb0f4hYEBRSOR1k3s78qKfxa5jO97i6YerXp
	+5kxd7Q9b8+xdV1vxJ3tva1Mj099qIdcLC0ON/5cE6bp8PJFNotwPK/l8ebBRLbmQUPfQ9K8vx2dY
	wqRs0+yw==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <logang@deltatee.com>)
	id 1nKNsT-001eBU-G4; Wed, 16 Feb 2022 10:14:08 -0700
To: Marc Smith <msmith626@gmail.com>, ntb@lists.linux.dev,
 Kelvin Cao <kelvin.cao@microchip.com>, kelvincao@outlook.com
References: <CAH6h+hfwRFMW47ONT+zC8Z1Y-30gb4dPEwTOtatN86EMeUajpA@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <1d53b232-dc0a-c7d3-69a1-8cb17ff83601@deltatee.com>
Date: Wed, 16 Feb 2022 10:14:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAH6h+hfwRFMW47ONT+zC8Z1Y-30gb4dPEwTOtatN86EMeUajpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: kelvincao@outlook.com, kelvin.cao@microchip.com, ntb@lists.linux.dev, msmith626@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	LR_URI_NUMERIC_ENDING,MYRULES_FREE,NICE_REPLY_A,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
Subject: Re: ntb_netdev Communication Failure Issue
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

Hi Marc,


On 2022-02-16 9:16 a.m., Marc Smith wrote:
> Hi,
> 
> I'm using vanilla Linux 5.4.145 with a Celestica "cluster-in-a-box"
> system (two servers in a single chassis connected internally via PCIe
> switches). The PCIe switches are Microsemi Switchtec ('lspci' says
> "PMC-Sierra Inc. PM8546 B-FEIP PSX 96xG3 PCIe Storage Switch
> [11f8:8546]" but I believe this is not the current product/model name
> from Microsemi).
> 
> I use the 'ntb_netdev' driver for the virtual Ethernet functionality
> across the NTB for IP communication between the two controllers. I've
> had a long standing issue where sometimes when we reboot a controller,
> we're never able to establish communication between the two
> controllers again -- usually requires rebooting both and/or power
> cycling the entire chassis.
> 
> I've also noticed sometimes when they boot, the virtual Ethernet
> device fails to pass traffic right away.
> 
> And finally, when simply doing an "ifconfig NTB_IF down" followed by
> an "ifconfig NTB_IF up" on one controller, they sometimes get into the
> state where they no longer pass traffic.
> 
> All three conditions seem to be related, and the symptom is the same
> (they have the UP RUNNING flags with IP's configured but I'm unable to
> ping between the two controllers). Usually when this happens, one side
> will show the drop/error counts for the NTB virtual Ethernet interface
> increasing (never ending).
> 
> In the example below, both controllers booted up, and I unloaded the
> modules then reloaded with 'dyndbg=+p' but immediately was not able to
> pass any traffic on those interfaces.


I've copied Kelvin who does most of the work on the switchtec driver. I
suspect this is a bug in that driver.

I also know that there have been some fixes in this area in the OOT
version of that module (which will probably make it upstream in due course).

See this PR:

https://github.com/Microsemi/switchtec-kernel/pull/107

I wouldn't be surprised if this is the same issue you are seeing. The
patches there should apply pretty easily to the upstream kernel if you
prefer.

Logan



> Node/controller 1:
> [44101.188104] switchtec switchtec0: Management device registered.
> [44101.224290] switchtec switchtec1: Management device registered.
> [44101.224879] switchtec: loaded.
> [44108.104617] switchtec switchtec0: Partition ID 0 of 3
> [44108.104785] switchtec switchtec0: MWs: 2 direct, 32 lut
> [44108.104912] switchtec switchtec0: Peer MWs: 2 direct, 32 lut
> [44108.157019] switchtec switchtec0: Requester ID 00:00.0 -> BB:01.0
> [44108.157054] switchtec switchtec0: Requester ID 3A:00.0 -> BB:01.1
> [44108.208906] switchtec switchtec0: Using crosslink configuration
> [44108.208981] switchtec switchtec0: Crosslink BAR0 addr: 0
> [44108.209092] switchtec switchtec0: Crosslink BAR2 addr: 1000000000
> [44108.209167] switchtec switchtec0: Crosslink BAR4 addr: 2000000000
> [44108.468954] switchtec switchtec0: Requester ID 00:01.0 -> BB:01.4
> [44108.468986] switchtec switchtec0: Requester ID 00:01.1 -> BB:01.5
> [44108.521033] switchtec switchtec0: dbs: shift 0/0, mask 0fffffffffffffff
> [44108.625136] switchtec switchtec0: Shared MW Ready
> [44108.625163] switchtec switchtec0: irqs - event: 2, db: 0, msgs: 1
> [44108.626511] switchtec switchtec0: NTB device registered
> [44140.260589] switchtec switchtec0: stuser_create: 00000000df6a1e87
> [44140.260594] switchtec switchtec0: switchtec_dev_open: 00000000df6a1e87
> [44140.260743] switchtec switchtec0: stuser_free: 00000000df6a1e87
> [44150.277982] switchtec switchtec0: stuser_create: 00000000c4701c39
> [44150.277987] switchtec switchtec0: switchtec_dev_open: 00000000c4701c39
> [44150.278138] switchtec switchtec0: stuser_free: 00000000c4701c39
> [44231.225116] switchtec switchtec0: message: 0 00000001
> [44232.799538] Software Queue-Pair Transport over NTB, version 4
> [44232.800780] switchtec switchtec0: enabling link
> [44232.800893] switchtec 0000:3b:00.1: Remote version = 0
> [44232.800903] switchtec switchtec0: ntb link up
> [44232.801001] switchtec switchtec0: message: 0 00000003
> [44232.812419] switchtec 0000:3b:00.1: Remote version = 4
> [44232.812430] switchtec 0000:3b:00.1: Remote max number of qps = 2
> [44232.812439] switchtec 0000:3b:00.1: Remote number of mws = 2
> [44232.812449] switchtec 0000:3b:00.1: Remote MW0 size = 0x200000
> [44232.813114] switchtec switchtec0: MW 0: part 0 addr
> 0x0000001071600000 size 0x0000000000200000
> [44232.916884] switchtec 0000:3b:00.1: Remote MW1 size = 0x200000
> [44232.917452] switchtec switchtec0: MW 1: part 0 addr
> 0x0000001014e00000 size 0x0000000000200000
> [44257.513987] switchtec 0000:3b:00.1: Using DMA memcpy for TX
> [44257.513992] switchtec 0000:3b:00.1: Using DMA memcpy for RX
> [44257.517993] switchtec 0000:3b:00.1: NTB Transport QP 0 created
> [44257.524071] switchtec 0000:3b:00.1: eth0 created
> [44257.533847] ntb_netdev ntb_netdev0 priv0: renamed from eth0
> ...
> [44344.794970] switchtec switchtec0: stuser_create: 00000000b79c4946
> [44344.794975] switchtec switchtec0: switchtec_dev_open: 00000000b79c4946
> [44344.795158] switchtec switchtec0: stuser_free: 00000000b79c4946
> [44344.871358] switchtec switchtec0: stuser_create: 000000009a68785f
> [44344.871363] switchtec switchtec0: switchtec_dev_open: 000000009a68785f
> [44344.871542] switchtec switchtec0: stuser_free: 000000009a68785f
> [44350.386529] switchtec switchtec0: stuser_create: 00000000a3644dc9
> [44350.386535] switchtec switchtec0: switchtec_dev_open: 00000000a3644dc9
> [44350.386721] switchtec switchtec0: stuser_free: 00000000a3644dc9
> [44350.416802] switchtec switchtec0: stuser_create: 00000000f2cc280a
> [44350.416807] switchtec switchtec0: switchtec_dev_open: 00000000f2cc280a
> [44350.416968] switchtec switchtec0: stuser_free: 00000000f2cc280a
> [44470.486355] switchtec 0000:3b:00.1: Remote QP link status = 0
> [44470.496863] switchtec 0000:3b:00.1: Remote QP link status = 0
> [44470.504156] switchtec 0000:3b:00.1: Remote QP link status = 0
> [44470.514905] switchtec 0000:3b:00.1: Remote QP link status = 0
> [44470.527490] switchtec 0000:3b:00.1: Remote QP link status = 0
> [44470.537896] switchtec 0000:3b:00.1: Remote QP link status = 0
> [44470.548884] switchtec 0000:3b:00.1: Remote QP link status = 0
> [44470.559902] switchtec 0000:3b:00.1: Remote QP link status = 0
> [44470.570890] switchtec 0000:3b:00.1: Remote QP link status = 0
> [44470.581890] switchtec 0000:3b:00.1: Remote QP link status = 0
> [44470.591242] switchtec switchtec0: stuser_create: 00000000309d4e4c
> [44470.591248] switchtec switchtec0: switchtec_dev_open: 00000000309d4e4c
> [44470.591412] switchtec switchtec0: stuser_free: 00000000309d4e4c
> [44470.625330] switchtec switchtec0: stuser_create: 000000007e7c8c1c
> [44470.625335] switchtec switchtec0: switchtec_dev_open: 000000007e7c8c1c
> [44470.625511] switchtec switchtec0: stuser_free: 000000007e7c8c1c
> [44474.332907] switchtec 0000:3b:00.1: qp 0: Link Up
> [44474.332925] ntb_netdev ntb_netdev0 priv0: Event 1, Link 1
> [44474.332965] switchtec 0000:3b:00.1: ntb_transport_rxc_db: doorbell 0 received
> [44474.332977] switchtec 0000:3b:00.1: qp 0: RX ver 0 len 0 flags 0
> [44474.332985] switchtec 0000:3b:00.1: done flag not set
> [44474.333020] IPv6: ADDRCONF(NETDEV_CHANGE): priv0: link becomes ready
> [44474.355200] switchtec switchtec0: doorbell
> [44474.355250] switchtec 0000:3b:00.1: ntb_transport_rxc_db: doorbell 0 received
> [44474.355263] switchtec 0000:3b:00.1: qp 0: RX ver 0 len 0 flags 3
> [44474.355272] switchtec 0000:3b:00.1: link down flag set
> [44474.355320] switchtec 0000:3b:00.1: qp 0: Link Cleanup
> [44474.355337] ntb_netdev ntb_netdev0 priv0: Event 0, Link 0
> [44474.355372] switchtec 0000:3b:00.1: ntb_transport_rxc_db: doorbell 0 received
> [44474.355382] switchtec 0000:3b:00.1: qp 0: RX ver 0 len 0 flags 0
> [44474.355390] switchtec 0000:3b:00.1: done flag not set
> [44474.360458] switchtec switchtec0: doorbell
> [44474.365910] switchtec 0000:3b:00.1: qp 0: Link Up
> [44474.365923] ntb_netdev ntb_netdev0 priv0: Event 1, Link 1
> [44474.365961] switchtec 0000:3b:00.1: ntb_transport_rxc_db: doorbell 0 received
> [44474.365971] switchtec 0000:3b:00.1: qp 0: RX ver 0 len 90 flags 1
> [44474.365984] switchtec 0000:3b:00.1: RX OK index 0 ver 0 size 90
> into buf size 65524
> [44474.365998] ntb_netdev ntb_netdev0 priv0: ntb_netdev_rx_handler: 90
> byte payload received
> [44474.366072] switchtec 0000:3b:00.1: qp 0: RX ver 0 len 0 flags 0
> [44474.366079] switchtec 0000:3b:00.1: done flag not set
> [44474.366192] switchtec 0000:3b:00.1: ntb_transport_rxc_db: doorbell 0 received
> [44474.366195] switchtec 0000:3b:00.1: qp 0: RX ver 0 len 0 flags 0
> [44474.366197] switchtec 0000:3b:00.1: done flag not set
> [44474.939439] switchtec switchtec0: doorbell
> [44474.939454] switchtec 0000:3b:00.1: ntb_transport_rxc_db: doorbell 0 received
> [44474.939458] switchtec 0000:3b:00.1: qp 0: RX ver 1 len 90 flags 1
> [44474.939462] switchtec 0000:3b:00.1: RX OK index 1 ver 1 size 90
> into buf size 65524
> [44474.939467] ntb_netdev ntb_netdev0 priv0: ntb_netdev_rx_handler: 90
> byte payload received
> [44474.939493] switchtec 0000:3b:00.1: qp 0: RX ver 0 len 0 flags 0
> [44474.939495] switchtec 0000:3b:00.1: done flag not set
> [44474.939566] switchtec 0000:3b:00.1: ntb_transport_rxc_db: doorbell 0 received
> [44474.939569] switchtec 0000:3b:00.1: qp 0: RX ver 0 len 0 flags 0
> [44474.939572] switchtec 0000:3b:00.1: done flag not set
> [44475.387462] switchtec switchtec0: doorbell
> [44475.387475] switchtec 0000:3b:00.1: ntb_transport_rxc_db: doorbell 0 received
> [44475.387478] switchtec 0000:3b:00.1: qp 0: RX ver 2 len 86 flags 1
> [44475.387482] switchtec 0000:3b:00.1: RX OK index 2 ver 2 size 86
> into buf size 65524
> [44475.387486] ntb_netdev ntb_netdev0 priv0: ntb_netdev_rx_handler: 86
> byte payload received
> [44475.387505] switchtec 0000:3b:00.1: qp 0: RX ver 0 len 0 flags 0
> [44475.387507] switchtec 0000:3b:00.1: done flag not set
> [44475.387561] switchtec 0000:3b:00.1: ntb_transport_rxc_db: doorbell 0 received
> [44475.387563] switchtec 0000:3b:00.1: qp 0: RX ver 0 len 0 flags 0
> [44475.387566] switchtec 0000:3b:00.1: done flag not set
> [44476.411777] switchtec switchtec0: doorbell
> [44476.411792] switchtec 0000:3b:00.1: ntb_transport_rxc_db: doorbell 0 received
> [44476.411796] switchtec 0000:3b:00.1: qp 0: RX ver 3 len 90 flags 1
> [44476.411800] switchtec 0000:3b:00.1: RX OK index 3 ver 3 size 90
> into buf size 65524
> [44476.411807] ntb_netdev ntb_netdev0 priv0: ntb_netdev_rx_handler: 90
> byte payload received
> [44476.411835] switchtec 0000:3b:00.1: qp 0: RX ver 0 len 0 flags 0
> [44476.411837] switchtec 0000:3b:00.1: done flag not set
> [44476.411907] switchtec 0000:3b:00.1: ntb_transport_rxc_db: doorbell 0 received
> [44476.411910] switchtec 0000:3b:00.1: qp 0: RX ver 0 len 0 flags 0
> [44476.411912] switchtec 0000:3b:00.1: done flag not set
> [44476.412087] switchtec switchtec0: doorbell
> [44476.412091] switchtec 0000:3b:00.1: ntb_transport_rxc_db: doorbell 0 received
> [44476.412094] switchtec 0000:3b:00.1: qp 0: RX ver 4 len 70 flags 1
> [44476.412098] switchtec 0000:3b:00.1: RX OK index 4 ver 4 size 70
> into buf size 65524
> [44476.412102] ntb_netdev ntb_netdev0 priv0: ntb_netdev_rx_handler: 70
> byte payload received
> [44476.412120] switchtec 0000:3b:00.1: qp 0: RX ver 0 len 0 flags 0
> [44476.412122] switchtec 0000:3b:00.1: done flag not set
> [44476.412198] switchtec 0000:3b:00.1: ntb_transport_rxc_db: doorbell 0 received
> [44476.412201] switchtec 0000:3b:00.1: qp 0: RX ver 0 len 0 flags 0
> [44476.412203] switchtec 0000:3b:00.1: done flag not set
> [44477.307472] switchtec switchtec0: doorbell
> [44477.307487] switchtec 0000:3b:00.1: ntb_transport_rxc_db: doorbell 0 received
> [44477.307490] switchtec 0000:3b:00.1: qp 0: RX ver 5 len 90 flags 1
> [44477.307494] switchtec 0000:3b:00.1: RX OK index 5 ver 5 size 90
> into buf size 65524
> [44477.307501] ntb_netdev ntb_netdev0 priv0: ntb_netdev_rx_handler: 90
> byte payload received
> [44477.307525] switchtec 0000:3b:00.1: qp 0: RX ver 0 len 0 flags 0
> [44477.307528] switchtec 0000:3b:00.1: done flag not set
> [44477.307689] switchtec 0000:3b:00.1: ntb_transport_rxc_db: doorbell 0 received
> [44477.307692] switchtec 0000:3b:00.1: qp 0: RX ver 0 len 0 flags 0
> [44477.307694] switchtec 0000:3b:00.1: done flag not set
> [44481.147576] switchtec switchtec0: doorbell
> [44481.147594] switchtec 0000:3b:00.1: ntb_transport_rxc_db: doorbell 0 received
> [44481.147597] switchtec 0000:3b:00.1: qp 0: RX ver 6 len 70 flags 1
> [44481.147601] switchtec 0000:3b:00.1: RX OK index 6 ver 6 size 70
> into buf size 65524
> [44481.147607] ntb_netdev ntb_netdev0 priv0: ntb_netdev_rx_handler: 70
> byte payload received
> [44481.147631] switchtec 0000:3b:00.1: qp 0: RX ver 0 len 0 flags 0
> [44481.147634] switchtec 0000:3b:00.1: done flag not set
> [44481.147712] switchtec 0000:3b:00.1: ntb_transport_rxc_db: doorbell 0 received
> [44481.147715] switchtec 0000:3b:00.1: qp 0: RX ver 0 len 0 flags 0
> [44481.147718] switchtec 0000:3b:00.1: done flag not set
> [44489.851482] switchtec switchtec0: doorbell
> [44489.851498] switchtec 0000:3b:00.1: ntb_transport_rxc_db: doorbell 0 received
> [44489.851502] switchtec 0000:3b:00.1: qp 0: RX ver 7 len 70 flags 1
> [44489.851506] switchtec 0000:3b:00.1: RX OK index 7 ver 7 size 70
> into buf size 65524
> [44489.851511] ntb_netdev ntb_netdev0 priv0: ntb_netdev_rx_handler: 70
> byte payload received
> [44489.851536] switchtec 0000:3b:00.1: qp 0: RX ver 0 len 0 flags 0
> [44489.851538] switchtec 0000:3b:00.1: done flag not set
> [44489.851616] switchtec 0000:3b:00.1: ntb_transport_rxc_db: doorbell 0 received
> [44489.851619] switchtec 0000:3b:00.1: qp 0: RX ver 0 len 0 flags 0
> [44489.851621] switchtec 0000:3b:00.1: done flag not set
> [44493.354390] switchtec switchtec0: stuser_create: 00000000098d03cb
> [44493.354395] switchtec switchtec0: switchtec_dev_open: 00000000098d03cb
> [44493.354560] switchtec switchtec0: stuser_free: 00000000098d03cb
> [44493.377810] switchtec switchtec0: stuser_create: 00000000cac0e0f9
> [44493.377815] switchtec switchtec0: switchtec_dev_open: 00000000cac0e0f9
> [44493.378029] switchtec switchtec0: stuser_free: 00000000cac0e0f9
> [44493.396554] switchtec switchtec0: stuser_create: 000000008fe7cb2b
> [44493.396559] switchtec switchtec0: switchtec_dev_open: 000000008fe7cb2b
> [44493.396719] switchtec switchtec0: stuser_free: 000000008fe7cb2b
> [44493.417150] switchtec switchtec0: stuser_create: 00000000e67348bf
> [44493.417154] switchtec switchtec0: switchtec_dev_open: 00000000e67348bf
> [44493.417323] switchtec switchtec0: stuser_free: 00000000e67348bf
> [44493.438786] switchtec switchtec0: stuser_create: 000000007384dd1d
> [44493.438791] switchtec switchtec0: switchtec_dev_open: 000000007384dd1d
> [44493.438969] switchtec switchtec0: stuser_free: 000000007384dd1d
> [44493.459467] switchtec switchtec0: stuser_create: 00000000af970cd7
> [44493.459471] switchtec switchtec0: switchtec_dev_open: 00000000af970cd7
> [44493.459637] switchtec switchtec0: stuser_free: 00000000af970cd7
> [44493.480517] switchtec switchtec0: stuser_create: 00000000abdf1426
> [44493.480522] switchtec switchtec0: switchtec_dev_open: 00000000abdf1426
> [44493.480672] switchtec switchtec0: stuser_free: 00000000abdf1426
> [44493.501712] switchtec switchtec0: stuser_create: 00000000e4221771
> [44493.501716] switchtec switchtec0: switchtec_dev_open: 00000000e4221771
> [44493.501882] switchtec switchtec0: stuser_free: 00000000e4221771
> [44493.528249] switchtec switchtec0: stuser_create: 00000000c9d7a68c
> [44493.528253] switchtec switchtec0: switchtec_dev_open: 00000000c9d7a68c
> [44493.528414] switchtec switchtec0: stuser_free: 00000000c9d7a68c
> [44493.555529] switchtec switchtec0: stuser_create: 00000000e415ce5d
> [44493.555533] switchtec switchtec0: switchtec_dev_open: 00000000e415ce5d
> [44493.555699] switchtec switchtec0: stuser_free: 00000000e415ce5d
> [44493.577118] switchtec switchtec0: stuser_create: 000000003bee7779
> [44493.577122] switchtec switchtec0: switchtec_dev_open: 000000003bee7779
> [44493.577276] switchtec switchtec0: stuser_free: 000000003bee7779
> [44493.598661] switchtec switchtec0: stuser_create: 00000000e76bc00f
> [44493.598668] switchtec switchtec0: switchtec_dev_open: 00000000e76bc00f
> [44493.598942] switchtec switchtec0: stuser_free: 00000000e76bc00f
> [44493.619690] switchtec switchtec0: stuser_create: 00000000e527a94d
> [44493.619694] switchtec switchtec0: switchtec_dev_open: 00000000e527a94d
> [44493.619841] switchtec switchtec0: stuser_free: 00000000e527a94d
> [44493.640966] switchtec switchtec0: stuser_create: 000000004978b777
> [44493.640970] switchtec switchtec0: switchtec_dev_open: 000000004978b777
> [44493.641134] switchtec switchtec0: stuser_free: 000000004978b777
> [44493.660708] switchtec switchtec0: stuser_create: 00000000061d84e0
> [44493.660712] switchtec switchtec0: switchtec_dev_open: 00000000061d84e0
> [44493.660914] switchtec switchtec0: stuser_free: 00000000061d84e0
> [44493.679806] switchtec switchtec0: stuser_create: 00000000ab4b5fd5
> [44493.679811] switchtec switchtec0: switchtec_dev_open: 00000000ab4b5fd5
> [44493.680007] switchtec switchtec0: stuser_free: 00000000ab4b5fd5
> [44493.701799] switchtec switchtec0: stuser_create: 00000000943768fe
> [44493.701804] switchtec switchtec0: switchtec_dev_open: 00000000943768fe
> [44493.701978] switchtec switchtec0: stuser_free: 00000000943768fe
> [44493.722465] switchtec switchtec0: stuser_create: 00000000727838fa
> [44493.722469] switchtec switchtec0: switchtec_dev_open: 00000000727838fa
> [44493.722633] switchtec switchtec0: stuser_free: 00000000727838fa
> [44493.744238] switchtec switchtec0: stuser_create: 000000008eb49672
> [44493.744242] switchtec switchtec0: switchtec_dev_open: 000000008eb49672
> [44493.744395] switchtec switchtec0: stuser_free: 000000008eb49672
> [44493.765595] switchtec switchtec0: stuser_create: 00000000ec4dcadf
> [44493.765599] switchtec switchtec0: switchtec_dev_open: 00000000ec4dcadf
> [44493.765766] switchtec switchtec0: stuser_free: 00000000ec4dcadf
> [44493.786396] switchtec switchtec0: stuser_create: 00000000b664b5c8
> [44493.786401] switchtec switchtec0: switchtec_dev_open: 00000000b664b5c8
> [44493.786554] switchtec switchtec0: stuser_free: 00000000b664b5c8
> [44493.808189] switchtec switchtec0: stuser_create: 000000000b620cc8
> [44493.808194] switchtec switchtec0: switchtec_dev_open: 000000000b620cc8
> [44493.808359] switchtec switchtec0: stuser_free: 000000000b620cc8
> [44493.826971] switchtec switchtec0: stuser_create: 00000000237afec0
> [44493.826976] switchtec switchtec0: switchtec_dev_open: 00000000237afec0
> [44493.827128] switchtec switchtec0: stuser_free: 00000000237afec0
> [44493.847269] switchtec switchtec0: stuser_create: 00000000766c005b
> [44493.847273] switchtec switchtec0: switchtec_dev_open: 00000000766c005b
> [44493.847474] switchtec switchtec0: stuser_free: 00000000766c005b
> [44500.851786] switchtec switchtec0: stuser_create: 000000009a68785f
> [44500.851792] switchtec switchtec0: switchtec_dev_open: 000000009a68785f
> [44500.851993] switchtec switchtec0: stuser_free: 000000009a68785f
> [44507.259767] switchtec switchtec0: doorbell
> [44507.259785] switchtec 0000:3b:00.1: ntb_transport_rxc_db: doorbell 0 received
> [44507.259790] switchtec 0000:3b:00.1: qp 0: RX ver 8 len 70 flags 1
> [44507.259795] switchtec 0000:3b:00.1: RX OK index 8 ver 8 size 70
> into buf size 65524
> [44507.259801] ntb_netdev ntb_netdev0 priv0: ntb_netdev_rx_handler: 70
> byte payload received
> [44507.259828] switchtec 0000:3b:00.1: qp 0: RX ver 0 len 0 flags 0
> [44507.259830] switchtec 0000:3b:00.1: done flag not set
> [44507.259894] switchtec 0000:3b:00.1: ntb_transport_rxc_db: doorbell 0 received
> [44507.259897] switchtec 0000:3b:00.1: qp 0: RX ver 0 len 0 flags 0
> [44507.259899] switchtec 0000:3b:00.1: done flag not set
> 
> # cat /sys/kernel/debug/ntb_transport/0000\:3b\:00.1/qp0/stats
> NTB QP stats:
> 
> rx_bytes - 1244
> rx_pkts - 20
> rx_memcpy - 20
> rx_async - 0
> rx_ring_empty - 41
> rx_err_no_buf - 0
> rx_err_oflow - 0
> rx_err_ver - 0
> rx_buff - 0x00000000fd3649f3
> rx_index - 20
> rx_max_entry - 31
> rx_alloc_entry - 100
> 
> tx_bytes - 0
> tx_pkts - 0
> tx_memcpy - 0
> tx_async - 0
> tx_ring_full - 212083112
> tx_err_no_buf - 0
> tx_mw - 0x0000000029c0837d
> tx_index (H) - 0
> RRI (T) - 0
> tx_max_entry - 31
> free tx - 31
> 
> Using TX DMA - Yes
> Using RX DMA - Yes
> QP Link - Up
> 
> # ifconfig priv0
> priv0     Link encap:Ethernet  HWaddr 1A:A5:C6:CD:F2:51
>           inet addr:10.17.21.197  Bcast:10.17.21.199  Mask:255.255.255.252
>           inet6 addr: fe80::18a5:c6ff:fecd:f251/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:26 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:1 errors:276181510 dropped:276181510 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000
>           RX bytes:1496 (1.4 KiB)  TX bytes:90 (90.0 B)
> 
> 
> Node/controller 2:
> [43808.457199] switchtec switchtec0: Management device registered.
> [43808.492076] switchtec switchtec1: Management device registered.
> [43808.492647] switchtec: loaded.
> [43815.711975] switchtec switchtec0: Partition ID 0 of 3
> [43815.712140] switchtec switchtec0: MWs: 2 direct, 32 lut
> [43815.712261] switchtec switchtec0: Peer MWs: 2 direct, 32 lut
> [43815.764006] switchtec switchtec0: Requester ID 00:00.0 -> BB:01.0
> [43815.764033] switchtec switchtec0: Requester ID 3A:00.0 -> BB:01.1
> [43815.815913] switchtec switchtec0: Using crosslink configuration
> [43815.815978] switchtec switchtec0: Crosslink BAR0 addr: 0
> [43815.816091] switchtec switchtec0: Crosslink BAR2 addr: 1000000000
> [43815.816155] switchtec switchtec0: Crosslink BAR4 addr: 2000000000
> [43816.075968] switchtec switchtec0: Requester ID 00:01.0 -> BB:01.4
> [43816.076000] switchtec switchtec0: Requester ID 00:01.1 -> BB:01.5
> [43816.128185] switchtec switchtec0: dbs: shift 0/0, mask 0fffffffffffffff
> [43816.232166] switchtec switchtec0: Shared MW Ready
> [43816.232193] switchtec switchtec0: irqs - event: 2, db: 0, msgs: 1
> [43816.233520] switchtec switchtec0: NTB device registered
> [43817.032047] switchtec switchtec0: stuser_create: 0000000070070c46
> [43817.032052] switchtec switchtec0: switchtec_dev_open: 0000000070070c46
> [43817.032212] switchtec switchtec0: stuser_free: 0000000070070c46
> [43855.950121] switchtec switchtec0: message: 0 00000004
> [43952.022182] switchtec switchtec0: stuser_create: 00000000154869b1
> [43952.022188] switchtec switchtec0: switchtec_dev_open: 00000000154869b1
> [43952.022422] switchtec switchtec0: stuser_free: 00000000154869b1
> [43952.095507] switchtec switchtec0: stuser_create: 00000000760ad51f
> [43952.095512] switchtec switchtec0: switchtec_dev_open: 00000000760ad51f
> [43952.095681] switchtec switchtec0: stuser_free: 00000000760ad51f
> [43978.547393] Software Queue-Pair Transport over NTB, version 4
> [43978.548191] switchtec switchtec0: enabling link
> [43980.123918] switchtec switchtec0: message: 0 00000001
> [43980.124031] switchtec switchtec0: message: 0 00000003
> [43980.124110] switchtec switchtec0: ntb link up
> [43980.124232] switchtec 0000:3b:00.1: Remote version = 4
> [43980.124242] switchtec 0000:3b:00.1: Remote max number of qps = 2
> [43980.124251] switchtec 0000:3b:00.1: Remote number of mws = 2
> [43980.124261] switchtec 0000:3b:00.1: Remote MW0 size = 0x200000
> [43980.124847] switchtec switchtec0: MW 0: part 0 addr
> 0x00000010d2200000 size 0x0000000000200000
> [43980.227931] switchtec 0000:3b:00.1: Remote MW1 size = 0x200000
> [43980.228583] switchtec switchtec0: MW 1: part 0 addr
> 0x00000010d1800000 size 0x0000000000200000
> [43983.250163] switchtec switchtec0: stuser_create: 00000000992004c6
> [43983.250168] switchtec switchtec0: switchtec_dev_open: 00000000992004c6
> [43983.250326] switchtec switchtec0: stuser_free: 00000000992004c6
> [43987.894388] switchtec switchtec0: stuser_create: 00000000ed0f26a7
> [43987.894394] switchtec switchtec0: switchtec_dev_open: 00000000ed0f26a7
> [43987.894556] switchtec switchtec0: stuser_free: 00000000ed0f26a7
> [44003.236857] switchtec 0000:3b:00.1: Using DMA memcpy for TX
> [44003.236862] switchtec 0000:3b:00.1: Using DMA memcpy for RX
> [44003.239410] switchtec 0000:3b:00.1: NTB Transport QP 0 created
> [44003.243226] switchtec 0000:3b:00.1: eth0 created
> [44003.248706] ntb_netdev ntb_netdev0 priv0: renamed from eth0
> ...
> [44104.815744] switchtec switchtec0: stuser_create: 000000007ed96477
> [44104.815751] switchtec switchtec0: switchtec_dev_open: 000000007ed96477
> [44104.816022] switchtec switchtec0: stuser_free: 000000007ed96477
> [44104.836171] switchtec switchtec0: stuser_create: 00000000199ff872
> [44104.836175] switchtec switchtec0: switchtec_dev_open: 00000000199ff872
> [44104.836345] switchtec switchtec0: stuser_free: 00000000199ff872
> [44104.858108] switchtec switchtec0: stuser_create: 00000000d04b93c8
> [44104.858113] switchtec switchtec0: switchtec_dev_open: 00000000d04b93c8
> [44104.858264] switchtec switchtec0: stuser_free: 00000000d04b93c8
> [44104.879259] switchtec switchtec0: stuser_create: 00000000b2930931
> [44104.879263] switchtec switchtec0: switchtec_dev_open: 00000000b2930931
> [44104.879425] switchtec switchtec0: stuser_free: 00000000b2930931
> [44104.898693] switchtec switchtec0: stuser_create: 000000009f08a557
> [44104.898697] switchtec switchtec0: switchtec_dev_open: 000000009f08a557
> [44104.898856] switchtec switchtec0: stuser_free: 000000009f08a557
> [44104.920456] switchtec switchtec0: stuser_create: 0000000092c59794
> [44104.920461] switchtec switchtec0: switchtec_dev_open: 0000000092c59794
> [44104.920626] switchtec switchtec0: stuser_free: 0000000092c59794
> [44104.939554] switchtec switchtec0: stuser_create: 00000000778eabf3
> [44104.939559] switchtec switchtec0: switchtec_dev_open: 00000000778eabf3
> [44104.939735] switchtec switchtec0: stuser_free: 00000000778eabf3
> [44104.961929] switchtec switchtec0: stuser_create: 0000000087ec0e77
> [44104.961934] switchtec switchtec0: switchtec_dev_open: 0000000087ec0e77
> [44104.962100] switchtec switchtec0: stuser_free: 0000000087ec0e77
> [44104.983607] switchtec switchtec0: stuser_create: 000000001677deb0
> [44104.983611] switchtec switchtec0: switchtec_dev_open: 000000001677deb0
> [44104.983761] switchtec switchtec0: stuser_free: 000000001677deb0
> [44105.004798] switchtec switchtec0: stuser_create: 00000000c505781c
> [44105.004803] switchtec switchtec0: switchtec_dev_open: 00000000c505781c
> [44105.004962] switchtec switchtec0: stuser_free: 00000000c505781c
> [44105.024035] switchtec switchtec0: stuser_create: 00000000772c0769
> [44105.024040] switchtec switchtec0: switchtec_dev_open: 00000000772c0769
> [44105.024195] switchtec switchtec0: stuser_free: 00000000772c0769
> [44105.045032] switchtec switchtec0: stuser_create: 00000000c48dc21b
> [44105.045037] switchtec switchtec0: switchtec_dev_open: 00000000c48dc21b
> [44105.045189] switchtec switchtec0: stuser_free: 00000000c48dc21b
> [44105.066256] switchtec switchtec0: stuser_create: 000000004436beee
> [44105.066261] switchtec switchtec0: switchtec_dev_open: 000000004436beee
> [44105.066421] switchtec switchtec0: stuser_free: 000000004436beee
> [44105.087705] switchtec switchtec0: stuser_create: 0000000052b38058
> [44105.087710] switchtec switchtec0: switchtec_dev_open: 0000000052b38058
> [44105.087920] switchtec switchtec0: stuser_free: 0000000052b38058
> [44105.107527] switchtec switchtec0: stuser_create: 000000005b15e6d3
> [44105.107532] switchtec switchtec0: switchtec_dev_open: 000000005b15e6d3
> [44105.107718] switchtec switchtec0: stuser_free: 000000005b15e6d3
> [44105.130832] switchtec switchtec0: stuser_create: 000000005379e8de
> [44105.130836] switchtec switchtec0: switchtec_dev_open: 000000005379e8de
> [44105.131069] switchtec switchtec0: stuser_free: 000000005379e8de
> [44105.153557] switchtec switchtec0: stuser_create: 000000001671f313
> [44105.153561] switchtec switchtec0: switchtec_dev_open: 000000001671f313
> [44105.153711] switchtec switchtec0: stuser_free: 000000001671f313
> [44105.175527] switchtec switchtec0: stuser_create: 00000000fdbb9319
> [44105.175532] switchtec switchtec0: switchtec_dev_open: 00000000fdbb9319
> [44105.175679] switchtec switchtec0: stuser_free: 00000000fdbb9319
> [44105.196070] switchtec switchtec0: stuser_create: 000000002b86a7a3
> [44105.196075] switchtec switchtec0: switchtec_dev_open: 000000002b86a7a3
> [44105.196275] switchtec switchtec0: stuser_free: 000000002b86a7a3
> [44105.218913] switchtec switchtec0: stuser_create: 0000000018a2de0b
> [44105.218917] switchtec switchtec0: switchtec_dev_open: 0000000018a2de0b
> [44105.219085] switchtec switchtec0: stuser_free: 0000000018a2de0b
> [44105.240357] switchtec switchtec0: stuser_create: 00000000f712e033
> [44105.240361] switchtec switchtec0: switchtec_dev_open: 00000000f712e033
> [44105.240528] switchtec switchtec0: stuser_free: 00000000f712e033
> [44105.261698] switchtec switchtec0: stuser_create: 0000000023550788
> [44105.261702] switchtec switchtec0: switchtec_dev_open: 0000000023550788
> [44105.261843] switchtec switchtec0: stuser_free: 0000000023550788
> [44105.283558] switchtec switchtec0: stuser_create: 000000004724602a
> [44105.283562] switchtec switchtec0: switchtec_dev_open: 000000004724602a
> [44105.283714] switchtec switchtec0: stuser_free: 000000004724602a
> [44105.305739] switchtec switchtec0: stuser_create: 00000000a925ed10
> [44105.305744] switchtec switchtec0: switchtec_dev_open: 00000000a925ed10
> [44105.305918] switchtec switchtec0: stuser_free: 00000000a925ed10
> [44112.393253] switchtec switchtec0: stuser_create: 00000000fc673562
> [44112.393259] switchtec switchtec0: switchtec_dev_open: 00000000fc673562
> [44112.393435] switchtec switchtec0: stuser_free: 00000000fc673562
> [44112.615032] switchtec switchtec0: stuser_create: 000000006fea71d7
> [44112.615037] switchtec switchtec0: switchtec_dev_open: 000000006fea71d7
> [44112.615193] switchtec switchtec0: stuser_free: 000000006fea71d7
> [44112.644369] switchtec switchtec0: stuser_create: 00000000154869b1
> [44112.644374] switchtec switchtec0: switchtec_dev_open: 00000000154869b1
> [44112.644537] switchtec switchtec0: stuser_free: 00000000154869b1
> [44221.644483] switchtec 0000:3b:00.1: Remote QP link status = 1
> [44221.644488] switchtec 0000:3b:00.1: qp 0: Link Up
> [44221.644493] ntb_netdev ntb_netdev0 priv0: Event 1, Link 1
> [44221.644504] switchtec 0000:3b:00.1: ntb_transport_rxc_db: doorbell 0 received
> [44221.644508] switchtec 0000:3b:00.1: qp 0: RX ver 0 len 0 flags 0
> [44221.644510] switchtec 0000:3b:00.1: done flag not set
> [44221.661578] switchtec switchtec0: doorbell
> [44221.661586] switchtec 0000:3b:00.1: ntb_transport_rxc_db: doorbell 0 received
> [44221.661590] switchtec 0000:3b:00.1: qp 0: RX ver 0 len 90 flags 1
> [44221.661594] switchtec 0000:3b:00.1: RX OK index 0 ver 0 size 90
> into buf size 65524
> [44221.661599] ntb_netdev ntb_netdev0 priv0: ntb_netdev_rx_handler: 90
> byte payload received
> [44221.661661] switchtec 0000:3b:00.1: qp 0: RX ver 0 len 0 flags 0
> [44221.661663] switchtec 0000:3b:00.1: done flag not set
> [44221.661777] switchtec 0000:3b:00.1: ntb_transport_rxc_db: doorbell 0 received
> [44221.661780] switchtec 0000:3b:00.1: qp 0: RX ver 0 len 0 flags 0
> [44221.661782] switchtec 0000:3b:00.1: done flag not set
> [44221.676760] switchtec 0000:3b:00.1: qp 0: Send Link Down
> [44221.676781] switchtec 0000:3b:00.1: Remote QP link status = 1
> [44221.676784] switchtec 0000:3b:00.1: qp 0: Link Up
> [44221.676788] ntb_netdev ntb_netdev0 priv0: Event 1, Link 1
> [44221.676800] switchtec 0000:3b:00.1: ntb_transport_rxc_db: doorbell 0 received
> [44221.676803] switchtec 0000:3b:00.1: qp 0: RX ver 0 len 90 flags 0
> [44221.676806] switchtec 0000:3b:00.1: done flag not set
> [44249.359502] switchtec switchtec0: stuser_create: 00000000992004c6
> [44249.359508] switchtec switchtec0: switchtec_dev_open: 00000000992004c6
> [44249.359716] switchtec switchtec0: stuser_free: 00000000992004c6
> [44249.414933] switchtec switchtec0: stuser_create: 000000009c6b42ce
> [44249.414937] switchtec switchtec0: switchtec_dev_open: 000000009c6b42ce
> [44249.415128] switchtec switchtec0: stuser_free: 000000009c6b42ce
> 
> # cat /sys/kernel/debug/ntb_transport/0000\:3b\:00.1/qp0/stats
> NTB QP stats:
> 
> rx_bytes - 0
> rx_pkts - 0
> rx_memcpy - 0
> rx_async - 0
> rx_ring_empty - 1
> rx_err_no_buf - 0
> rx_err_oflow - 0
> rx_err_ver - 0
> rx_buff - 0x00000000fbb8882b
> rx_index - 0
> rx_max_entry - 31
> rx_alloc_entry - 100
> 
> tx_bytes - 866
> tx_pkts - 11
> tx_memcpy - 11
> tx_async - 0
> tx_ring_full - 0
> tx_err_no_buf - 0
> tx_mw - 0x000000003c9d9493
> tx_index (H) - 11
> RRI (T) - 10
> tx_max_entry - 31
> free tx - 30
> 
> Using TX DMA - Yes
> Using RX DMA - Yes
> QP Link - Up
> 
> # ifconfig priv0
> priv0     Link encap:Ethernet  HWaddr E6:BF:E8:6F:4F:A5
>           inet addr:10.17.21.198  Bcast:10.17.21.199  Mask:255.255.255.252
>           inet6 addr: fe80::e4bf:e8ff:fe6f:4fa5/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:1 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:26 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000
>           RX bytes:90 (90.0 B)  TX bytes:1496 (1.4 KiB)
> 
> 
> The information from the kernel debug sysfs attribute files seems to
> be consistent when this condition occurs on one side:
> - tx_ring_full is constantly increasing
> - "tx_index (H)" and "RRI (T)" are both 0
> 
> So perhaps data is filling the transmit buffer, but not being read
> (received) by the other side?
> 
> In the cases where both controllers/nodes boot up and the NTB virtual
> Ethernet comes up/functions normally, I can usually induce the problem
> by perform a series of interface down/up's using this loop from one
> side (controller/node):
> peer_ip=<IP_OF_PEER>; delay=5; iter=1; while true; do echo "iteration
> ${iter}..."; echo down; ifconfig priv0 down; echo "sleep ${delay}";
> sleep ${delay}; echo up; ifconfig priv0 up; sleep 2; ping -c 1 -w 1
> ${peer_ip} || break; echo "sleep ${delay}"; sleep ${delay}; iter=$((
> iter + 1 )); echo; done
> 
> Sometimes it gets into this state after just one or a handful of
> iterations, other times it can take 500+ iterations before it happens.
> 
> Any help/tips debugging this would be greatly appreciated. And if the
> 'netdev' mailing list is more appropriate for this inquiry, please
> advise and I'll re-post there.
> 
> Thanks for your time/consideration.
> 
> 
> --Marc
> 
