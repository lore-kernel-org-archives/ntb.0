Return-Path: <jdmason@kudzu.us>
Received: from mail-vk0-x242.google.com (mail-vk0-x242.google.com. [2607:f8b0:400c:c05::242])
        by gmr-mx.google.com with ESMTPS id o79si115602vkf.4.2017.06.09.14.56.21
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jun 2017 14:56:21 -0700 (PDT)
Received: by mail-vk0-x242.google.com with SMTP id c185so4571827vkd.0
        for <linux-ntb@googlegroups.com>; Fri, 09 Jun 2017 14:56:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9fa5c040-3e67-4f0b-accb-5905aa1de6f0@deltatee.com>
References: <20170605200053.6912-1-logang@deltatee.com> <000001d2dec6$0531db10$0f959130$@dell.com>
 <20170609211236.GE9847@kudzu.us> <9fa5c040-3e67-4f0b-accb-5905aa1de6f0@deltatee.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Fri, 9 Jun 2017 17:56:20 -0400
Message-ID: <CAPoiz9zkcMpdzTc=K31nf_Z8o8Zmy4Te8ztAP24FuO2E8Ouuhg@mail.gmail.com>
Subject: Re: [PATCH] ntb_netdev: set the net_device's parent
Content-Type: text/plain; charset="UTF-8"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Allen Hubbe <Allen.Hubbe@dell.com>, linux-ntb@googlegroups.com, Dave Jiang <dave.jiang@intel.com>
List-ID: <linux-ntb.googlegroups.com>

On Fri, Jun 9, 2017 at 5:51 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
> On 09/06/17 03:12 PM, Jon Mason wrote:
>> Adding to my ntb branch with the following line:
>> Fixes: a9c59ef77458 ("ntb_test: Add a selftest script for the NTB subsystem")
>
> Thanks Jon! But you might have gotten confused here... This particular
> patch doesn't fix ntb_test, but I sent a different one that does which
> you have not merged yet.

Oops, I replied to the wrong one.  Sorry.  Everything of yours should
be moved in the ntb or ntb-next branches.  Please double check me and
resend if it is not present.

>
> Logan
>
> --
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/9fa5c040-3e67-4f0b-accb-5905aa1de6f0%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
