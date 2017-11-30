Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id y197si325615ywd.2.2017.11.30.14.04.38
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Nov 2017 14:04:38 -0800 (PST)
References: <20171130214300.21298-1-fancer.lancer@gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <923625e8-f071-c9f6-a3e2-c16480d4aea6@deltatee.com>
Date: Thu, 30 Nov 2017 15:04:29 -0700
MIME-Version: 1.0
In-Reply-To: <20171130214300.21298-1-fancer.lancer@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/08] NTB: ntb_test: Safely use paths with whitespace
To: Serge Semin <fancer.lancer@gmail.com>, jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

Hey,

I took a cursory look at this series and it largely looks good to me. 
Nice work. If I have time in the next couple days I'll do a more 
thorough review. However, does the series not depend on changes to 
ntb_tool? It would have been good to include a cover letter describing 
the intention/plan.


On 30/11/17 02:42 PM, Serge Semin wrote:
> If some of variables like LOC/REM or LOCAL_*/REMOTE_* got
> whitespaces, the script may fail with syntax error.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

Seeing this is a bug fix I Ack Patch 1 and suggest it get merged ahead 
of the series.

Acked-by: Logan Gunthorpe <logang@deltatee.com>
Fixes: a9c59ef77458 ("ntb_test: Add a selftest script for the NTB 
subsystem")

Thanks for the fix.

Logan
