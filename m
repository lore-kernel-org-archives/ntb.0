Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id j3si41568pga.0.2017.12.05.09.01.24
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Dec 2017 09:01:24 -0800 (PST)
References: <20171203191736.3399-1-fancer.lancer@gmail.com>
 <20171203191736.3399-4-fancer.lancer@gmail.com>
 <CAPoiz9yuX+d1Bt1ioy_u9jLXzkWfHwKjoJ+hH5t4BN88YKrRsQ@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8859c11b-6c6b-3780-c13a-2ae0affd7033@deltatee.com>
Date: Tue, 5 Dec 2017 10:01:22 -0700
MIME-Version: 1.0
In-Reply-To: <CAPoiz9yuX+d1Bt1ioy_u9jLXzkWfHwKjoJ+hH5t4BN88YKrRsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 03/15] NTB: Fix UB/bug in ntb_mw_get_align()
To: Jon Mason <jdmason@kudzu.us>, Serge Semin <fancer.lancer@gmail.com>
Cc: Dave Jiang <dave.jiang@intel.com>, "Hubbe, Allen" <Allen.Hubbe@emc.com>, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "Yu, Xiangliang" <Xiangliang.Yu@amd.com>, Gary R Hook <gary.hook@amd.com>, Sergey.Semin@t-platforms.ru, linux-ntb <linux-ntb@googlegroups.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>



On 05/12/17 09:52 AM, Jon Mason wrote:
> On Sun, Dec 3, 2017 at 2:17 PM, Serge Semin <fancer.lancer@gmail.com> wrote:
>> Simple (1 << pidx) operation causes undefined behaviour when
>> pidx >= 32. It must be casted to u64 to match the actual return
>> value of ntb_link_is_up() method, so to have all the possible
>> peer indexes covered and to get rid of undefined behaviour.
>> Additionally there are special macros in "linux/bitops.h" to perform
>> the bit-set-shift operations, so it's recommended to have them used
>> for proper bit setting.
> 
> This looks good to me, but also seems like a bug fix.  Please comment
> on if this is not noticed.

It would be a bug on any system that has more than 32 partitions which 
is run on a 32 bit machine (or 64 partitions on a 64bit machine). Such a 
system is theoretical for the foreseeable future. But it would be good 
to fix it now.

Logan
