Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id y126si73419itc.1.2017.08.08.11.24.03
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Aug 2017 11:24:04 -0700 (PDT)
References: <20170808101147.24625-1-fancer.lancer@gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <7f161b19-4902-43b6-6860-a86738212895@deltatee.com>
Date: Tue, 8 Aug 2017 12:23:56 -0600
MIME-Version: 1.0
In-Reply-To: <20170808101147.24625-1-fancer.lancer@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] NTB: ntb_tool: Add full multi-port NTB API support
To: Serge Semin <fancer.lancer@gmail.com>, jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com, gary.hook@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-ID: <linux-ntb.googlegroups.com>



On 08/08/17 04:11 AM, Serge Semin wrote:
> NTB API has been updated to support multi-port devices like IDT
> 89HPESx series or Microsemi Switchtec. Message registers
> functionality has also been added to new API. In order to keep
> the new hardware and corresponding capabilities well tested, NTB
> tool driver is accordingly altered.

These patches are all incredibly hard to read as they are very long and
also contain a bunch of unrelated and unnecessary changes in them. I've
commented on a subset of these issues below for this patch only but the
subsequent patches also have a lot of these issues.

The patches are so convoluted and hard to read that if I were in Jon's
position I could not in good conscious merge them. It's way too
difficult to review them for changes we don't want to have in the
kernel. However, this is only my opinion and in the end will be up to Jon.

Also, because you are changing the ntb_tool API significantly, we also
need to update the ntb_test script in tools/testing/selftests/ntb/ at
the same time.


> -#define DRIVER_NAME			"ntb_tool"
> -#define DRIVER_DESCRIPTION		"PCIe NTB Debugging Tool"
> +#define DRIVER_NAME		"ntb_tool"
> +#define DRIVER_DESCRIPTION	"PCIe NTB Debugging Tool"

Do we need to add more noise here by changing the tabbing? I think
cosmetic changes like this need to be in a separate patch and argued for
separately.

> -/* It is rare to have hadrware with greater than six MWs */
> -#define MAX_MWS	6
> -/* Only two-ports devices are supported */
> -#define PIDX	NTB_DEF_PEER_IDX

I'm glad we're getting rid of this restriction but this should really be
a separate patch. I noticed only after your last series got included
that you reduced the restriction from 16 to 6 which was mildly annoying
seeing switchtec can actually have up to ~128 mws. At the _very_ least,
all changes to semantics, features and restrictions need to be mentioned
in the commit message.

> -	ssize_t rc;
> +	ssize_t ret;

These diffs would be much easier to read if names of unrelated variables
were not needlessly changed. This is done in a lot of places and it just
adds to the noise we have to filter through to try and understand what
is actually being changed.


>  static struct ntb_client tool_client = {
>  	.ops = {
>  		.probe = tool_probe,
>  		.remove = tool_remove,
> -	},
> +	}

More cosmetic unnecessary changes.



>  static int __init tool_init(void)
>  {
> -	int rc;
> +	int ret;
>  
>  	if (debugfs_initialized())
> -		tool_dbgfs = debugfs_create_dir(KBUILD_MODNAME, NULL);
> +		tool_dbgfs_topdir = debugfs_create_dir(KBUILD_MODNAME, NULL);
>  
> -	rc = ntb_register_client(&tool_client);
> -	if (rc)
> -		goto err_client;
> +	ret = ntb_register_client(&tool_client);
> +	if (ret)
> +		debugfs_remove_recursive(tool_dbgfs_topdir);
>  
> -	return 0;
> -
> -err_client:
> -	debugfs_remove_recursive(tool_dbgfs);
> -	return rc;
> +	return ret;
>  }
>  module_init(tool_init);
>  
>  static void __exit tool_exit(void)
>  {
>  	ntb_unregister_client(&tool_client);
> -	debugfs_remove_recursive(tool_dbgfs);
> +	debugfs_remove_recursive(tool_dbgfs_topdir);
>  }
>  module_exit(tool_exit);
> +

I don't think there are actually any real changes in this hunk. Just
cosmetic changes to variable names. If you absolutely feel these need to
be changed it should be in a separate patch that specifically says this
is happening and provides justifications.

I'll be happy to review and test the actual content of this series more
once the patches are cleaned up and more easily read.

Logan

