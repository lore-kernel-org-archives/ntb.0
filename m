Return-Path: <Allen.Hubbe@dell.com>
Received: from esa3.dell-outbound.iphmx.com (esa3.dell-outbound.iphmx.com. [68.232.153.94])
        by gmr-mx.google.com with ESMTPS id o129si1578959ywe.14.2017.07.31.07.47.02
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Jul 2017 07:47:03 -0700 (PDT)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
References: <150127984807.48385.10962784387437107365.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <150127984807.48385.10962784387437107365.stgit@djiang5-desk3.ch.intel.com>
Subject: RE: [PATCH] ntb: transport shouldn't disable link due to bogus values in SPADs
Date: Mon, 31 Jul 2017 10:46:42 -0400
Message-ID: <000001d30a0b$d3b52b20$7b1f8160$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Dave Jiang' <dave.jiang@intel.com>, jdmason@kudzu.us
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

From: Dave Jiang
> It seems that under certain scenarios the SPAD can have bogus values caused
> by an agent (i.e. BIOS or other software) that is not the kernel driver, and
> that causes memory window setup failure. This should not cause the link to
> be disabled because if we do that, the driver will never recover again. We
> have verified in testing that this issue happens and prevents proper link
> recovery.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>

> ---
>  drivers/ntb/ntb_transport.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 9a03c58..f0dd5a7 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -924,10 +924,8 @@ static void ntb_transport_link_work(struct work_struct *work)
>  		ntb_free_mw(nt, i);
> 
>  	/* if there's an actual failure, we should just bail */
> -	if (rc < 0) {
> -		ntb_link_disable(ndev);
> +	if (rc < 0)
>  		return;
> -	}
> 
>  out:
>  	if (ntb_link_is_up(ndev, NULL, NULL) == 1)
> 
> --
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-
> ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-
> ntb/150127984807.48385.10962784387437107365.stgit%40djiang5-desk3.ch.intel.com.
> For more options, visit https://groups.google.com/d/optout.

