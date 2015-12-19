Return-Path: <jdmason@kudzu.us>
Received: from mail-wm0-x234.google.com (mail-wm0-x234.google.com. [2a00:1450:400c:c09::234])
        by gmr-mx.google.com with ESMTPS id b62si385100wmc.0.2015.12.19.14.59.29
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Dec 2015 14:59:29 -0800 (PST)
Received: by mail-wm0-x234.google.com with SMTP id l126so27259433wml.0
        for <linux-ntb@googlegroups.com>; Sat, 19 Dec 2015 14:59:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20151119210054.127573.61827.stgit@djiang5-desk3.ch.intel.com>
References: <20151119210054.127573.61827.stgit@djiang5-desk3.ch.intel.com>
Date: Sat, 19 Dec 2015 17:59:29 -0500
Message-ID: <CAPoiz9zYwf+quiPRtF-axoomuy8k_xfJy10-8T-8HFrUvJ=eiw@mail.gmail.com>
Subject: Re: [PATCH v2] NTB: Clear property bits in BAR value
From: Jon Mason <jdmason@kudzu.us>
Content-Type: text/plain; charset=UTF-8
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-ntb@googlegroups.com, "Hubbe, Allen" <allen.hubbe@emc.com>, cem@freebsd.org
List-ID: <linux-ntb.googlegroups.com>

On Thu, Nov 19, 2015 at 4:00 PM, Dave Jiang <dave.jiang@intel.com> wrote:
> The lower bits read from a BAR register will contain property bits
> that we do not care about. Clear those so that we can use the BAR
> values for limit and xlat registers.
>
> Reported-by: Conrad Meyer <cem@freebsd.org>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Pulled in, thanks

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
> index 2eb4add..4d60433 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_intel.h
> +++ b/drivers/ntb/hw/intel/ntb_hw_intel.h
> @@ -245,6 +245,9 @@
>  #define NTB_UNSAFE_DB                  BIT_ULL(0)
>  #define NTB_UNSAFE_SPAD                        BIT_ULL(1)
>
> +#define NTB_BAR_MASK_64                        ~(0xfull)
> +#define NTB_BAR_MASK_32                        ~(0xfu)
> +
>  struct intel_ntb_dev;
>
>  struct intel_ntb_reg {
>
> --
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/20151119210054.127573.61827.stgit%40djiang5-desk3.ch.intel.com.
> For more options, visit https://groups.google.com/d/optout.
