Return-Path: <jdmason@kudzu.us>
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com. [2607:f8b0:4864:20::d2e])
        by gmr-mx.google.com with ESMTPS id g88si169970vkc.5.2018.11.27.08.06.29
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 08:06:29 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id k7so7508792iob.6
        for <linux-ntb@googlegroups.com>; Tue, 27 Nov 2018 08:06:29 -0800 (PST)
MIME-Version: 1.0
References: <1542877322-24548-1-git-send-email-wesley.sheng@microchip.com> <1542877322-24548-3-git-send-email-wesley.sheng@microchip.com>
In-Reply-To: <1542877322-24548-3-git-send-email-wesley.sheng@microchip.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Tue, 27 Nov 2018 11:06:16 -0500
Message-ID: <CAPoiz9xRV3ny1EQZGXc3moPHUxESTkDz5rMd8+E_Ag4sFNKQ8w@mail.gmail.com>
Subject: Re: [PATCH 2/3] ntb_hw_switchtec: Added support of >=4G memory windows
Content-Type: text/plain; charset="UTF-8"
To: wesley.sheng@microchip.com
Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>, Logan Gunthorpe <logang@deltatee.com>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, linux-kernel <linux-kernel@vger.kernel.org>, wesleyshenggit@sina.com
List-ID: <linux-ntb.googlegroups.com>

On Wed, Nov 21, 2018 at 9:19 PM Wesley Sheng <wesley.sheng@microchip.com> wrote:
>
> From: Paul Selles <paul.selles@microchip.com>
>
> Current Switchtec's BAR setup registers are limited to 32bits,
> corresponding to the maximum MW (memory window) size is <4G.
>
> Increase the MW sizes with the addition of the BAR Setup Extension
> Register for the upper 32bits of a 64bits MW size. This increases the MW
> range to between 4K and 2^63.
>
> Reported-by: Boris Glimcher <boris.glimcher@emc.com>
> Signed-off-by: Paul Selles <paul.selles@microchip.com>
> Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
> ---
>  drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 9 +++++++--
>  include/linux/switchtec.h              | 6 +++++-
>  2 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> index 9916bc5..32850fb 100644
> --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> @@ -264,6 +264,7 @@ static void switchtec_ntb_mw_clr_direct(struct switchtec_ntb *sndev, int idx)
>         ctl_val &= ~NTB_CTRL_BAR_DIR_WIN_EN;
>         iowrite32(ctl_val, &ctl->bar_entry[bar].ctl);
>         iowrite32(0, &ctl->bar_entry[bar].win_size);
> +       iowrite32(0, &ctl->bar_ext_entry[bar].win_size);
>         iowrite64(sndev->self_partition, &ctl->bar_entry[bar].xlate_addr);
>  }
>
> @@ -286,7 +287,9 @@ static void switchtec_ntb_mw_set_direct(struct switchtec_ntb *sndev, int idx,
>         ctl_val |= NTB_CTRL_BAR_DIR_WIN_EN;
>
>         iowrite32(ctl_val, &ctl->bar_entry[bar].ctl);
> -       iowrite32(xlate_pos | size, &ctl->bar_entry[bar].win_size);
> +       iowrite32(xlate_pos | (size & 0xFFFFF000),
> +                 &ctl->bar_entry[bar].win_size);
> +       iowrite32(size >> 32, &ctl->bar_ext_entry[bar].win_size);

Thanks for the patches.  Overall the look good.  Per the kbuild email,
size_t is 32bits on 32bit arch.  So, this is going to have compile
warnings on those.  Please address this and resubmit.

Also, patches 1 and 3 are bug fixes.  Please do the following, reorder
the patches to make the bug fixes first and add a "Fixes" line to the
commit messages (see
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes).
This will allow me to split up the series and get the bug fixes into
v4.20 (and the stable trees).

Thanks,
Jon

>         iowrite64(sndev->self_partition | addr,
>                   &ctl->bar_entry[bar].xlate_addr);
>  }
> @@ -1053,7 +1056,9 @@ static int crosslink_setup_mws(struct switchtec_ntb *sndev, int ntb_lut_idx,
>                 ctl_val |= NTB_CTRL_BAR_DIR_WIN_EN;
>
>                 iowrite32(ctl_val, &ctl->bar_entry[bar].ctl);
> -               iowrite32(xlate_pos | size, &ctl->bar_entry[bar].win_size);
> +               iowrite32(xlate_pos | (size & 0xFFFFF000),
> +                         &ctl->bar_entry[bar].win_size);
> +               iowrite32(size >> 32, &ctl->bar_ext_entry[bar].win_size);
>                 iowrite64(sndev->peer_partition | addr,
>                           &ctl->bar_entry[bar].xlate_addr);
>         }
> diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
> index eee0412..1e6e333 100644
> --- a/include/linux/switchtec.h
> +++ b/include/linux/switchtec.h
> @@ -248,7 +248,11 @@ struct ntb_ctrl_regs {
>                 u32 win_size;
>                 u64 xlate_addr;
>         } bar_entry[6];
> -       u32 reserved2[216];
> +       struct {
> +               u32 win_size;
> +               u32 reserved[3];
> +       } bar_ext_entry[6];
> +       u32 reserved2[192];
>         u32 req_id_table[256];
>         u32 reserved3[512];
>         u64 lut_entry[512];
> --
> 2.7.4
>
