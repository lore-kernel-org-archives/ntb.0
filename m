Return-Path: <jdmason@kudzu.us>
Received: from mail-ua0-x22d.google.com (mail-ua0-x22d.google.com. [2607:f8b0:400c:c08::22d])
        by gmr-mx.google.com with ESMTPS id l140si2527541vke.2.2017.07.17.09.46.52
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jul 2017 09:46:52 -0700 (PDT)
Received: by mail-ua0-x22d.google.com with SMTP id 35so55070949uax.3
        for <linux-ntb@googlegroups.com>; Mon, 17 Jul 2017 09:46:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <296b3d42-ce65-a521-b2de-db3459ac543a@deltatee.com>
References: <20170626195041.6190-1-logang@deltatee.com> <000001d2ef5f$1ed1e750$5c75b5f0$@dell.com>
 <CAPoiz9wapj4qx5pSRhHpNWOiSHKgAXNu6xdVeecBNQEo72U4Xw@mail.gmail.com> <296b3d42-ce65-a521-b2de-db3459ac543a@deltatee.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Mon, 17 Jul 2017 12:46:51 -0400
Message-ID: <CAPoiz9zsGbwRNMTNr_5G_k0adGzPwvCk_pvUhSMkE3nDK+BBrw@mail.gmail.com>
Subject: Re: [PATCH] ntb: use correct mw_count function in ntb_tool and ntb_transport
Content-Type: text/plain; charset="UTF-8"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Allen Hubbe <Allen.Hubbe@dell.com>, linux-ntb@googlegroups.com, linux-kernel <linux-kernel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

On Mon, Jul 17, 2017 at 12:36 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> Hi John,

s/John/Jon

>
>
> On 17/07/17 09:16 AM, Jon Mason wrote:
>> Per your request, this has been applied to my ntb-next branch.
>
> This isn't a huge issue but I meant for this patch to fix the mistake in
> the new ntb_api before it hit 4.13.

NP.  I'll add a "Fixes: ..." to it.  So, it'll get pulled into the
-stable trees.

Thanks,
Jon

>
> On the other hand, seeing there's no way to actually trigger the issue
> until the switchtec driver is merged I guess it's okay to leave it the
> way you did it.
>
> Thanks,
>
> Logan
>
> --
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/296b3d42-ce65-a521-b2de-db3459ac543a%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
