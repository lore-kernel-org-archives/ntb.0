Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id h17-v6si230478itj.4.2018.06.15.13.02.14
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 13:02:14 -0700 (PDT)
References: <20180609000819.13883-1-logang@deltatee.com>
 <20180609000819.13883-10-logang@deltatee.com>
 <20180615195152.GA25605@mobilestation>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b04fc30b-54fe-e1b0-3365-47b9bb5e9f13@deltatee.com>
Date: Fri, 15 Jun 2018 14:02:11 -0600
MIME-Version: 1.0
In-Reply-To: <20180615195152.GA25605@mobilestation>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 8/8] NTB: ntb_test: Fix bug when counting remote files
To: Serge Semin <fancer.lancer@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Shuah Khan <shuah@kernel.org>
List-ID: <linux-ntb.googlegroups.com>



On 15/06/18 01:51 PM, Serge Semin wrote:
> On Fri, Jun 08, 2018 at 06:08:19PM -0600, Logan Gunthorpe <logang@deltatee.com> wrote:
>> When remote files are counted in get_files_count, without using SSH,
>> the code returns 0 because there is a colon prepended to $LOC. $VPATH
>> should have been used instead of $LOC.
>>
> 
> Good catch. Thanks for the patch. I discovered this problem myself a few days
> before you sent this patchset. So was going to submit the fix, but you were
> faster.

Thanks. It would be good to get Acked-bys or Reviewed-bys on the patches
you approved.

Logan
