Return-Path: <cse.cem@gmail.com>
Received: from mail-yk0-f174.google.com (mail-yk0-f174.google.com. [209.85.160.174])
        by gmr-mx.google.com with ESMTPS id u69si759615ywf.5.2015.11.19.13.03.15
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2015 13:03:15 -0800 (PST)
Received: by ykdv3 with SMTP id v3so128033110ykd.0
        for <linux-ntb@googlegroups.com>; Thu, 19 Nov 2015 13:03:15 -0800 (PST)
Return-Path: <cse.cem@gmail.com>
Received: from mail-yk0-f171.google.com (mail-yk0-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id 205sm7260273ywg.7.2015.11.19.13.03.15
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2015 13:03:15 -0800 (PST)
Received: by ykdv3 with SMTP id v3so128032503ykd.0
        for <linux-ntb@googlegroups.com>; Thu, 19 Nov 2015 13:03:14 -0800 (PST)
MIME-Version: 1.0
Reply-To: cem@FreeBSD.org
In-Reply-To: <20151119210054.127573.61827.stgit@djiang5-desk3.ch.intel.com>
References: <20151119210054.127573.61827.stgit@djiang5-desk3.ch.intel.com>
Date: Thu, 19 Nov 2015 13:03:14 -0800
Message-ID: <CAG6CVpUYLwZJjwiGKJjj2-JKFE0W3ZDyPBTz0UpH604uUeONYg@mail.gmail.com>
Subject: Re: [PATCH v2] NTB: Clear property bits in BAR value
From: Conrad Meyer <cem@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8
To: Dave Jiang <dave.jiang@intel.com>
Cc: Jon Mason <jdmason@kudzu.us>, linux-ntb@googlegroups.com, Allen Hubbe <allen.hubbe@emc.com>
List-ID: <linux-ntb.googlegroups.com>

Signed-off-by: me.

Best,
Conrad

On Thu, Nov 19, 2015 at 1:00 PM, Dave Jiang <dave.jiang@intel.com> wrote:
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
