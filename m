Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id tb8si1173503pab.0.2016.06.07.10.15.52
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jun 2016 10:15:52 -0700 (PDT)
References: <cover.1464986161.git.logang@deltatee.com>
 <efa91cd782ad223cc30eeeda8d2341cc11a8646d.1464986161.git.logang@deltatee.com>
 <20160604154035.GA11597@kudzu.us>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <5757013F.2090401@deltatee.com>
Date: Tue, 7 Jun 2016 11:15:43 -0600
MIME-Version: 1.0
In-Reply-To: <20160604154035.GA11597@kudzu.us>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/3] ntb_transport: Check the number of spads the hardware
 supports
To: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, John Kading <john.kading@gd-ms.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

Hi Jon,

Thanks for the feedback. I'll send an updated patch in a moment.

On 04/06/16 09:40 AM, Jon Mason wrote:
> Nit, please add spaces around '*' (per checkpatch)

I'll change this, but I did run it through checkpatch and it did not
warn about this.

> Please explicitly point out that this is being modified in the commit
> message.  I don't see them being used, so probably not a big deal
> (unless Dave Jiang has something queued that will use it).

Done. I feel like he can always add them back in when he adds the
functionality. This way, when he does, MAX_SPAD will be updated and the
check will still be correct.

> Move this check above the dev_to_node assignment above.

Done.


Logan
