Return-Path: <jdmason@kudzu.us>
Received: from mail-qk0-x242.google.com (mail-qk0-x242.google.com. [2607:f8b0:400d:c09::242])
        by gmr-mx.google.com with ESMTPS id q126si381036ywg.13.2017.08.01.10.43.25
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Aug 2017 10:43:25 -0700 (PDT)
Received: by mail-qk0-x242.google.com with SMTP id d145so2276421qkc.0
        for <linux-ntb@googlegroups.com>; Tue, 01 Aug 2017 10:43:25 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Tue, 1 Aug 2017 13:43:23 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] ntb: update maintainer list for Intel NTB driver
Message-ID: <20170801174322.GA4186@kudzu.us>
References: <150128016434.49155.11346214975331646100.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <150128016434.49155.11346214975331646100.stgit@djiang5-desk3.ch.intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Fri, Jul 28, 2017 at 03:16:04PM -0700, Dave Jiang wrote:
> Removing Jon since he no longer works at Intel.

Works for me :)

I'm applying this to my ntb-next branch, since this isn't a bug fix.
Assuming I get other things for 4.14, it will go out with them.  If
not, it should probably go through the trivial tree.

Thanks,
Jon

> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  MAINTAINERS |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f66488d..7a634fb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9397,12 +9397,11 @@ S:	Supported
>  F:	drivers/ntb/hw/idt/
>  
>  NTB INTEL DRIVER
> -M:	Jon Mason <jdmason@kudzu.us>
>  M:	Dave Jiang <dave.jiang@intel.com>
>  L:	linux-ntb@googlegroups.com
>  S:	Supported
> -W:	https://github.com/jonmason/ntb/wiki
> -T:	git git://github.com/jonmason/ntb.git
> +W:	https://github.com/davejiang/linux/wiki
> +T:	git https://github.com/davejiang/linux.git
>  F:	drivers/ntb/hw/intel/
>  
>  NTFS FILESYSTEM
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/150128016434.49155.11346214975331646100.stgit%40djiang5-desk3.ch.intel.com.
> For more options, visit https://groups.google.com/d/optout.
