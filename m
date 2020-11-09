Return-Path: <sherry.sun@nxp.com>
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60076.outbound.protection.outlook.com. [40.107.6.76])
        by gmr-mx.google.com with ESMTPS id o4si245606wrx.4.2020.11.09.01.37.02
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2020 01:37:02 -0800 (PST)
From: Sherry Sun <sherry.sun@nxp.com>
Subject: RE: [PATCH v7 15/18] NTB: Add support for EPF PCI-Express
 Non-Transparent Bridge
Date: Mon, 9 Nov 2020 09:37:00 +0000
Message-ID: 
 <VI1PR04MB496061EAB6F249F1C394F01092EA0@VI1PR04MB4960.eurprd04.prod.outlook.com>
References: <20200930153519.7282-16-kishon@ti.com>
In-Reply-To: <20200930153519.7282-16-kishon@ti.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: "kishon@ti.com" <kishon@ti.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "arnd@arndb.de" <arnd@arndb.de>, "jdmason@kudzu.us" <jdmason@kudzu.us>, "dave.jiang@intel.com" <dave.jiang@intel.com>, "allenbh@gmail.com" <allenbh@gmail.com>, "tjoseph@cadence.com" <tjoseph@cadence.com>, Rob Herring <robh@kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

Hi Kishon,

> Subject: [PATCH v7 15/18] NTB: Add support for EPF PCI-Express Non-
> Transparent Bridge
>=20
> From: Kishon Vijay Abraham I <kishon@ti.com>
>=20
> Add support for EPF PCI-Express Non-Transparent Bridge (NTB) device.
> This driver is platform independent and could be used by any platform whi=
ch
> have multiple PCIe endpoint instances configured using the pci-epf-ntb dr=
iver.
> The driver connnects to the standard NTB sub-system interface. The EPF NT=
B
> device has configurable number of memory windows (Max 4), configurable
> number of doorbell (Max 32), and configurable number of scratch-pad
> registers.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/ntb/hw/Kconfig          |   1 +
>  drivers/ntb/hw/Makefile         |   1 +
>  drivers/ntb/hw/epf/Kconfig      |   6 +
>  drivers/ntb/hw/epf/Makefile     |   1 +
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 755
> ++++++++++++++++++++++++++++++++
>  5 files changed, 764 insertions(+)
>  create mode 100644 drivers/ntb/hw/epf/Kconfig  create mode 100644
> drivers/ntb/hw/epf/Makefile  create mode 100644
> drivers/ntb/hw/epf/ntb_hw_epf.c
>=20
> diff --git a/drivers/ntb/hw/Kconfig b/drivers/ntb/hw/Kconfig index
> e77c587060ff..c325be526b80 100644
> --- a/drivers/ntb/hw/Kconfig
> +++ b/drivers/ntb/hw/Kconfig
> @@ -2,4 +2,5 @@
>  source "drivers/ntb/hw/amd/Kconfig"
>  source "drivers/ntb/hw/idt/Kconfig"
>  source "drivers/ntb/hw/intel/Kconfig"
> +source "drivers/ntb/hw/epf/Kconfig"
>  source "drivers/ntb/hw/mscc/Kconfig"
> diff --git a/drivers/ntb/hw/Makefile b/drivers/ntb/hw/Makefile index
> 4714d6238845..223ca592b5f9 100644
> --- a/drivers/ntb/hw/Makefile
> +++ b/drivers/ntb/hw/Makefile
> @@ -2,4 +2,5 @@
>  obj-$(CONFIG_NTB_AMD)	+=3D amd/
>  obj-$(CONFIG_NTB_IDT)	+=3D idt/
>  obj-$(CONFIG_NTB_INTEL)	+=3D intel/
> +obj-$(CONFIG_NTB_EPF)	+=3D epf/
>  obj-$(CONFIG_NTB_SWITCHTEC) +=3D mscc/
> diff --git a/drivers/ntb/hw/epf/Kconfig b/drivers/ntb/hw/epf/Kconfig new
> file mode 100644 index 000000000000..6197d1aab344
> --- /dev/null
> +++ b/drivers/ntb/hw/epf/Kconfig
> @@ -0,0 +1,6 @@
> +config NTB_EPF
> +	tristate "Generic EPF Non-Transparent Bridge support"
> +	depends on m
> +	help
> +	  This driver supports EPF NTB on configurable endpoint.
> +	  If unsure, say N.
> diff --git a/drivers/ntb/hw/epf/Makefile b/drivers/ntb/hw/epf/Makefile ne=
w
> file mode 100644 index 000000000000..2f560a422bc6
> --- /dev/null
> +++ b/drivers/ntb/hw/epf/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_NTB_EPF) +=3D ntb_hw_epf.o
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c
> b/drivers/ntb/hw/epf/ntb_hw_epf.c new file mode 100644 index
> 000000000000..0a144987851a
> --- /dev/null
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -0,0 +1,755 @@
......
> +static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
> +			    struct pci_dev *pdev)
> +{
> +	struct device *dev =3D ndev->dev;
> +	int ret;
> +
> +	pci_set_drvdata(pdev, ndev);
> +
> +	ret =3D pci_enable_device(pdev);
> +	if (ret) {
> +		dev_err(dev, "Cannot enable PCI device\n");
> +		goto err_pci_enable;
> +	}
> +
> +	ret =3D pci_request_regions(pdev, "ntb");
> +	if (ret) {
> +		dev_err(dev, "Cannot obtain PCI resources\n");
> +		goto err_pci_regions;
> +	}
> +
> +	pci_set_master(pdev);
> +
> +	ret =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +	if (ret) {
> +		ret =3D dma_set_mask_and_coherent(dev,
> DMA_BIT_MASK(32));
> +		if (ret) {
> +			dev_err(dev, "Cannot set DMA mask\n");
> +			goto err_dma_mask;
> +		}
> +		dev_warn(&pdev->dev, "Cannot DMA highmem\n");
> +	}
> +
> +	ndev->ctrl_reg =3D pci_iomap(pdev, 0, 0);

The second parameter of pci_iomap should be ndev->ctrl_reg_bar instead of t=
he hardcode value 0, right?

> +	if (!ndev->ctrl_reg) {
> +		ret =3D -EIO;
> +		goto err_dma_mask;
> +	}
> +
> +	ndev->peer_spad_reg =3D pci_iomap(pdev, 1, 0);

pci_iomap(pdev, ndev->peer_spad_reg_bar, 0);

> +	if (!ndev->peer_spad_reg) {
> +		ret =3D -EIO;
> +		goto err_dma_mask;
> +	}
> +
> +	ndev->db_reg =3D pci_iomap(pdev, 2, 0);

pci_iomap(pdev, ndev->db_reg_bar, 0);

Best Regards
Sherry
