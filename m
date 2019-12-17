Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id v82si584017ili.0.2019.12.17.08.43.07
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 08:43:07 -0800 (PST)
References: <1576550536-84697-1-git-send-email-linjiasen@hygon.cn>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d4f679cd-739b-fd80-8344-7da475937835@deltatee.com>
Date: Tue, 17 Dec 2019 09:42:48 -0700
MIME-Version: 1.0
In-Reply-To: <1576550536-84697-1-git-send-email-linjiasen@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] NTB: ntb_perf: Add more debugfs entries for ntb_perf
To: Jiasen Lin <linjiasen@hygon.cn>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, jdmason@kudzu.us
Cc: allenbh@gmail.com, dave.jiang@intel.com, sanju.mehta@amd.com
List-ID: <linux-ntb.googlegroups.com>



On 2019-12-16 7:42 p.m., Jiasen Lin wrote:
> Currently, read input and output buffer is not supported yet in
> debugfs of ntb_perf. We can not confirm whether the output data is
> transmitted to the input buffer at peer memory through NTB.
> 
> This patch add new entries in debugfs which implement interface to read
> a part of input and out buffer. User can dump output and input data at
> local and peer system by hexdump command, and then compare them manually.

Do we even initialize inbuf and outbuf? Probably not a good idea to
expose them to userspace if it's not initialized.

Really, ntb_tool should be used to check if memory windows work,
ntb_perf is just to see the maximum transfer rate.

Logan
