Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com. [168.159.213.141])
        by gmr-mx.google.com with ESMTPS id j19si1933342ywg.7.2016.01.19.12.30.25
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jan 2016 12:30:25 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <1453205805-851-1-git-send-email-Xiangliang.Yu@amd.com>
In-Reply-To: <1453205805-851-1-git-send-email-Xiangliang.Yu@amd.com>
Subject: RE: [PATCH V4 1/1] NTB: Add support for AMD PCI-Express Non-Transparent Bridge
Date: Tue, 19 Jan 2016 15:30:04 -0500
Message-ID: <000301d152f8$2e7a7780$8b6f6680$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
To: 'Xiangliang Yu' <Xiangliang.Yu@amd.com>, jdmason@kudzu.us, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
Cc: SPG_Linux_Kernel@amd.com
List-ID: <linux-ntb.googlegroups.com>

From: Xiangliang Yu <Xiangliang.Yu@amd.com>
> This adds support for AMD's PCI-Express Non-Transparent Bridge
> (NTB) device on the Zeppelin platform. The driver connnects to the
> standard NTB sub-system interface, with modification to add hooks
> for power management in a separate patch. The AMD NTB device has 3
> memory windows, 16 doorbell, 16 scratch-pad registers, and supports
> up to 16 PCIe lanes running a Gen3 speeds.
>=20
> Signed-off-by: Xiangliang Yu <Xiangliang.Yu@amd.com>

> +static int amd_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
> +				dma_addr_t addr, resource_size_t size)
> +{

There is some concept of "split bar" in this function, and I want to be =
sure to understand it correctly.

BAR0 - configuration?
BAR1 - 32bit memory window? i.e. "split" bar?
BAR2+3 - 64bit memory window?
BAR4+5 - 64bit memory window?

Note that "split" in the intel driver refers to BAR4+5, which is =
normally a 64bit memory window, split into independent 32bit windows =
BAR4 and BAR5 by bios configuration.  Calling it "split" there makes =
sense.  Here, calling it "split" is confusing, but as long as the code =
is correct, I think it's ok.

> +		/* set and verify setting the translation address */
> +		iowrite64(addr, peer_mmio + xlat_reg);
> +		reg_val =3D ioread64(peer_mmio + xlat_reg);
> +		if (reg_val !=3D addr) {
> +			iowrite64(0, peer_mmio + xlat_reg);
> +			return -EIO;
> +		}
> +
> +		/* set and verify setting the limit */
> +		writel(limit, mmio + limit_reg);
> +		reg_val =3D readl(mmio + limit_reg);
> +		if (reg_val !=3D limit) {
> +			writel(base_addr, mmio + limit_reg);
> +			writel(0, peer_mmio + xlat_reg);
> +			return -EIO;
> +		}

I see a lot of readl/writel and ioread/iowrite in the same file, even in =
the same function as there is here.  Pick one variant of the functions, =
preferably the ioread/iowrite variant, and be consistent in its usage =
throughout the file.

> +static int amd_link_is_up(struct amd_ntb_dev *ndev)
> +{
> +	if (!ndev->peer_sta)
> +		return NTB_LNK_STA_ACTIVE(ndev->cntl_sta);
> +	else if (ndev->peer_sta & AMD_PEER_RESET_EVENT)
> +		ndev->peer_sta &=3D ~AMD_PEER_RESET_EVENT;
> +	else if (ndev->peer_sta & AMD_PEER_D0_EVENT)
> +		ndev->peer_sta =3D 0;
> +
> +	return 0;
> +}

This function changed since v3.

The first "else" is not necessary after a branch that returns.  It would =
be more clearly written as follows.

if (!ndev->peer_sta)
	return LNK_STA;

if (ndev->peer_sta & RESET)
	...;
else if (ndev->peer_sta & D0)
	...;

return 0;

It's also interesting that if it hits the last branch, ndev->peer_sta is =
assigned zero, but the function returns zero, not LNK_STA.  If the =
function were immediately called again, it would return LNK_STA.  Can =
you please explain the logic here?

The upper layer may poll the link status at any time, so unless the link =
status actually changed (as indicated by the hardware) between polls, =
the result of polling should be the same.

If the first time polling returns zero as a result of peer_sta,
 - AND the second time polling returns LNK_STA,
 - AND the hardware link state is UP,
 - AND the only difference is not the hardware
    link state but the value of peer_sta,
 - THEN this is a bug.

I should have noticed and made the comment in v1, which had the same =
behavior, though it was more explicit.

From v1:
> +	} else if (ndev->peer_sta & AMD_PEER_D0_EVENT) {
> +		ndev->peer_sta =3D 0;
> +		return 0;

Thanks,
Allen

