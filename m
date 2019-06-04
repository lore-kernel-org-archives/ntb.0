Return-Path: <epilmore@gigaio.com>
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com. [2a00:1450:4864:20::336])
        by gmr-mx.google.com with ESMTPS id n20si264198ljg.0.2019.06.04.14.16.06
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 14:16:06 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id v19so170331wmj.5
        for <linux-ntb@googlegroups.com>; Tue, 04 Jun 2019 14:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQPn8sX2G-Db-ZiFpP2SMKbkQnPyk63UZijAY0we+DoZsmDtQ@mail.gmail.com>
 <CAADLhr49ke_3s25gW11qZ+H-Jjje-E00WMHiMDbKU=mcCQtb3g@mail.gmail.com>
 <cdcd00e9-056b-3364-cfbc-5bcb5bcff91e@amd.com> <CAOQPn8sQ+B97UptHpxJgdmcMxBZrqGynQR8qTc3q77fAODRH-A@mail.gmail.com>
 <8e4ccf44-9e4f-8007-ddcc-431440f9d533@amd.com>
In-Reply-To: <8e4ccf44-9e4f-8007-ddcc-431440f9d533@amd.com>
From: Eric Pilmore <epilmore@gigaio.com>
Date: Tue, 4 Jun 2019 14:15:54 -0700
Message-ID: <CAOQPn8vE4SbDBt_fu3YsqysHspjZ9rumsDHT9RQe+ZT7HUfKCQ@mail.gmail.com>
Subject: Re: Fwd: AMD IO_PAGE_FAULT w/NTB on Write ops?
Content-Type: text/plain; charset="UTF-8"
To: Gary R Hook <ghook@amd.com>
Cc: "Mehta, Sanju" <Sanju.Mehta@amd.com>, S Taylor <staylor@gigaio.com>, D Meyer <dmeyer@gigaio.com>, linux-ntb <linux-ntb@googlegroups.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Thu, May 9, 2019 at 1:03 PM Gary R Hook <ghook@amd.com> wrote:
>
> On 4/24/19 5:04 PM, Eric Pilmore wrote:
> >
> > Thanks the for the response.  We are using the correct device for the
> > dma_alloc_coherent(). Upon further investigation what we are finding
> > is that apparently the AMD IOMMU support can only manage one alias, as
> > opposed to Intel IOMMU support which can support multiple. Not clear
> > at this time if it's a software limitation in the AMD IOMMU kernel
> > support or an imposed limitation of the hardware. Still investigating.
>
> Please define 'alias'?

Hi Gary,

I appreciate the response. Sorry for the late reply. Got sidetracked
with other stuff.

I will try to answer this as best I can. Sorry if my terminology might
be off as I'm still a relative newbie with some of this.

The "alias" is basically another BDF (or ProxyID) that wants to be
associated with the same IOMMU resources as some primary BDF.
Reference <drivers/pci/quirks.c>. In the scenario that we have we are
utilizing NTB and through this bridge will come requests (TLPs) that
will not necessarily have the ReqID as the BDF of the switch device
that contains this bridge. Instead, the ReqID will be a "translated"
(Proxy) BDF of sourcing devices on the other side of the
Non-Transparent Bridge. In our case our NTB is a Switchtec device and
the quirk quirk_switchtec_ntb_dma_alias() is used as a means of
associating these aliases (aka ProxyID or Translated ReqID) with the
NT endpoint in the local host. On Xeon platforms, the framework
supports allowing multiple aliases to be defined for a particular
IOMMU and everything works great. However, with the AMD cpu, it
appears the IOMMU framework is only accepting just one alias. Note
Logan's earlier response @ Mon, Apr 22, 10:31 AM. In our case the one
that is accepted is via the path for a processor Read, but Processor
Writes go through a slightly different path resulting in a different
ReqID. As Logan points out it seems since the AMD IOMMU code is only
accepting one alias, the Write ReqID looks foreign and thus results in
the IOMMU faults.

>
> The IO_PAGE_FAULT error is described on page 142 of the AMD IOMMU spec,
> document #48882. Easily found via a search.
>
> The flags value of 0x0070 translates to PE, RW, PR. The page was
> present, the transaction was a write, and the peripheral didn't have
> permission. That implies that mapping hadn't been done.
>
> Not being sure how that device presents, or what you're doing with IVHD
> info, I can't comment further. I can say that the AMD IOMMU provides for
> a single exclusion range, but as many unity ranges as you wish.

I'm currently not doing anything with IVHD. The devices on the other
side of the NTB that need to be aliased can be anything from a remote
Host processor, NVMe drive, GPU, etc., anything that wants to send a
memory transaction to the local host.

If you have any insight into how the AMD IOMMU support in the kernel
could be extended for multiple aliases, or whether there is a hardware
limitation that restricts it to just one, that would be greatly
appreciated.

Thanks,
Eric




-- 
Eric Pilmore
epilmore@gigaio.com
http://gigaio.com
Phone: (858) 775 2514

This e-mail message is intended only for the individual(s) to whom
it is addressed and may contain information that is privileged,
confidential, proprietary, or otherwise exempt from disclosure under
applicable law. If you believe you have received this message in
error, please advise the sender by return e-mail and delete it from
your mailbox.
Thank you.
