Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id w126si2936202ywe.6.2016.01.20.20.35.37
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jan 2016 20:35:37 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <1453365583-9823-1-git-send-email-Xiangliang.Yu@amd.com>
In-Reply-To: <1453365583-9823-1-git-send-email-Xiangliang.Yu@amd.com>
Subject: RE: [PATCH V5 1/1] NTB: Add support for AMD PCI-Express Non-Transparent Bridge
Date: Wed, 20 Jan 2016 23:35:22 -0500
Message-ID: <000001d15405$24fe24a0$6efa6de0$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
To: 'Xiangliang Yu' <Xiangliang.Yu@amd.com>, jdmason@kudzu.us, dave.jiang@intel.com, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
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

> Signed-off-by: Jon Mason <jdmason@kudzu.us>
> Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>

NO.


> +		/* set and verify setting the translation address */
> +		write64(addr, peer_mmio + xlat_reg);
> +		reg_val =3D read64(peer_mmio + xlat_reg);
> +		if (reg_val !=3D addr) {
> +			write64(0, peer_mmio + xlat_reg);
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

I see what you did there, change iowrite64 to write64.

What I meant was:
 - change readl to ioread32.
 - change writel to iowrite32.
 - change readb, readw, writeb, writew (if there are any)
 - leave ioread64 and iowrite64 as they were.

Why: http://www.makelinux.net/ldd3/chp-9-sect-4

Quote: "If you read through the kernel source, you see many calls to an =
older set of functions when I/O memory is being used. These functions =
still work, but their use in new code is discouraged. Among other =
things, they are less safe because they do not perform the same sort of =
type checking."

The "older set of functions" are read[bwl], write[bwl].  This is a new =
driver, with all new code.  Please use the ioread/iowrite variants.

> +static int amd_link_is_up(struct amd_ntb_dev *ndev)
> +{
> +	if (!ndev->peer_sta)
> +		return NTB_LNK_STA_ACTIVE(ndev->cntl_sta);
> +
> +	/* If peer_sta is reset or D0 event, the ISR has
> +	 * started a timer to check link status of hardware.
> +	 * So here just clear status bit. And if peer_sta is
> +	 * D3 or PME_TO, D0/reset event will be happened when
> +	 * system wakeup/poweron, so do nothing here.
> +	 */
> +	if (ndev->peer_sta & AMD_PEER_RESET_EVENT)
> +		ndev->peer_sta &=3D ~AMD_PEER_RESET_EVENT;
> +	else if (ndev->peer_sta & AMD_PEER_D0_EVENT)
> +		ndev->peer_sta =3D 0;
> +
> +	return 0;
> +}

Thanks.  This is much better.

> +static void amd_handle_event(struct amd_ntb_dev *ndev, int vec)
...
> +	case AMD_PEER_D0_EVENT:
...
> +		/* start a timer to poll link status */
> +		schedule_delayed_work(&ndev->hb_timer,
> +					      AMD_LINK_HB_TIMEOUT);

This is different from v4.  It used to be:

if (amd_link_is_up())
	ntb_link_event();
else
	schedule_delayed_work();

Why is v5 correct?
Why was v4 incorrect?

I'm nervous about ndev->peer_sta, the behavior of link_is_up, timers... =
unexplained changes to a fragile bit of code - not just this code, but =
any code that deals with parallel or asynchronous behaviors.  With the =
comment in link_is_up, this code is much better, but any changes to this =
whole link state mechanism need to be explained.


Allen

