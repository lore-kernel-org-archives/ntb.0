Return-Path: <jdmason@kudzu.us>
Received: from mail-yw1-xc42.google.com (mail-yw1-xc42.google.com. [2607:f8b0:4864:20::c42])
        by gmr-mx.google.com with ESMTPS id s138-v6si1531651pgs.1.2018.10.31.13.39.55
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 13:39:55 -0700 (PDT)
Received: by mail-yw1-xc42.google.com with SMTP id i185-v6so7039041ywa.12
        for <linux-ntb@googlegroups.com>; Wed, 31 Oct 2018 13:39:55 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Wed, 31 Oct 2018 16:39:52 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] ntb: ntb_transport: Mark expected switch fall-throughs
Message-ID: <20181031203951.GC22474@kudzu.us>
References: <20181005071234.GA8803@embeddedor.com>
 <CAJ80sasrMXyC4jDGG+-wDLLXSApM6-HdgmgGwNMtH7AMwPdCUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ80sasrMXyC4jDGG+-wDLLXSApM6-HdgmgGwNMtH7AMwPdCUg@mail.gmail.com>
To: Allen Hubbe <allenbh@gmail.com>
Cc: gustavo@embeddedor.com, dave.jiang@intel.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Fri, Oct 05, 2018 at 01:03:01PM -0400, Allen Hubbe wrote:
> On Fri, Oct 5, 2018 at 3:12 AM Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
> > In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> > where we are expecting to fall through.
> >
> > Addresses-Coverity-ID: 1373888 ("Missing break in switch")
> > Addresses-Coverity-ID: 1373889 ("Missing break in switch")
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Acked-by: Allen Hubbe <allenbh@gmail.com>

Applied

Thanks,
Jon

> 
> > ---
> >  drivers/ntb/ntb_transport.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index 9398959..c643b9c 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> > @@ -1278,6 +1278,7 @@ static void ntb_rx_copy_callback(void *data,
> >                 case DMA_TRANS_READ_FAILED:
> >                 case DMA_TRANS_WRITE_FAILED:
> >                         entry->errors++;
> > +                       /* fall through */
> >                 case DMA_TRANS_ABORTED:
> >                 {
> >                         struct ntb_transport_qp *qp = entry->qp;
> > @@ -1533,6 +1534,7 @@ static void ntb_tx_copy_callback(void *data,
> >                 case DMA_TRANS_READ_FAILED:
> >                 case DMA_TRANS_WRITE_FAILED:
> >                         entry->errors++;
> > +                       /* fall through */
> >                 case DMA_TRANS_ABORTED:
> >                 {
> >                         void __iomem *offset =
> > --
> > 2.7.4
