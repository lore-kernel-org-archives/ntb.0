Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id ci4si1774058pad.1.2016.06.11.08.30.53
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Jun 2016 08:30:53 -0700 (PDT)
References: <cover.1465598632.git.logang@deltatee.com>
 <a326e5cfecc9c780e97d9ce1665d13474b7367c3.1465598632.git.logang@deltatee.com>
 <CAJ80savOTsXePsDQqhaXDuXFx7jBMACkUbztzHnkCEDrpLWXjw@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <575C2EA6.9060208@deltatee.com>
Date: Sat, 11 Jun 2016 09:30:46 -0600
MIME-Version: 1.0
In-Reply-To: <CAJ80savOTsXePsDQqhaXDuXFx7jBMACkUbztzHnkCEDrpLWXjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 7/8] ntb_pingpong: Add a debugfs file to get the ping
 count
To: Allen Hubbe <allenbh@gmail.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Shuah Khan <shuahkh@osg.samsung.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-kselftest@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

> The pp_debugfs_dir is already initialized by the module init function.
> If it doesn't exist here, I think we should just return instead of
> trying again.  It's also worth noting, though it is probably no harm,
> the code here does not check debugfs_initialized().

>> +static int __init tool_init(void)
>
> This should be pp_init() not tool_init().

Yup, this is just sloppy copying on my part. I copied from two different 
places. I'll fix these oversights.

Thanks,

Logan

