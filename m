Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id r66si444023itc.0.2017.11.30.14.26.41
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Nov 2017 14:26:41 -0800 (PST)
References: <20171130214300.21298-1-fancer.lancer@gmail.com>
 <923625e8-f071-c9f6-a3e2-c16480d4aea6@deltatee.com>
 <20171130221258.GA20562@mobilestation>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <bbe9343c-fb43-ce8d-a871-033f3556c222@deltatee.com>
Date: Thu, 30 Nov 2017 15:26:39 -0700
MIME-Version: 1.0
In-Reply-To: <20171130221258.GA20562@mobilestation>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/08] NTB: ntb_test: Safely use paths with whitespace
To: Serge Semin <fancer.lancer@gmail.com>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com, Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>



On 30/11/17 03:12 PM, Serge Semin wrote:
> In general the intention of the patchset was to update the ntb_test.sh script
> so one would be compatible with new NTB test drivers I've also sent. It was
> asked of me by the NTB core maintainers. Sorry for not mentioning it in the
> cover letter.

I understand that. But most importantly a series needs to say what it's 
based off of and given than it clearly depends on the ntb_tool changes 
(which I saw later) it was a bit confusing.

I think this should be in the same series as the ntb_tool changes as the 
ntb_test changes depend on ntb_tool and we shouldn't merge the ntb_tool 
changes without the ntb_test changes as it would break them.

Logan
