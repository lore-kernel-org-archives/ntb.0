Return-Path: <jdmason@kudzu.us>
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com. [2607:f8b0:400d:c09::244])
        by gmr-mx.google.com with ESMTPS id n10si21846ywl.4.2017.08.31.10.55.58
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Aug 2017 10:55:58 -0700 (PDT)
Received: by mail-qk0-x244.google.com with SMTP id p67so264053qkd.2
        for <linux-ntb@googlegroups.com>; Thu, 31 Aug 2017 10:55:58 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Thu, 31 Aug 2017 13:55:56 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] NTB: make idt_89hpes_cfg const
Message-ID: <20170831175555.GB28190@kudzu.us>
References: <1502473663-6136-1-git-send-email-bhumirks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1502473663-6136-1-git-send-email-bhumirks@gmail.com>
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, fancer.lancer@gmail.com, dave.jiang@intel.com, Allen.Hubbe@emc.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Fri, Aug 11, 2017 at 11:17:43PM +0530, Bhumika Goyal wrote:
> Make these const as they are only used during a copy operation.
> Done using Coccinelle.

Pulled into my ntb-next branch

Thanks,
Jon

> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
>  drivers/ntb/hw/idt/ntb_hw_idt.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> index d44d7ef..0cd79f3 100644
> --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> @@ -2628,35 +2628,35 @@ static void idt_pci_remove(struct pci_dev *pdev)
>  /*
>   * IDT PCIe-switch models ports configuration structures
>   */
> -static struct idt_89hpes_cfg idt_89hpes24nt6ag2_config = {
> +static const struct idt_89hpes_cfg idt_89hpes24nt6ag2_config = {
>  	.name = "89HPES24NT6AG2",
>  	.port_cnt = 6, .ports = {0, 2, 4, 6, 8, 12}
>  };
> -static struct idt_89hpes_cfg idt_89hpes32nt8ag2_config = {
> +static const struct idt_89hpes_cfg idt_89hpes32nt8ag2_config = {
>  	.name = "89HPES32NT8AG2",
>  	.port_cnt = 8, .ports = {0, 2, 4, 6, 8, 12, 16, 20}
>  };
> -static struct idt_89hpes_cfg idt_89hpes32nt8bg2_config = {
> +static const struct idt_89hpes_cfg idt_89hpes32nt8bg2_config = {
>  	.name = "89HPES32NT8BG2",
>  	.port_cnt = 8, .ports = {0, 2, 4, 6, 8, 12, 16, 20}
>  };
> -static struct idt_89hpes_cfg idt_89hpes12nt12g2_config = {
> +static const struct idt_89hpes_cfg idt_89hpes12nt12g2_config = {
>  	.name = "89HPES12NT12G2",
>  	.port_cnt = 3, .ports = {0, 8, 16}
>  };
> -static struct idt_89hpes_cfg idt_89hpes16nt16g2_config = {
> +static const struct idt_89hpes_cfg idt_89hpes16nt16g2_config = {
>  	.name = "89HPES16NT16G2",
>  	.port_cnt = 4, .ports = {0, 8, 12, 16}
>  };
> -static struct idt_89hpes_cfg idt_89hpes24nt24g2_config = {
> +static const struct idt_89hpes_cfg idt_89hpes24nt24g2_config = {
>  	.name = "89HPES24NT24G2",
>  	.port_cnt = 8, .ports = {0, 2, 4, 6, 8, 12, 16, 20}
>  };
> -static struct idt_89hpes_cfg idt_89hpes32nt24ag2_config = {
> +static const struct idt_89hpes_cfg idt_89hpes32nt24ag2_config = {
>  	.name = "89HPES32NT24AG2",
>  	.port_cnt = 8, .ports = {0, 2, 4, 6, 8, 12, 16, 20}
>  };
> -static struct idt_89hpes_cfg idt_89hpes32nt24bg2_config = {
> +static const struct idt_89hpes_cfg idt_89hpes32nt24bg2_config = {
>  	.name = "89HPES32NT24BG2",
>  	.port_cnt = 8, .ports = {0, 2, 4, 6, 8, 12, 16, 20}
>  };
> -- 
> 1.9.1
> 
