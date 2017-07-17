Return-Path: <jdmason@kudzu.us>
Received: from mail-ua0-x232.google.com (mail-ua0-x232.google.com. [2607:f8b0:400c:c08::232])
        by gmr-mx.google.com with ESMTPS id p83si2454892vkd.1.2017.07.17.09.52.45
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jul 2017 09:52:45 -0700 (PDT)
Received: by mail-ua0-x232.google.com with SMTP id b64so31602934uab.0
        for <linux-ntb@googlegroups.com>; Mon, 17 Jul 2017 09:52:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ce6f1995-0a1b-d0cc-4ef8-77fc1791f557@deltatee.com>
References: <20170626195041.6190-1-logang@deltatee.com> <000001d2ef5f$1ed1e750$5c75b5f0$@dell.com>
 <CAPoiz9wapj4qx5pSRhHpNWOiSHKgAXNu6xdVeecBNQEo72U4Xw@mail.gmail.com>
 <296b3d42-ce65-a521-b2de-db3459ac543a@deltatee.com> <CAPoiz9zsGbwRNMTNr_5G_k0adGzPwvCk_pvUhSMkE3nDK+BBrw@mail.gmail.com>
 <ce6f1995-0a1b-d0cc-4ef8-77fc1791f557@deltatee.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Mon, 17 Jul 2017 12:52:44 -0400
Message-ID: <CAPoiz9wxsaRUaxxNqtzPpAEsVhQdDp5M9aJ3d6OPz=0jKAsUGw@mail.gmail.com>
Subject: Re: [PATCH] ntb: use correct mw_count function in ntb_tool and ntb_transport
Content-Type: text/plain; charset="UTF-8"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Allen Hubbe <Allen.Hubbe@dell.com>, linux-ntb@googlegroups.com, linux-kernel <linux-kernel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

On Mon, Jul 17, 2017 at 12:50 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
> On 17/07/17 10:46 AM, Jon Mason wrote:
>> s/John/Jon
>
> Apologies. Monday morning -- not fully awake yet.
>
>> NP.  I'll add a "Fixes: ..." to it.  So, it'll get pulled into the
>> -stable trees.
>
> Ok, thanks, but it's not really the stable trees that need to see it
> seeing 4.13 isn't released yet, it would just need to get into a
> subsequent rc....

Yeah, I'm looking at this more now and I agree.  It should go in
v4.13-rcX.  I'll move this to my ntb branch for this purpose and wait
to see if any more bug fixes are coming in the next couple of weeks
(before I push it).

Thanks for the patch, and sorry about the confusion :)

Thanks,
Jon

> Logan
>
> --
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/ce6f1995-0a1b-d0cc-4ef8-77fc1791f557%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
