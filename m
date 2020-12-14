Return-Path: <tjoseph@cadence.com>
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com. [208.86.201.193])
        by gmr-mx.google.com with ESMTPS id e19si1465078pgv.4.2020.12.14.09.57.10
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Dec 2020 09:57:10 -0800 (PST)
From: Tom Joseph <tjoseph@cadence.com>
Subject: RE: [PATCH v8 11/18] PCI: cadence: Implement ->msi_map_irq() ops
Date: Mon, 14 Dec 2020 17:56:59 +0000
Message-ID: 
 <MN2PR07MB620832AC733463A0702A6155A1C70@MN2PR07MB6208.namprd07.prod.outlook.com>
References: <20201111153559.19050-1-kishon@ti.com>
 <20201111153559.19050-12-kishon@ti.com>
In-Reply-To: <20201111153559.19050-12-kishon@ti.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>


> -----Original Message-----
> From: Kishon Vijay Abraham I <kishon@ti.com>
>=20
> Implement ->msi_map_irq() ops in order to map physical address to
> MSI address and return MSI data.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../pci/controller/cadence/pcie-cadence-ep.c  | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>=20

Reviewed-by: Tom Joseph <tjoseph@cadence.com>
