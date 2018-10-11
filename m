Return-Path: <allenbh@gmail.com>
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com. [2a00:1450:4864:20::22f])
        by gmr-mx.google.com with ESMTPS id h20-v6si282939ljj.5.2018.10.10.19.50.40
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 19:50:40 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id j17-v6so6794233lja.1
        for <linux-ntb@googlegroups.com>; Wed, 10 Oct 2018 19:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <8C51E45097385D46B526390C84E223A34EE561EB@MX202CL01.corp.emc.com> <762f4d04-b879-8e71-483d-3cd9310185eb@intel.com>
In-Reply-To: <762f4d04-b879-8e71-483d-3cd9310185eb@intel.com>
From: Allen Hubbe <allenbh@gmail.com>
Date: Wed, 10 Oct 2018 22:50:28 -0400
Message-ID: <CAJ80savJ4DZw4SvKaatR7ZU8ML0ncMRH+t_sMLewUsaoVHQE7g@mail.gmail.com>
Subject: Re: Inbound translation setting failure in coherent allocation
Content-Type: text/plain; charset="UTF-8"
To: dave.jiang@intel.com
Cc: Omer.Margolin@dell.com, linux-ntb@googlegroups.com, fancer.lancer@gmail.com, Boris.Glimcher@dell.com, Ishay.Zekri@dell.com
List-ID: <linux-ntb.googlegroups.com>

On Wed, Oct 10, 2018 at 11:55 AM Dave Jiang <dave.jiang@intel.com> wrote:
> On 10/10/2018 06:11 AM, Margolin, Omer wrote:
> > Hello,
> >
> > Trying to evaluate the raw performance of Intel NTB using ntb_perf test
> > tool we get a failure in coherent allocation.
> >
> > response from Dave Jiang dave.jiang@intel.com <mailto:dave.jiang@intel.com>:
> > "Hello. Upstream has been making quite a bit of changes recently to
> > ntb_perf. If it's failing for you can you please post it to the ntb
> > mailing list and inquire there? Hopefully it's just something Sergei did
> > and he can help you fix. Thanks!"
> >
> > Sergei can you please check if this is a result of latest changes?
> >
> >
> >
> > Details:
> >
> > ntb_perf module was loaded using the command below on both sides of the
> > NTB connection:
> > modprobe ntb_hw_intel b2b_mw_idx=0 b2b_mw_share=0 dyndbg=+pmfl
> >
> > Failure in setting inbuf translation.
> > [ 553.816242] ntb_perf 0000:82:00.0: Failed to set inbuf translation
>
> Serge,
> This is odd because the Intel driver does not have peer_mw_set_trans().
> It should've just returned 0. Thoughts?

It's failing for mw_set_trans, not peer_mw_set_trans.  The intel
driver does have this method.

> > Using the MW (allocation and translation) works using ntb_tool


The ntb tool has this: note same widx param in both calls.

ret = ntb_mw_get_align(tc->ntb, pidx, widx, &addr_align, &size_align, &size);
...
ret = ntb_mw_set_trans(tc->ntb, pidx, widx, inmw->dma_base, inmw->size);
https://elixir.bootlin.com/linux/latest/source/drivers/ntb/test/ntb_tool.c#L585


But ntb perf has this: note the difference with perf->gidx vs
peer->gidx, third parameter.

ret = ntb_mw_get_align(perf->ntb, peer->pidx, perf->gidx, &xlat_align,
&size_align, &size_max);
...
ret = ntb_mw_set_trans(perf->ntb, peer->pidx, peer->gidx,
peer->inbuf_xlat, peer->inbuf_size);
https://elixir.bootlin.com/linux/latest/source/drivers/ntb/test/ntb_perf.c#L574


It may be that in ntb perf the size and alignment requirements of one
window are being applied to another window, so that validation fails
in the intel ntb driver.

Try changing perf->gidx to peer->gidx (I think, or vice versa if that
doesn't work).  If it works can you send a patch?

Allen
