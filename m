Return-Path: <cse.cem@gmail.com>
Received: from mail-yk0-f173.google.com (mail-yk0-f173.google.com. [209.85.160.173])
        by gmr-mx.google.com with ESMTPS id z21si776528ywz.2.2015.11.19.12.50.10
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2015 12:50:10 -0800 (PST)
Received: by ykfs79 with SMTP id s79so128232628ykf.1
        for <linux-ntb@googlegroups.com>; Thu, 19 Nov 2015 12:50:10 -0800 (PST)
Return-Path: <cse.cem@gmail.com>
Received: from mail-yk0-f182.google.com (mail-yk0-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id 4sm9396162ywb.26.2015.11.19.12.50.09
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2015 12:50:10 -0800 (PST)
Received: by ykdr82 with SMTP id r82so126632176ykd.3
        for <linux-ntb@googlegroups.com>; Thu, 19 Nov 2015 12:50:09 -0800 (PST)
MIME-Version: 1.0
Reply-To: cem@FreeBSD.org
In-Reply-To: <20151119204707.95851.65523.stgit@djiang5-desk3.ch.intel.com>
References: <20151119204707.95851.65523.stgit@djiang5-desk3.ch.intel.com>
Date: Thu, 19 Nov 2015 12:50:09 -0800
Message-ID: <CAG6CVpXqKnRfOR_WKmrnScB0t1w7nGOFsgfYPGFrYh9Hv4LFvg@mail.gmail.com>
Subject: Re: [PATCH] NTB: Clear property bits in BAR value
From: Conrad Meyer <cem@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8
To: Dave Jiang <dave.jiang@intel.com>
Cc: Jon Mason <jdmason@kudzu.us>, linux-ntb@googlegroups.com, Allen Hubbe <allen.hubbe@emc.com>
List-ID: <linux-ntb.googlegroups.com>

Looks fine to me.  Isn't unsigned long 64 bits on Linux amd64?
(Should NTB_BAR_MASK_32 just be ~(0xfu)?)

Best,
Conrad

On Thu, Nov 19, 2015 at 12:47 PM, Dave Jiang <dave.jiang@intel.com> wrote:
> The lower bits read from a BAR register will contain property bits
> that we do not care about. Clear those so that we can use the BAR
> values for limit and xlat registers.
>
> Reported-by: Conrad Meyer <cem@freebsd.org>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/ntb/hw/intel/ntb_hw_intel.c |    4 ++--
>  drivers/ntb/hw/intel/ntb_hw_intel.h |    3 +++
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
> index a198f82..40d04ef 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_intel.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
> @@ -875,7 +875,7 @@ static int intel_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
>         limit_reg = bar2_off(ndev->xlat_reg->bar2_limit, bar);
>
>         if (bar < 4 || !ndev->bar4_split) {
> -               base = ioread64(mmio + base_reg);
> +               base = ioread64(mmio + base_reg) & NTB_BAR_MASK_64;
>
>                 /* Set the limit if supported, if size is not mw_size */
>                 if (limit_reg && size != mw_size)
> @@ -906,7 +906,7 @@ static int intel_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
>                 if ((addr + size) & (~0ull << 32))
>                         return -EINVAL;
>
> -               base = ioread32(mmio + base_reg);
> +               base = ioread32(mmio + base_reg) & NTB_BAR_MASK_32;
>
>                 /* Set the limit if supported, if size is not mw_size */
>                 if (limit_reg && size != mw_size)
> diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.h b/drivers/ntb/hw/intel/ntb_hw_intel.h
> index 2eb4add..a257c7c 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_intel.h
> +++ b/drivers/ntb/hw/intel/ntb_hw_intel.h
> @@ -245,6 +245,9 @@
>  #define NTB_UNSAFE_DB                  BIT_ULL(0)
>  #define NTB_UNSAFE_SPAD                        BIT_ULL(1)
>
> +#define NTB_BAR_MASK_64                        ~(0xfull)
> +#define NTB_BAR_MASK_32                        ~(0xful)
> +
>  struct intel_ntb_dev;
>
>  struct intel_ntb_reg {
>
