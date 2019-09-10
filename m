Return-Path: <jdmason@kudzu.us>
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com. [2607:f8b0:4864:20::d44])
        by gmr-mx.google.com with ESMTPS id g21si818381qkm.5.2019.09.10.09.41.33
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2019 09:41:33 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id r8so14065535iol.10
        for <linux-ntb@googlegroups.com>; Tue, 10 Sep 2019 09:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190716173448.eswemneatvjwnxny@yadro.com> <9428e069-19dd-d020-1a47-f33d99bd01ac@deltatee.com>
In-Reply-To: <9428e069-19dd-d020-1a47-f33d99bd01ac@deltatee.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Tue, 10 Sep 2019 17:41:23 +0100
Message-ID: <CAPoiz9x4Gb6hZg3GBfOjw_zMShOJHmXGmCOm2Nj+-vCaOzDCMg@mail.gmail.com>
Subject: Re: [PATCH] ntb_hw_switchtec: make ntb_mw_set_trans() work when addr
 == 0
Content-Type: text/plain; charset="UTF-8"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Alexander Fomichev <fomichev.ru@gmail.com>, linux-ntb <linux-ntb@googlegroups.com>, linux-pci@vger.kernel.org, Allen Hubbe <allenbh@gmail.com>, linux@yadro.com
List-ID: <linux-ntb.googlegroups.com>

On Tue, Jul 16, 2019 at 6:41 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2019-07-16 11:34 a.m., Alexander Fomichev wrote:
> > On switchtec_ntb_mw_set_trans() call, when (only) address == 0, it acts as
> > ntb_mw_clear_trans(). Fix this, since address == 0 and size != 0 is valid
> > combination for setting translation.
> >
> > Signed-off-by: Alexander Fomichev <fomichev.ru@gmail.com>
>
> Looks good, thanks.
>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Applied to ntb-next, thanks

>
> > ---
> >  drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> > index db49677..45b9513 100644
> > --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> > +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> > @@ -305,7 +305,7 @@ static int switchtec_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
> >       if (rc)
> >               return rc;
> >
> > -     if (addr == 0 || size == 0) {
> > +     if (size == 0) {
> >               if (widx < nr_direct_mw)
> >                       switchtec_ntb_mw_clr_direct(sndev, widx);
> >               else
> >
