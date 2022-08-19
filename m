Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B1E3C13;
	Fri, 19 Aug 2022 15:46:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZC3b4QGBXQxvt8WZrgMqremJZ3xaMHEYKJKQ3vD2tQ3GbmPrpZWGRBcaBU02N+V+mhRdT2uBZck8dLcTiK/uPX0adLu9WDgjrkMdRr5gY691q2dRGvPpbnz1UzHlNHL/lDOu4lLIALkwCIZBF7N9mzuhVZmPmoMT6CEciHK+vaUBiJvnu7Wk5P7nPimYv9TaqHk0l95TB2fU5+tNnQl5nVmsvAwEZH2N8JInF43+7Ys+mE3EOW1MO7vsHDyMEk0dB419/U4pcW/fm/Atm+EldU1irBQS5JOFA3mfiniYufTE3KywRapYH648L0PxiBsd+O7EvFWF5rvSQ6IO6Ij9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGR/h5ur/6lINcfekEqcl51gCF0ChQias2qxvdNnit4=;
 b=iDMS5rhIXLRWbHHcsM2SkaxzpBrfNfrWoYRY4gAjJpsHlQ6yMcr4//9z5oCExBtbNEmRrPxHnzt4wYHH3NfvGZX74AZi6ssxp5I/iICK+IGmH6QBOu5Cd1BqR4yGY0p+BTOz/lfZz7QZyGlNgEcAeMdbd1xPMoNCO2U8YrL/gQ7n/SfIOTEcHmlBJJoc4ck4N54n2kO/adPuLyRlwB5GZARxeHeDzOA97EwIf2F3AlzVxfrCXFxUkl4fa59D/5B6EO/crhFvvxeDVdmF+vEjhwOK9dxamLoA2yqjF0J5ue2rGboTbyNJ3QCDqNMJd0tFulIK33TqlNZlysnaWiuvqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGR/h5ur/6lINcfekEqcl51gCF0ChQias2qxvdNnit4=;
 b=sNZd9Q5Be24fSt+i7sWqWKmJn10gHXU8cT9C2oNTfuTy6C/q3339n7EQ/34vKOeKxVwStlbvgb1w9gAijeEXsaNHC/K4OXW246lSGNEUh/Pn/52AIg4GAXZUNcN1+5KoZYZNg5NOI86TBA48Z62HV9awQVopIE8Aqk0LDLkuDDU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM6PR12MB3209.namprd12.prod.outlook.com (2603:10b6:5:184::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Fri, 19 Aug
 2022 15:45:41 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0%4]) with mapi id 15.20.5546.019; Fri, 19 Aug 2022
 15:45:41 +0000
Message-ID: <fa2b1f1a-75e9-fd4c-aa23-84653562c346@amd.com>
Date: Fri, 19 Aug 2022 10:45:29 -0500
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
 Samuel Chessman <chessman@tux.org>, Geoff Levand <geoff@infradead.org>,
 Ishizaki Kou <kou.ishizaki@toshiba.co.jp>,
 Kevin Brace <kevinbrace@bracecomputerlab.com>,
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
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20220818210050.7108-1-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0017.prod.exchangelabs.com (2603:10b6:805:b6::30)
 To DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b82f79c-7949-4884-2bfe-08da81f9de57
X-MS-TrafficTypeDiagnostic: DM6PR12MB3209:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZteHoRmLxbfwm6jZ/m822qi1d6UtkWUEs/ONSw4pKCiSTnbxT2ffTT3PrI/No4j/AmKWjZNkvR+Ls9Up8QJWoZSybmiOUF7HLY6r9ONkuwXsiAPmEcj1wyfnvwiUCEhzUdk90ROuJ5mie8/cB2Xhs9on+fvmXcPBlr4LmIynfHhSdrpfJblnVUuNTZaRR7cotBAEPbhtjSyjwd+uU8CrpuYauDAlHes9IoTePXWS3i9z3AX7xeSUwNMWz6Y5B8vjQmVvxWftB1ESl5dnWCxzP2i8aFI8U3jXi2UUCCPYkTvEpHVb3SWep1eQr8pX5LyGGRAXOuvEOAPkS5jlk+KPWZ3qKLiEjFMR1DaB93KuKdnGJne5LamyOaWdT9xNpN2U2BcBb8fy3vBn3al6E9ZeAyRDwf0pJtUl/AIll7wXdPtBm7jtVmDslvUPMzLpuF9ckPJwnJxzS3RJjzGlgaK3e4X8LmdqgUY7UO7LxFoBFBSm2Mr+kCQu1HYoms0C0ydzSjcwYMXS9tqeuKDeYOo78TRjK9pwu7okEnRwiTYR8FFp7u3SIOjsyTdNK3m6eXPhzQt56pIzWh0pxbGqGAEqvfud7C0bCSn0sRonubJ67wOd8XycCdKbTk3Yvi3PhmtAXsNfe4E1E29510ts44IlbXfVsQMGdMQr+Xj1SQZ4d8mpoPh+IpUt2iTCHgmWmg/OJZiP2wqQUi1lVxnsrbfuH8ZDSzjyIrtRGeCIiL0V0keMIKTXDJPi7sdjYWxIuHXwlav9LMTMhdZPyiX6rgEjO2eG3l/7/TC7WsbLr3WWzCGqaokl9t79C5CMg7NSA3O9Ht39KJLkAwKuXjuPMipSzc/i2ptv9UHZpHrqF2rPxMs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(8676002)(66476007)(7276002)(7416002)(7406005)(5660300002)(66946007)(7336002)(38100700002)(4326008)(2906002)(7366002)(186003)(8936002)(66556008)(31696002)(86362001)(6506007)(54906003)(6486002)(6512007)(6666004)(316002)(36756003)(41300700001)(966005)(26005)(53546011)(478600001)(31686004)(2616005)(156123004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mkh0K3BFQlNZUXJ1N2dIQVRMTDhpR29ic2RWWmdVS0RZSnFkSUhzZ205UVMv?=
 =?utf-8?B?WngrVjdsTmRnVi9vbUZVcS9aL0VKYjZ2WU1La0RwYkFOL0pSY211TVJDT2tP?=
 =?utf-8?B?Q1RhOEFQTG9HSVNEc00wcGlkdkg5LytTQS83TU5OcUZJNlRMWm9vNUhTclQz?=
 =?utf-8?B?WE9tMDhReWRmZkxtQ3JackJzNFJmaHA3dGQ2MTNkUGlaSkVTa1RoQ1ZPMnRK?=
 =?utf-8?B?NHlqWXZNZWlGUHZ2dWFoejF6RkpMUmxUcE1SWEVIQkVGeTYxWVArNlg5NmFW?=
 =?utf-8?B?S2QrTUx6L2VxbkZIbHVjWlAvaWtnaE9lNlB2eWljQWVoc0c5cjRLRWcwZXRY?=
 =?utf-8?B?TmhJcW5wZkRaaFdqR0k1OWFPZ25iMnRIZ21IWTcyaktmeElVTEZIR0hRcG9C?=
 =?utf-8?B?WEtIMzBUQVJtRU9BV1Y4VDEzQW5KMmlubWVoS1VuKy9QQzZnb3lyQ2lBVW5R?=
 =?utf-8?B?SnhzMXM3MXc1TWp2OFBaMURuNWx5RDFNTWV3eVpHUU8xR1dvSEJMbG1RUEFH?=
 =?utf-8?B?VEJBT3B0ZVR1b0JrbkVnYml0L1pvRDJNNmVLNWdmRlJjRkVSdmVERFZmS29K?=
 =?utf-8?B?bEwzL0QrcWhxZzdGUU9BMko3QTFKamlsbWdNTFMzcUVENmgrL0ZqbStQZzBD?=
 =?utf-8?B?YlljWXhDdUJaUVV0NXZFMzlKWjY5TEFtKzg4UGl0cWFiaVpVRHBRYVhYMGxT?=
 =?utf-8?B?ZEJoTWxyc0txWFlPRExON1dOMDh2ay9Bc0Z0RUk4TnNlNGM2Ty9ySXFWN2t5?=
 =?utf-8?B?d1FpZnlkeUVNT3ZVOEw1MUpoV1J3cDliclA5aWFYY2dtTWg4Q0dibXlRZ2ZY?=
 =?utf-8?B?dlJJc0NHRkdPai95Wlh4aTQwTTdWRFU4dldHNDJJTUhKRTN0QkFJTHFJdzRC?=
 =?utf-8?B?K09raVRTWStyOFpYTFl3ZHFjOTU3OUxxTWtpVzNzZUtEODNRSnQrMDU1bFMw?=
 =?utf-8?B?VVlsL3ZWVllJeWEwTUtoYnBqajZkNUYwbUIwNXUvWWx0S2JSU3M4a3BwQnRC?=
 =?utf-8?B?QTdwcEkyVVdWemhFN09PelZsMmZRVGJvRzlkUFBpNS9GTGR4d2JZT2tYeVhI?=
 =?utf-8?B?Y2VlclVlMFpHRmxrOVQybTc1Y3lsRlQxVlVRTCtBcTk1UDk1clRGUGJKcHNu?=
 =?utf-8?B?elYyQzhTdGY0eEZpNjE0NVJvbWRib2RueTZJeDV6OWYyTmlTTEtKRWxoaEQv?=
 =?utf-8?B?M3E0SUhuUVR6dzBMZW9DTkcxN3ZnMTZxRGtSZjRLMWRVN2ZaRlZVeDdIYk9E?=
 =?utf-8?B?N1d4SFRTbmhBN3B5cHFZc3FwcktDTHRKcG5VcENCY0RycDA4M0NTQitOZGVS?=
 =?utf-8?B?YkVKMnRNaHVFNFJzZDVxYlFNVGlZaWpLTkZzaFZwZjJraGFDeVkyN2x4V2JT?=
 =?utf-8?B?dExVYkdlN1c3VmtnNkRTY0dPdVE2VG1VaUFKZUJjb0E4aU41ZmdjRElCSkJO?=
 =?utf-8?B?RVJidW4rSWtrZE9sSW0ybkFVRTlLYi9CRDErcVhrK1JHa2ZaRlR5SzQ3LzJu?=
 =?utf-8?B?eUNKaHpOZmJZNy95NWw2cExxZCtIekNDaUIxejNZWmNwWDR0eHd1eTVhUEMx?=
 =?utf-8?B?LzVoS0ZNeTQvN0tIN1pvZXltN2U4QTg5dGZ0RFNSNy9iNlNxc3B1MklEWEl2?=
 =?utf-8?B?UzJPdkJtTDBHTCtxWjBkejhheXBkYS9WYUorSCtyeEFoUGxXN2E1WlptdTVG?=
 =?utf-8?B?UnRVVzZvYlJqbCt6YmUvaThpTW9YRGZ3ZStWQTdPQ1FvL1lwM2tmL0V6WWkv?=
 =?utf-8?B?NWVpVENQdlhZeVdaUzd0dU5WOVhFMW0yejFVZDcxM1RWaGl4MlpNZHpsSEpt?=
 =?utf-8?B?YnVWVGRDWUhVWm5zVWZXNWgwbFg3RytFSkNhZ3ZtZFZTK3EzQjU2RCt1bEZI?=
 =?utf-8?B?cmw0N0RvbUx0RUE3RHN1RXREMnpDZDFXU3d3b2ZvRUFOUzBJK0NVL1pJQzN0?=
 =?utf-8?B?SUNaYlk2QnVYenpFR1UzSWs0dm91SHFzaXE5b05MTGxNUWRxQUtXUVhyWkI2?=
 =?utf-8?B?NlVwWGVicmFpdVZYUkNreVVmVTNpdFRkUmRwVXFhVmkvYy8zSnhPNmdmdmcx?=
 =?utf-8?B?Yzl2ZncycWVXa2R2U1B0bDlsMERVL1N5SVZyRW1iczNYaXM4T0xjMUNDMTdt?=
 =?utf-8?Q?8Q6XuVolMB12+qnLKZQiH0UCv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b82f79c-7949-4884-2bfe-08da81f9de57
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 15:45:41.1710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5OQvtGaYQQ/mRAfcqdhk3xY/TVuUnV5vAa4Wrn3PtwPteCUy55DZQEn4CtoewIpMoI2EYa9IE0hyqAgib4fTmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3209

On 8/18/22 16:00, Wolfram Sang wrote:
> Follow the advice of the below link and prefer 'strscpy' in this
> subsystem. Conversion is 1:1 because the return value is not used.
> Generated by a coccinelle script.
> 
> Link: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---

> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
> index 6ceb1cdf6eba..6e83ff59172a 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
> @@ -402,8 +402,8 @@ static void xgbe_get_drvinfo(struct net_device *netdev,
>   	struct xgbe_prv_data *pdata = netdev_priv(netdev);
>   	struct xgbe_hw_features *hw_feat = &pdata->hw_feat;
>   
> -	strlcpy(drvinfo->driver, XGBE_DRV_NAME, sizeof(drvinfo->driver));
> -	strlcpy(drvinfo->bus_info, dev_name(pdata->dev),
> +	strscpy(drvinfo->driver, XGBE_DRV_NAME, sizeof(drvinfo->driver));
> +	strscpy(drvinfo->bus_info, dev_name(pdata->dev),
>   		sizeof(drvinfo->bus_info));
>   	snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version), "%d.%d.%d",
>   		 XGMAC_GET_BITS(hw_feat->version, MAC_VR, USERVER),

For drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

