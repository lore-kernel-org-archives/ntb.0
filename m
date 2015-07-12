Return-Path: <jdmason@kudzu.us>
Received: from mail-ie0-f182.google.com (mail-ie0-f182.google.com. [209.85.223.182])
        by gmr-mx.google.com with ESMTPS id x12si418709igx.1.2015.07.12.11.18.06
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jul 2015 11:18:06 -0700 (PDT)
Received: by mail-ie0-f182.google.com with SMTP id mu5so222058769ieb.1
        for <linux-ntb@googlegroups.com>; Sun, 12 Jul 2015 11:18:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8224dc7a68f172b365a7b01aebbfd1f5ca726e9e.1436276599.git.Allen.Hubbe@emc.com>
References: <8224dc7a68f172b365a7b01aebbfd1f5ca726e9e.1436276599.git.Allen.Hubbe@emc.com>
Date: Sun, 12 Jul 2015 14:18:06 -0400
Message-ID: <CAPoiz9wNKM0XFrUOuqrSMusWFjYh2v4RS_WC1gpZr42VPax0hQ@mail.gmail.com>
Subject: Re: [PATCH] NTB: Improve index handling in B2B MW workaround
From: Jon Mason <jdmason@kudzu.us>
Content-Type: text/plain; charset=UTF-8
To: Allen Hubbe <Allen.Hubbe@emc.com>
Cc: linux-ntb@googlegroups.com, Dave Jiang <dave.jiang@intel.com>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Jul 7, 2015 at 9:45 AM, Allen Hubbe <Allen.Hubbe@emc.com> wrote:
> Check that b2b_mw_idx is in range of the number of memory windows when
> initializing the device.  The workaround is considered to be in effect
> only if the device b2b_idx is exactly UINT_MAX, instead of any index
> past the last memory window.
>
> Only print B2B MW workaround information in debugfs if the workaround is
> in effect.

This looks sane to me.  This also looks like a bug fix.  Send to Linus, etc?

> Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
> ---
>  drivers/ntb/hw/intel/ntb_hw_intel.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
> index c2bc56b67e63..fc6af2da8df0 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_intel.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
> @@ -575,10 +575,13 @@ static ssize_t ndev_debugfs_read(struct file *filp, char __user *ubuf,
>                          "Connection Topology -\t%s\n",
>                          ntb_topo_string(ndev->ntb.topo));
>
> -       off += scnprintf(buf + off, buf_size - off,
> -                        "B2B Offset -\t\t%#lx\n", ndev->b2b_off);
> -       off += scnprintf(buf + off, buf_size - off,
> -                        "B2B MW Idx -\t\t%d\n", ndev->b2b_idx);
> +       if (ndev->b2b_idx != UINT_MAX) {
> +               off += scnprintf(buf + off, buf_size - off,
> +                                "B2B MW Idx -\t\t%u\n", ndev->b2b_idx);
> +               off += scnprintf(buf + off, buf_size - off,
> +                                "B2B Offset -\t\t%#lx\n", ndev->b2b_off);
> +       }
> +
>         off += scnprintf(buf + off, buf_size - off,
>                          "BAR4 Split -\t\t%s\n",
>                          ndev->bar4_split ? "yes" : "no");
> @@ -1487,7 +1490,7 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
>         pdev = ndev_pdev(ndev);
>         mmio = ndev->self_mmio;
>
> -       if (ndev->b2b_idx >= ndev->mw_count) {
> +       if (ndev->b2b_idx == UINT_MAX) {
>                 dev_dbg(ndev_dev(ndev), "not using b2b mw\n");
>                 b2b_bar = 0;
>                 ndev->b2b_off = 0;
> @@ -1779,6 +1782,13 @@ static int xeon_init_ntb(struct intel_ntb_dev *ndev)
>                         else
>                                 ndev->b2b_idx = b2b_mw_idx;
>
> +                       if (ndev->b2b_idx >= ndev->mw_count) {
> +                               dev_dbg(ndev_dev(ndev),
> +                                       "b2b_mw_idx %d invalid for mw_count %u\n",
> +                                       b2b_mw_idx, ndev->mw_count);
> +                               return -EINVAL;
> +                       }
> +
>                         dev_dbg(ndev_dev(ndev),
>                                 "setting up b2b mw idx %d means %d\n",
>                                 b2b_mw_idx, ndev->b2b_idx);
> @@ -2008,7 +2018,7 @@ static inline void ndev_init_struct(struct intel_ntb_dev *ndev,
>         ndev->ntb.ops = &intel_ntb_ops;
>
>         ndev->b2b_off = 0;
> -       ndev->b2b_idx = INT_MAX;
> +       ndev->b2b_idx = UINT_MAX;
>
>         ndev->bar4_split = 0;
>
> --
> 2.5.0.rc1
>
> --
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/8224dc7a68f172b365a7b01aebbfd1f5ca726e9e.1436276599.git.Allen.Hubbe%40emc.com.
> For more options, visit https://groups.google.com/d/optout.
