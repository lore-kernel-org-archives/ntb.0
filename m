Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id 105si70856uas.1.2017.12.05.15.38.21
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Dec 2017 15:38:21 -0800 (PST)
References: <20171203191736.3399-1-fancer.lancer@gmail.com>
 <20171205223918.28727-1-fancer.lancer@gmail.com>
 <20171205223918.28727-4-fancer.lancer@gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <26ca1ce6-c4b9-818f-7b12-994bf8ae7e50@deltatee.com>
Date: Tue, 5 Dec 2017 16:38:18 -0700
MIME-Version: 1.0
In-Reply-To: <20171205223918.28727-4-fancer.lancer@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 03/15] NTB: Fix UB/bug in ntb_mw_get_align()
To: Serge Semin <fancer.lancer@gmail.com>, jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com, gary.hook@amd.com
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>



On 05/12/17 03:39 PM, Serge Semin wrote:
> Simple (1 << pidx) operation causes undefined behaviour when
> pidx >= 32. It must be casted to u64 to match the actual return
> value of ntb_link_is_up() method, so to have all the possible
> peer indexes covered and to get rid of undefined behaviour.
> Additionally there are special macros in "linux/bitops.h" to perform
> the bit-set-shift operations, so it's recommended to have them used
> for proper bit setting.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

Looks like you dropped my reviewed by tag for some reason.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

