Return-Path: <jdmason@kudzu.us>
Received: from mail-qk0-x241.google.com (mail-qk0-x241.google.com. [2607:f8b0:400d:c09::241])
        by gmr-mx.google.com with ESMTPS id t130si300335ywb.5.2017.01.10.13.51.49
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 13:51:49 -0800 (PST)
Received: by mail-qk0-x241.google.com with SMTP id u25so77958450qki.2
        for <linux-ntb@googlegroups.com>; Tue, 10 Jan 2017 13:51:49 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Date: Tue, 10 Jan 2017 16:51:46 -0500
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] NTB: ntb_transport: fix debugfs_remove_recursive
Message-ID: <20170110215145.GC13381@kudzu.us>
References: <6f7341ada9073025b0172a2ab0decc084b4d2ef4.1482879327.git.Allen.Hubbe@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f7341ada9073025b0172a2ab0decc084b4d2ef4.1482879327.git.Allen.Hubbe@dell.com>
To: Allen Hubbe <Allen.Hubbe@dell.com>
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Tue, Dec 27, 2016 at 05:57:04PM -0500, Allen Hubbe wrote:
> The call to debugfs_remove_recursive(qp->debugfs_dir) of the sub-level
> directory must not be later than
> debugfs_remove_recursive(nt_debugfs_dir) of the top-level directory.
> Otherwise, the sub-level directory will not exist, and it would be
> invalid (panic) to attempt to remove it.  This removes the top-level
> directory last, after sub-level directories have been cleaned up.
> 
> Signed-off-by: Allen Hubbe <Allen.Hubbe@dell.com>

Applied to my ntb tree

Thanks,
Jon

> ---
>  drivers/ntb/ntb_transport.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index f81aa4b18d9f..0e18adb51e4e 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -2273,9 +2273,8 @@ module_init(ntb_transport_init);
>  
>  static void __exit ntb_transport_exit(void)
>  {
> -	debugfs_remove_recursive(nt_debugfs_dir);
> -
>  	ntb_unregister_client(&ntb_transport_client);
>  	bus_unregister(&ntb_transport_bus);
> +	debugfs_remove_recursive(nt_debugfs_dir);
>  }
>  module_exit(ntb_transport_exit);
> -- 
> 2.9.1
> 
