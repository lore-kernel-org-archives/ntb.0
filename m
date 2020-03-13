Return-Path: <fomichev.ru@gmail.com>
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com. [2a00:1450:4864:20::144])
        by gmr-mx.google.com with ESMTPS id l17si491643wmg.0.2020.03.13.01.17.29
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 01:17:29 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id t21so7098423lfe.9
        for <linux-ntb@googlegroups.com>; Fri, 13 Mar 2020 01:17:29 -0700 (PDT)
Return-Path: <fomichev.ru@gmail.com>
Date: Fri, 13 Mar 2020 11:17:27 +0300
From: Alexander Fomichev <fomichev.ru@gmail.com>
Subject: Re: [PATCH RESEND] ntb_hw_switchtec: Fix ntb_mw_clear_trans
 returning error if size == 0
Message-ID: <20200313081727.fs4lfzfbuafo34nk@yadro.com>
References: <20190710084427.7iqrhapxa7jo5v6y@yadro.com>
 <20200122131510.d5ckfj22idh56ef5@yadro.com>
 <20200303123223.i3fvwfmbhklfq2l5@yadro.com>
 <CAPoiz9wAFfxSNh8MZo3N4hxJ9VMbF7qcx2SOOgq_1NDN=iVVQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPoiz9wAFfxSNh8MZo3N4hxJ9VMbF7qcx2SOOgq_1NDN=iVVQQ@mail.gmail.com>
To: Jon Mason <jdmason@kudzu.us>
Cc: linux-ntb <linux-ntb@googlegroups.com>, linux-pci@vger.kernel.org, linux@yadro.com, Logan Gunthorpe <logang@deltatee.com>, Kurt Schwemmer <kurt.schwemmer@microsemi.com>, Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>
List-ID: <linux-ntb.googlegroups.com>

Thank you very much.

Regards,
Alexander.

On Thu, Mar 12, 2020 at 07:39:02PM -0400, Jon Mason wrote:
> On Tue, Mar 3, 2020 at 7:32 AM Alexander Fomichev <fomichev.ru@gmail.com> wrote:
> >
> > Ping?
> 
> Sorry, I missed this somehow  :(
> 
> I just pulled it in and it should be in my github tree in the next hour or so.
> 
> Thanks,
> Jon
> 
> >
> > CC: Jon Mason <jdmason@kudzu.us>
> > CC: Dave Jiang <dave.jiang@intel.com>
> > CC: Allen Hubbe <allenbh@gmail.com>
> > CC: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
> > CC: Logan Gunthorpe <logang@deltatee.com>
> >
> > On Wed, Jan 22, 2020 at 04:15:13PM +0300, Alexander Fomichev wrote:
> > > Somehow this patch was lost. The problem is still actual.
> > > Please, add to upstream.
> > >
> > > On Wed, Jul 10, 2019 at 11:44:27AM +0300, Alexander Fomichev wrote:
> > > > ntb_mw_set_trans should work as ntb_mw_clear_trans when size == 0 and/or
> > > > addr == 0. But error in xlate_pos checking condition prevents this.
> > > > Fix the condition to make ntb_mw_clear_trans working.
> > > >
> > > > Signed-off-by: Alexander Fomichev <fomichev.ru@gmail.com>
> > > > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > > > ---
> > > >  drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> > > > index 1e2f627d3bac..19d46af19650 100644
> > > > --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> > > > +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> > > > @@ -299,7 +299,7 @@ static int switchtec_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
> > > >     if (widx >= switchtec_ntb_mw_count(ntb, pidx))
> > > >             return -EINVAL;
> > > >
> > > > -   if (xlate_pos < 12)
> > > > +   if (size != 0 && xlate_pos < 12)
> > > >             return -EINVAL;
> > > >
> > > >     if (!IS_ALIGNED(addr, BIT_ULL(xlate_pos))) {
> > > > --
> > > > 2.17.1
> > >
> > > --
> > > Regards,
> > >   Alexander

-- 
Regards,
  Alexander
