Return-Path: <tjoseph@cadence.com>
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com. [208.84.65.235])
        by gmr-mx.google.com with ESMTPS id j124si1361064pfb.2.2020.12.14.09.56.59
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Dec 2020 09:56:59 -0800 (PST)
From: Tom Joseph <tjoseph@cadence.com>
Subject: RE: [PATCH v8 12/18] PCI: cadence: Configure LM_EP_FUNC_CFG based on
 epc->function_num_map
Date: Mon, 14 Dec 2020 17:56:42 +0000
Message-ID: 
 <MN2PR07MB6208137D0A15339D083FA187A1C70@MN2PR07MB6208.namprd07.prod.outlook.com>
References: <20201111153559.19050-1-kishon@ti.com>
 <20201111153559.19050-13-kishon@ti.com>
In-Reply-To: <20201111153559.19050-13-kishon@ti.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Rob Herring <robh@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

> -----Original Message-----
> From: Kishon Vijay Abraham I <kishon@ti.com>
> Sent: 11 November 2020 15:36
>=20
> The number of functions supported by the endpoint controller is
> configured in LM_EP_FUNC_CFG based on func_no member of struct
> pci_epf.
> Now that an endpoint function can be associated with two endpoint
> controllers (primary and secondary), just using func_no will
> not suffice as that will take into account only if the endpoint
> controller is associated with the primary interface of endpoint
> function. Instead use epc->function_num_map which will already have the
> configured functions information (irrespective of whether the endpoint
> controller is associated with primary or secondary interface).
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-ep.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>=20

Reviewed-by: Tom Joseph <tjoseph@cadence.com>
