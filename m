Return-Path: <jdmason@kudzu.us>
Received: from mail-yw0-x244.google.com (mail-yw0-x244.google.com. [2607:f8b0:4002:c05::244])
        by gmr-mx.google.com with ESMTPS id s3-v6si870180qkb.4.2018.05.21.17.35.33
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 May 2018 17:35:33 -0700 (PDT)
Received: by mail-yw0-x244.google.com with SMTP id l142-v6so5030729ywc.11
        for <linux-ntb@googlegroups.com>; Mon, 21 May 2018 17:35:33 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Mon, 21 May 2018 20:35:31 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH 6/9] NTB: ntb_hw_idt: fix typo 'can by' to 'can be'
Message-ID: <20180522003531.GB3255@kudzu.us>
References: <20180506112404.24872-1-wsa+renesas@sang-engineering.com>
 <20180506112404.24872-7-wsa+renesas@sang-engineering.com>
 <20180511131236.GA24717@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511131236.GA24717@mobilestation>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, trivial@kernel.org, linux-renesas-soc@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Fri, May 11, 2018 at 04:12:36PM +0300, Serge Semin wrote:
> On Sun, May 06, 2018 at 01:23:50PM +0200, Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> >  drivers/ntb/hw/idt/ntb_hw_idt.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> > index 8d98872d0983b7..dbe72f116017ab 100644
> > --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> > +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> > @@ -1401,7 +1401,7 @@ static int idt_ntb_peer_mw_clear_trans(struct ntb_dev *ntb, int pidx,
> >   *                          5. Doorbell operations
> >   *
> >   *    Doorbell functionality of IDT PCIe-switches is pretty unusual. First of
> > - * all there is global doorbell register which state can by changed by any
> > + * all there is global doorbell register which state can be changed by any
> >   * NT-function of the IDT device in accordance with global permissions. These
> >   * permissions configs are not supported by NTB API, so it must be done by
> >   * either BIOS or EEPROM settings. In the same way the state of the global
> 
> Acked-by: Serge Semin <fancer.lancer@gmail.com>

Applied to my ntb-next branch.

Thanks,
Jon


> 
> > -- 
> > 2.11.0
> > 
