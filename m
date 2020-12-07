Return-Path: <dave.jiang@intel.com>
Received: from mga01.intel.com (mga01.intel.com. [192.55.52.88])
        by gmr-mx.google.com with ESMTPS id r207si178396vkf.2.2020.12.07.07.55.45
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 07:55:45 -0800 (PST)
From: "Jiang, Dave" <dave.jiang@intel.com>
Subject: RE: [PATCH v8 16/18] NTB: tool: Enable the NTB/PCIe link on the local
 or remote side of bridge
Date: Mon, 7 Dec 2020 15:55:43 +0000
Message-ID: <f39cf769993541e2a46bfe4d777ccf46@intel.com>
References: <20201111153559.19050-1-kishon@ti.com>
 <20201111153559.19050-17-kishon@ti.com>
In-Reply-To: <20201111153559.19050-17-kishon@ti.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Return-Path: dave.jiang@intel.com
To: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, Tom Joseph <tjoseph@cadence.com>, Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>



> -----Original Message-----
> From: Kishon Vijay Abraham I <kishon@ti.com>
> Sent: Wednesday, November 11, 2020 8:36 AM
> To: Bjorn Helgaas <bhelgaas@google.com>; Jonathan Corbet
> <corbet@lwn.net>; Kishon Vijay Abraham I <kishon@ti.com>; Lorenzo
> Pieralisi <lorenzo.pieralisi@arm.com>; Arnd Bergmann <arnd@arndb.de>;
> Jon Mason <jdmason@kudzu.us>; Jiang, Dave <dave.jiang@intel.com>;
> Allen Hubbe <allenbh@gmail.com>; Tom Joseph <tjoseph@cadence.com>;
> Rob Herring <robh@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; linux-
> pci@vger.kernel.org; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-ntb@googlegroups.com
> Subject: [PATCH v8 16/18] NTB: tool: Enable the NTB/PCIe link on the loca=
l or
> remote side of bridge
>=20
> Invoke ntb_link_enable() to enable the NTB/PCIe link on the local or remo=
te
> side of the bridge.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/ntb/test/ntb_tool.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c in=
dex
> b7bf3f863d79..8230ced503e3 100644
> --- a/drivers/ntb/test/ntb_tool.c
> +++ b/drivers/ntb/test/ntb_tool.c
> @@ -1638,6 +1638,7 @@ static int tool_probe(struct ntb_client *self, stru=
ct
> ntb_dev *ntb)
>=20
>  	tool_setup_dbgfs(tc);
>=20
> +	ntb_link_enable(ntb, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);

The tool expects the user to enable the link via debugfs according to docum=
entation. Is this necessary?

>  	return 0;
>=20
>  err_clear_mws:
> --
> 2.17.1

